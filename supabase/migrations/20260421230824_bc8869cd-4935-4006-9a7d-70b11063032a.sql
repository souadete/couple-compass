-- Quiz submissions: anonymous users can insert, but no one can read/update/delete from the client.
CREATE TABLE public.quiz_submissions (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  first_name TEXT NOT NULL CHECK (char_length(first_name) BETWEEN 1 AND 80),
  email TEXT NOT NULL CHECK (char_length(email) BETWEEN 3 AND 255),
  consent_given BOOLEAN NOT NULL DEFAULT false,
  answers JSONB NOT NULL,
  archetype TEXT NOT NULL,
  scores JSONB NOT NULL,
  percentages JSONB NOT NULL,
  language TEXT NOT NULL DEFAULT 'fr',
  user_agent TEXT,
  referrer TEXT,
  webhook_status TEXT NOT NULL DEFAULT 'pending',
  webhook_attempted_at TIMESTAMP WITH TIME ZONE,
  webhook_response TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

ALTER TABLE public.quiz_submissions ENABLE ROW LEVEL SECURITY;

-- Allow anonymous + authenticated to insert their own submission, but only when consent is given.
CREATE POLICY "Anyone can submit a quiz with consent"
ON public.quiz_submissions
FOR INSERT
TO anon, authenticated
WITH CHECK (consent_given = true);

-- No SELECT/UPDATE/DELETE policies → reads are blocked from the client.
-- Server side (edge function + n8n) uses the service role and bypasses RLS.

CREATE INDEX quiz_submissions_created_at_idx ON public.quiz_submissions (created_at DESC);
CREATE INDEX quiz_submissions_email_idx ON public.quiz_submissions (email);
