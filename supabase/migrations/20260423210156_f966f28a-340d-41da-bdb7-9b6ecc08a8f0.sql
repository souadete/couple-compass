DROP POLICY IF EXISTS "anon_insert_quiz_submissions_with_consent" ON public.quiz_submissions;
DROP POLICY IF EXISTS "Anyone can submit a quiz with consent" ON public.quiz_submissions;
CREATE POLICY "quiz_anon_insert"
ON public.quiz_submissions
FOR INSERT
TO anon, authenticated
WITH CHECK (consent_given = true);