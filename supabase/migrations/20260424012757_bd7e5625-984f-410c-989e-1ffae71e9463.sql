-- Quiz V2 — Email queue + scheduling for Resend-based sends
CREATE TABLE IF NOT EXISTS public.quiz_v2_email_queue (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  submission_id UUID NOT NULL REFERENCES public.quiz_submissions(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  first_name TEXT NOT NULL,
  archetype TEXT NOT NULL,
  mail_code TEXT NOT NULL,
  day_delay INT NOT NULL,
  send_at TIMESTAMPTZ NOT NULL,
  sent_at TIMESTAMPTZ,
  resend_message_id TEXT,
  unsub_token TEXT NOT NULL UNIQUE DEFAULT encode(gen_random_bytes(24), 'base64'),
  unsubscribed_at TIMESTAMPTZ,
  error_message TEXT,
  attempt_count INT NOT NULL DEFAULT 0,
  last_attempt_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (submission_id, mail_code)
);

CREATE INDEX IF NOT EXISTS qv2q_ready_idx
  ON public.quiz_v2_email_queue (send_at)
  WHERE sent_at IS NULL AND unsubscribed_at IS NULL;

CREATE INDEX IF NOT EXISTS qv2q_unsub_email_idx
  ON public.quiz_v2_email_queue (email)
  WHERE unsubscribed_at IS NOT NULL;

ALTER TABLE public.quiz_v2_email_queue ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION public.enqueue_quiz_v2_emails(p_submission_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_sub RECORD;
  v_delays INT[] := ARRAY[0, 2, 5, 9, 12];
  v_archetype_seq INT;
  v_delay INT;
  v_mail_idx INT;
  v_mail_code TEXT;
  v_inserted INT := 0;
BEGIN
  SELECT first_name, email, archetype, created_at, consent_given
    INTO v_sub FROM public.quiz_submissions WHERE id = p_submission_id;

  IF NOT FOUND THEN RAISE EXCEPTION 'Submission % not found', p_submission_id; END IF;
  IF NOT v_sub.consent_given THEN RAISE EXCEPTION 'Consent not given'; END IF;

  v_archetype_seq := CASE v_sub.archetype
    WHEN 'silencieux'          THEN 1
    WHEN 'eloignes'            THEN 2
    WHEN 'debordes'            THEN 3
    WHEN 'en-construction'     THEN 4
    WHEN 'complices-fatigues'  THEN 5
    WHEN 'survivants'          THEN 6
    ELSE NULL
  END;
  IF v_archetype_seq IS NULL THEN
    RAISE EXCEPTION 'Unknown archetype: %', v_sub.archetype;
  END IF;

  FOR v_mail_idx IN 1..5 LOOP
    v_delay := v_delays[v_mail_idx];
    v_mail_code := 'M' || v_archetype_seq::TEXT || '.' || v_mail_idx::TEXT;
    INSERT INTO public.quiz_v2_email_queue
      (submission_id, email, first_name, archetype, mail_code, day_delay, send_at)
    VALUES
      (p_submission_id, v_sub.email, v_sub.first_name, v_sub.archetype,
       v_mail_code, v_delay, v_sub.created_at + (v_delay || ' days')::INTERVAL)
    ON CONFLICT (submission_id, mail_code) DO NOTHING;
    GET DIAGNOSTICS v_inserted = ROW_COUNT;
  END LOOP;

  RETURN v_inserted;
END;
$$;

REVOKE ALL ON FUNCTION public.enqueue_quiz_v2_emails(UUID) FROM PUBLIC;

CREATE OR REPLACE FUNCTION public.get_quiz_v2_ready_emails(p_limit INT DEFAULT 50)
RETURNS TABLE (
  id UUID,
  submission_id UUID,
  email TEXT,
  first_name TEXT,
  archetype TEXT,
  mail_code TEXT,
  day_delay INT,
  send_at TIMESTAMPTZ,
  unsub_token TEXT,
  attempt_count INT
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT q.id, q.submission_id, q.email, q.first_name, q.archetype,
         q.mail_code, q.day_delay, q.send_at, q.unsub_token, q.attempt_count
  FROM public.quiz_v2_email_queue q
  WHERE q.send_at <= now()
    AND q.sent_at IS NULL
    AND q.unsubscribed_at IS NULL
    AND q.attempt_count < 5
    AND NOT EXISTS (
      SELECT 1 FROM public.quiz_v2_email_queue u
      WHERE u.email = q.email AND u.unsubscribed_at IS NOT NULL
    )
  ORDER BY q.send_at ASC
  LIMIT p_limit;
$$;

REVOKE ALL ON FUNCTION public.get_quiz_v2_ready_emails(INT) FROM PUBLIC;

CREATE OR REPLACE FUNCTION public.mark_quiz_v2_email_sent(
  p_id UUID, p_resend_message_id TEXT
) RETURNS VOID
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  UPDATE public.quiz_v2_email_queue
     SET sent_at = now(),
         resend_message_id = p_resend_message_id,
         last_attempt_at = now(),
         attempt_count = attempt_count + 1,
         error_message = NULL
   WHERE id = p_id;
$$;

REVOKE ALL ON FUNCTION public.mark_quiz_v2_email_sent(UUID, TEXT) FROM PUBLIC;

CREATE OR REPLACE FUNCTION public.mark_quiz_v2_email_failed(
  p_id UUID, p_error TEXT
) RETURNS VOID
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  UPDATE public.quiz_v2_email_queue
     SET last_attempt_at = now(),
         attempt_count = attempt_count + 1,
         error_message = p_error
   WHERE id = p_id;
$$;

REVOKE ALL ON FUNCTION public.mark_quiz_v2_email_failed(UUID, TEXT) FROM PUBLIC;

CREATE OR REPLACE FUNCTION public.unsubscribe_quiz_v2_by_token(p_token TEXT)
RETURNS TABLE (affected_email TEXT, affected_rows INT)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_email TEXT;
  v_count INT;
BEGIN
  SELECT email INTO v_email
  FROM public.quiz_v2_email_queue WHERE unsub_token = p_token LIMIT 1;

  IF v_email IS NULL THEN
    RETURN QUERY SELECT NULL::TEXT, 0;
    RETURN;
  END IF;

  UPDATE public.quiz_v2_email_queue
     SET unsubscribed_at = now()
   WHERE email = v_email AND unsubscribed_at IS NULL;
  GET DIAGNOSTICS v_count = ROW_COUNT;
  RETURN QUERY SELECT v_email, v_count;
END;
$$;

REVOKE ALL ON FUNCTION public.unsubscribe_quiz_v2_by_token(TEXT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.unsubscribe_quiz_v2_by_token(TEXT) TO anon, authenticated;

CREATE OR REPLACE FUNCTION public.get_quiz_v2_email_stats()
RETURNS JSON
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT json_build_object(
    'queued_total',       (SELECT count(*) FROM public.quiz_v2_email_queue WHERE sent_at IS NULL AND unsubscribed_at IS NULL),
    'sent_total',         (SELECT count(*) FROM public.quiz_v2_email_queue WHERE sent_at IS NOT NULL),
    'unsubscribed_total', (SELECT count(DISTINCT email) FROM public.quiz_v2_email_queue WHERE unsubscribed_at IS NOT NULL),
    'failed_total',       (SELECT count(*) FROM public.quiz_v2_email_queue WHERE attempt_count >= 5 AND sent_at IS NULL),
    'by_mail_code',       (SELECT json_object_agg(mail_code, c) FROM (
                             SELECT mail_code, count(*) c FROM public.quiz_v2_email_queue
                             WHERE sent_at IS NOT NULL GROUP BY mail_code ORDER BY mail_code
                           ) t),
    'next_send_at',       (SELECT min(send_at) FROM public.quiz_v2_email_queue WHERE sent_at IS NULL AND unsubscribed_at IS NULL)
  );
$$;

REVOKE ALL ON FUNCTION public.get_quiz_v2_email_stats() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_quiz_v2_email_stats() TO anon, authenticated;

NOTIFY pgrst, 'reload schema';