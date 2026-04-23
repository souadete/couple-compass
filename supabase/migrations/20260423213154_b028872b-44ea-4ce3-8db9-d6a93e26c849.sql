CREATE OR REPLACE FUNCTION public.submit_quiz(
  p_first_name TEXT,
  p_email TEXT,
  p_consent_given BOOLEAN,
  p_answers JSONB,
  p_archetype TEXT,
  p_scores JSONB,
  p_percentages JSONB,
  p_language TEXT DEFAULT 'fr',
  p_user_agent TEXT DEFAULT NULL,
  p_referrer TEXT DEFAULT NULL
) RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_id UUID;
BEGIN
  IF NOT p_consent_given THEN
    RAISE EXCEPTION 'Consent required';
  END IF;

  IF char_length(p_first_name) < 1 OR char_length(p_first_name) > 80 THEN
    RAISE EXCEPTION 'Invalid first name';
  END IF;

  IF char_length(p_email) < 3 OR char_length(p_email) > 255 THEN
    RAISE EXCEPTION 'Invalid email';
  END IF;

  INSERT INTO public.quiz_submissions
    (first_name, email, consent_given, answers, archetype,
     scores, percentages, language, user_agent, referrer)
  VALUES
    (p_first_name, p_email, p_consent_given, p_answers, p_archetype,
     p_scores, p_percentages, p_language, p_user_agent, p_referrer)
  RETURNING id INTO v_id;

  RETURN v_id;
END;
$$;

REVOKE ALL ON FUNCTION public.submit_quiz(
  TEXT, TEXT, BOOLEAN, JSONB, TEXT, JSONB, JSONB, TEXT, TEXT, TEXT
) FROM PUBLIC;

GRANT EXECUTE ON FUNCTION public.submit_quiz(
  TEXT, TEXT, BOOLEAN, JSONB, TEXT, JSONB, JSONB, TEXT, TEXT, TEXT
) TO anon, authenticated;

NOTIFY pgrst, 'reload schema';