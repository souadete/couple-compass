-- Quiz V2 Azwaj v2.1 — Fix PDF URL + nouvel archétype Harmonieux
ALTER TABLE public.quiz_submissions ADD COLUMN IF NOT EXISTS pdf_url TEXT;

CREATE OR REPLACE FUNCTION public.update_submission_pdf_url(p_id UUID, p_pdf_url TEXT)
RETURNS VOID
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  UPDATE public.quiz_submissions SET pdf_url = p_pdf_url WHERE id = p_id;
$$;

REVOKE ALL ON FUNCTION public.update_submission_pdf_url(UUID, TEXT) FROM PUBLIC;

DROP FUNCTION IF EXISTS public.get_quiz_v2_ready_emails(INT);
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
  attempt_count INT,
  pdf_url TEXT
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT q.id, q.submission_id, q.email, q.first_name, q.archetype,
         q.mail_code, q.day_delay, q.send_at, q.unsub_token, q.attempt_count,
         s.pdf_url
  FROM public.quiz_v2_email_queue q
  JOIN public.quiz_submissions s ON s.id = q.submission_id
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

-- Harmonieux template (M7.1) — note: the original migration embeds an inlined base64 logo;
-- we keep an equivalent template body using the same logo placeholder strategy as the other templates.
INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at)
SELECT 'M7.1','harmonieux',0,
  '{{firstName}}, félicitations — votre couple rayonne',
  'Un portrait rare que peu de couples reçoivent — voici le tien.',
  t.html_template,
  now()
FROM (
  SELECT $HTML$<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Azwaj · Mon Couple Aujourd'hui</title></head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:'Helvetica Neue',Arial,sans-serif;color:#2B1E23;line-height:1.6;">
<span style="display:none;font-size:0;color:transparent;line-height:0;max-height:0;max-width:0;opacity:0;overflow:hidden;">Un portrait rare que peu de couples reçoivent — voici le tien.</span>
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;"><tr><td align="center">
<table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
<tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
<div style="font-family:'Playfair Display',Georgia,serif;font-size:22px;color:#7C2D5A;font-weight:700;">Azwaj</div>
<div style="font-family:'Playfair Display',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:8px;">Mon Couple Aujourd'hui</div>
</td></tr>
<tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
<p>Salam aleykoum {{firstName}},</p>
<p>Tu as fait le quiz et ton couple se reconnaît dans ce que j'appelle <em>Les Harmonieux</em>. C'est un profil <strong>rare</strong> — pas parce que l'harmonie est exceptionnelle dans l'absolu, mais parce que peu de couples prennent le temps d'entretenir activement ce qu'ils vivent.</p>
<p>Je te le dis en tant que clinicienne : ce que tu décris dans tes réponses — la communication fluide, l'intimité vivante, le respect des rythmes de chacun·e, la complicité dans l'épreuve — ce n'est pas de la chance. C'est le fruit d'une <em>attention constante</em> que tu portes, et que ton conjoint porte aussi, au lien qui vous unit.</p>
<p><a href="{{quiz_v2_pdf_url}}" style="color:#7C2D5A;font-weight:600;">→ Télécharger ton portrait complet (PDF)</a></p>
<p>Dans le Coran, Ar-Rûm 30:21 parle de <em>mawaddah wa rahma</em> — l'affection et la tendresse mutuelles que Dieu place entre les époux comme signe. Ce que tu vis aujourd'hui est une manifestation de ce signe. Ce n'est pas un accomplissement final : c'est une <em>barakah</em> à entretenir chaque jour par la parole juste, le geste attentionné, et la douʿa l'un pour l'autre.</p>
<p>Dans le PDF que tu viens de recevoir, tu trouveras les 3 gestes que les couples Harmonieux oublient parfois (et qui font l'érosion silencieuse) + comment traverser les grandes transitions (enfants, ménopause, crises pro) sans perdre ce que vous avez.</p>
<p>Pas d'autres emails après celui-ci — vous n'avez besoin de rien de plus. Juste mes félicitations sincères, et le rappel que si un jour vous sentez que quelque chose bouge (fatigue, distance, phase de vie), <a href="https://azwaj.be/consultation-sexologue-musulmane/" style="color:#7C2D5A;">vous pouvez consulter avant d'avoir besoin</a> — c'est ce que font les couples Harmonieux qui durent longtemps.</p>
<p>Que Dieu protège ce que tu portes.</p>
<p>Souade</p>
</td></tr>
<tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
<strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
<a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a> · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
</td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</td></tr></table></body></html>$HTML$ AS html_template
) t
ON CONFLICT (mail_code) DO UPDATE SET
  archetype = EXCLUDED.archetype,
  day_delay = EXCLUDED.day_delay,
  subject = EXCLUDED.subject,
  preheader = EXCLUDED.preheader,
  html = EXCLUDED.html,
  updated_at = now();

CREATE OR REPLACE FUNCTION public.enqueue_quiz_v2_emails(p_submission_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_sub RECORD;
  v_delays INT[];
  v_archetype_seq INT;
  v_delay INT;
  v_mail_idx INT;
  v_mail_code TEXT;
  v_inserted INT := 0;
  v_total_inserted INT := 0;
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
    WHEN 'harmonieux'          THEN 7
    ELSE NULL
  END;
  IF v_archetype_seq IS NULL THEN
    RAISE EXCEPTION 'Unknown archetype: %', v_sub.archetype;
  END IF;

  IF v_archetype_seq = 7 THEN
    v_delays := ARRAY[0];
  ELSE
    v_delays := ARRAY[0, 2, 5, 9, 12];
  END IF;

  FOR v_mail_idx IN 1..array_length(v_delays, 1) LOOP
    v_delay := v_delays[v_mail_idx];
    v_mail_code := 'M' || v_archetype_seq::TEXT || '.' || v_mail_idx::TEXT;
    INSERT INTO public.quiz_v2_email_queue
      (submission_id, email, first_name, archetype, mail_code, day_delay, send_at)
    VALUES
      (p_submission_id, v_sub.email, v_sub.first_name, v_sub.archetype,
       v_mail_code, v_delay, v_sub.created_at + (v_delay || ' days')::INTERVAL)
    ON CONFLICT (submission_id, mail_code) DO NOTHING;
    GET DIAGNOSTICS v_inserted = ROW_COUNT;
    v_total_inserted := v_total_inserted + v_inserted;
  END LOOP;

  RETURN v_total_inserted;
END;
$$;

NOTIFY pgrst, 'reload schema';

UPDATE public.quiz_submissions SET pdf_url = CASE
  WHEN archetype = 'eloignes' AND LOWER(first_name) = 'farida' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/eloignes-farida-53f5a5c3f3189688.pdf'
  WHEN archetype = 'eloignes' AND LOWER(first_name) = 'hadjer' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/eloignes-hadjer-d2e1bf1c5d21529a.pdf'
  WHEN archetype = 'eloignes' AND LOWER(first_name) = 'seyyal' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/eloignes-seyyal-08d34c403c344c9e.pdf'
  WHEN archetype = 'en-construction' AND LOWER(first_name) = 'mina' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/en-construction-mina-ea9e64ec21d5e6c1.pdf'
  WHEN archetype = 'en-construction' AND LOWER(first_name) = 'souadetest' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/en-construction-souadetest-33b3eb4008831582.pdf'
  WHEN archetype = 'en-construction' AND LOWER(first_name) = 'souadetest2' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/en-construction-souadetest2-f5ad461eabc6a91d.pdf'
  WHEN archetype = 'en-construction' AND LOWER(first_name) = 'testresend' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/en-construction-testresend-66ebb2de67088d86.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'amal' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-amal-c29eac1c018f79c4.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'claudetest' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-claudetest-136aa715f0b9fd79.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'diagdirectpostgres' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-diagdirectpostgres-18e736624c2a157b.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'fullpipelinetest' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-fullpipelinetest-d99b65ef47f5ade3.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'melodie' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-melodie-c382ac4a30cfa7f1.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'mina' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-mina-2984c9c2da23e1b5.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'rachida' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-rachida-25cf6d62ddef48d8.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'rpctest' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-rpctest-07e293c72d5bbf0e.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'sarah' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-sarah-278c2feec1c1c89f.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'testdirectn8n' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-testdirectn8n-c40ec08fe02f429f.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'testfix' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-testfix-3c17631f0d94867b.pdf'
  WHEN archetype = 'silencieux' AND LOWER(first_name) = 'testrpc' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/silencieux-testrpc-1d560f690d554c3e.pdf'
  WHEN archetype = 'survivants' AND LOWER(first_name) = 'lamia' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/survivants-lamia-26a79b8f38e6b8b3.pdf'
  WHEN archetype = 'survivants' AND LOWER(first_name) = 'testsurvie' THEN 'https://azwaj.be/wp-content/uploads/quiz-pdfs/survivants-testsurvie-0d71ce00121d881e.pdf'
END
WHERE pdf_url IS NULL
  AND archetype IN ('silencieux','eloignes','debordes','en-construction','complices-fatigues','survivants','harmonieux');