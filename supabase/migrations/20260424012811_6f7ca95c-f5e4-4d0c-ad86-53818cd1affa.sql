CREATE TABLE IF NOT EXISTS public.quiz_v2_email_templates (
  mail_code TEXT NOT NULL PRIMARY KEY,
  archetype TEXT NOT NULL,
  day_delay INT NOT NULL,
  subject TEXT NOT NULL,
  preheader TEXT,
  html TEXT NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE public.quiz_v2_email_templates ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION public.get_quiz_v2_email_template(p_mail_code TEXT)
RETURNS TABLE (mail_code TEXT, subject TEXT, preheader TEXT, html TEXT)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT t.mail_code, t.subject, t.preheader, t.html
  FROM public.quiz_v2_email_templates t
  WHERE t.mail_code = p_mail_code;
$$;

REVOKE ALL ON FUNCTION public.get_quiz_v2_email_template(TEXT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_quiz_v2_email_template(TEXT) TO anon, authenticated;

NOTIFY pgrst, 'reload schema';