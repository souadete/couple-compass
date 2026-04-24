-- Quiz V2 Azwaj v2.1 — Fix PDF URL + nouvel archétype Harmonieux (1 email seulement)
-- Date : 24/04/2026
-- Contexte : 2 retours beta (N=2) + bug critique PDF URL cassée dans les emails sent via Resend

-- ════════════════════════════════════════════════════════════════════════
-- 1. FIX CRITIQUE : colonne pdf_url sur quiz_submissions
-- ════════════════════════════════════════════════════════════════════════
-- Le workflow n8n "Quiz V2 Azwaj" génère des PDFs et les upload sur
-- /wp-content/uploads/quiz-pdfs/{archetype}-{firstname}-{hash}.pdf
-- Mais cette URL n'était jamais stockée côté Supabase. Résultat : le
-- workflow sender Resend utilisait une URL fictive (quiz.azwaj.be/resultat),
-- donc les liens PDF dans les emails étaient cassés.

ALTER TABLE public.quiz_submissions ADD COLUMN IF NOT EXISTS pdf_url TEXT;

-- RPC pour que le workflow n8n (ou l'Edge function forward-to-n8n) puisse stocker l'URL
CREATE OR REPLACE FUNCTION public.update_submission_pdf_url(p_id UUID, p_pdf_url TEXT)
RETURNS VOID
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  UPDATE public.quiz_submissions SET pdf_url = p_pdf_url WHERE id = p_id;
$$;

REVOKE ALL ON FUNCTION public.update_submission_pdf_url(UUID, TEXT) FROM PUBLIC;
-- service_role uniquement (appelée par Edge function forward-to-n8n)

-- Update get_quiz_v2_ready_emails pour retourner aussi pdf_url
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

-- ════════════════════════════════════════════════════════════════════════
-- 2. Nouvel archétype "Harmonieux" : 1 SEUL email (M7.1 J+0)
-- ════════════════════════════════════════════════════════════════════════
-- Décision 24/04 : pas de drip sequence pour les couples sains. Un seul
-- email de félicitations + lien PDF + mention douce "si besoin plus tard,
-- on est là". Le PDF contient déjà les pistes d'entretien.

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES (
  'M7.1',
  'harmonieux',
  0,
  '{{firstName}}, félicitations — votre couple rayonne',
  'Un portrait rare que peu de couples reçoivent — voici le tien.',
  '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">
<span style="display:none;font-size:0;color:transparent;line-height:0;max-height:0;max-width:0;opacity:0;overflow:hidden;">Un portrait rare que peu de couples reçoivent — voici le tien.</span>
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAV4AAABGCAYAAACE2fxYAAAACXBIWXMAAAsTAAALEwEAmpwYAAAA7XRFWHRYTUw6Y29tLmFkb2JlLnhtcAA8P3hwYWNrZXQgYmVnaW49IiIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/Pgo8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJHbyBYTVAgU0RLIDEuMCI+PHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj48L3JkZjpSREY+PC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9InciPz60gmxpAAAAtGVYSWZJSSoACAAAAAYAEgEDAAEAAAABAAAAGgEFAAEAAABWAAAAGwEFAAEAAABeAAAAKAEDAAEAAAACAAAAEwIDAAEAAAABAAAAaYcEAAEAAABmAAAAAAAAAEgAAAABAAAASAAAAAEAAAAGAACQBwAEAAAAMDIxMAGRBwAEAAAAAQIDAACgBwAEAAAAMDEwMAGgAwABAAAA//8AAAKgBAABAAAAXgEAAAOgBAABAAAARgAAAAAAAACGou1kAAAXZElEQVR4nO3daXBcx3ku4PfrPsvswGCwEBsJEFxBcRdJSSYJULtkW4wtUpaoyJIT25ElebmJ5SROxSAsK4ntSJEcLzeyU/L1lU1ZshZbC01tJChKFEVxF/cVIEDsAwwGg1nOOf3dH0M5caUqde3ri0GCfqpQUzU/DvrrOvVWT58+3YCmaZqmaZqmaZqmaZqmaZqmaZqmaZqmaZqmaX9AFdEKVEQrCt0MTfudiUI3QNN+H42Njbh92dq5X7rmpmCh26JpvytZ6AZo2u9q3bJ1qKuvCtekAj/wUspfFynf26USGBsbK3TTNO3/ig5e7b+Ea664Av5MBhuWfEhUBepmlo6ZT/hhXCtY3CiK/IEVxvI9y2dHstVBG0f6+//Ta7XccyOaL7+B4POhvb19nCrQtH9DhW6Apv1nbli2DLFsFnPmN/m9nvRiePJThhK3mSQDAWHDYQ855bBDXocn+DHbcp86eGjknDOzz9u1fz86Eonfut7WrVsRkqeqK2LzPpLLONsrZi05GgrtQXNzC9ra2gpUpTbZ6ODVJqTGxkZ8ObaC+kv9lWND3ocNxgbBtNyA9BkkyCSTgtIHlz3OqBwcduGyxy6pAQV+PWM5T1hIbC9urEl96dFHGQBaWpqwYO6Gxisvu+wly7Zqu7t77whXTN986sieD10xfcFL1NBQ6LK1SUIHrzbhzCqbhY/OXFMTNvkLkukTEqJaQJBB+T+TTFhkIpQPXqRVDjl28sHLHlxWrODlDMM4kiP3B2nv7E8e3LYlxy+8QJ0NpY9EiyJXZjLZZ+PDiYPlZbH7R5KjXbW1nesocgsXunZtcjAK3QBN+0BdXR3W1TQI29dwsy+HfxYsyiQkSRAMkmQICRMGTGHARxYC0gdXuSAQTEiQJBrNpeEoF1Jatm2ai1K5zP9UXHf3Hc0333Y82HC6xEpP7R+IPyekLKmaUv6vDLgs7O9s2xPVoauNGz3i1SaMtcuXY1Hx4o+ZGXpKkhCSPxjlGjBJIP9pwBImfMJCUPhABuCSCwcecspFYiwFh11YpgESxB57GHWyPOqmj54a7br220+1PhAOBe9kZpXL5bZ0Xej+Ut/e02fW3HuvDl5t3OgRrzZhrL6wklL+1GcNEmRAkiEkGZAwhQGD5MXQNWBRPnj9lgUhCTmWkOxAuQxbmCAWgGIYQhIRwSAHBsTc6aGqppP7u/5hzpLaOinF2aGhkacFhLut72kdutq40sGrTRi+pgxUtzUkFZEBCb9hwyAJYoJJ+fC1hAnr4shXivxqSPII7BFIEWxhQSgXOXbhuAoeeyDbg+EYXpa8hHO289TZGP2v4ki4PRIJ3REsid/X2rqtsIVrk45+c02bMHq6Y+yPBB4u9oW8kBWA37ARsvwo8gVhCQMmSZgkISEgQFCeQi7jgl1AQsASBozyMViGhC0MSCbIBd3wXX2GJeR7wa7Am/2DHZyB8UY4Em7N5pztpTXxbKHr1iYfHbzahPHAGw/gBI7vIaIvs+JszvU4k3OQzTkwhIRlmKCLjyUUGK6nwMxQwoMXSUEt7ER6/U5IEjBIwpgzAPPm92HO7/NwRceP9s/vGfVNL0ex37w8GPDNjVZMfau19ZyeZtDGnZ5q0CaU7zz/PL9TN/D9Qw2rZvsN425LSDJJwjLyqxngAZ7D+cCFQmZmJ0ZXHYRTNoSkyuHUYROrlAQBiIeHEFQKsB3jYOnpB7tHcNwJL9hZUVryBWY+nc5kOwtdrzY56eDVCm7r1q1oVorQGOdtxzLUec8vPJ9lOZIJgghE+U8wQzHAzGBiOMVJdH+4DUc6M+g4rjAwrDCvox5SCjiuC+NALXbZ7dwvUujpV50zK+Z2Wfb0eYGAb4VS6n+XVdfnWltbC12+Ngnp4NUKqqVlPUqDNPukFF+QPeVuRaj3l8mP3bQzebB9fsXsCuKhHHIDGZAp4GYUXEdBQoCZEfcN4WevpWCOBDA1UYElw9WoypTCKBKwyEA4G0T9K0u5c86+/etWrv7U9XNXVXX0DDULIWQmm+0CthS6fG2S0sGrFUzLtdfik803hYPFwb/1+Sw2pDGPqOzPwuuGf+VcWT8zWhuFFbQwNjCGoz85gIFD/ZAkwGAwASM5hcWn52N+/wyAgWB1CL6AxGgyC2kQwrYPkWwAq84u6/3jv1n3+Zc3v/LQh2+47lLOSwLXFboLtElKB69WOJdncVq9quLnNz+aQVdlia/u2ZnRq2ZWRha2bPlWm39kKIniqmJITyAbH0PZ9FIkz4xAECAEwZcKoCFZjZDlR9BnI1odw/QNjTiy6SCGjvYBAMKWnxqvm3eNZZqbrHDZGduyZgAghvIKW7w2melVDVpB3HdfJTiSm3bBPPxk1ndsi/Ann0mhb9NgIl7vuZ4YGhhCBiPU0X4GneY+TLulDCu+uhqNn1oI8kkwA+GRAGpEOQKGDVNKDF9IwBfzYfF9y+GPBcEArJBFS9cv4URy6CU32+cHUAIAxGQBJwvbCdqkpUe82rhr+T5QPyNWqkz3J5kss+uqV8vMae2XV3/lspJI9E4hyVx86yIciz4GKk4jdmQN5q9eBWlJ1DbX4dzm03D7MrAME5YhIYSApxSCpWFIywBJQnR2DKNvJTHzhtkgKbyRgWzvDTd82CRBBgAmEiVo17e/Vhj6ztPGXZexjEaOW6tPnM/NHBjNEoFmEc7M+Bfji3tXLli9qfp80eemySnzsHsFNSyYgwVrl0GaEqwY7/z4XcTb4ygKBOC6HlxXoaQhippr61C6qAIk8+t8Z948D+STqF5Ri9GhlPnzv3q6dnBuZt+3vv5XDIAMQ9agtl6v4dUKQk81aOPuR5/dzUuX7H1+KNm/Vgp6TQgOkVALx7yx298+/OafXEj2zglUhuj6+9Zhyc2XQRoSylN498k92PH0LliGAaUYSgIzPjEHS792BSpX1cIMWwAAN+vi6ObDMIImyCBkkhkqkcHGdDabJUIaABioO3Vkn9XS0lLQvtAmJz3i1Qrij29Pq9jyc7vdGcFPXeWsWiRN75M3Lb2u4tqFTQuCdkAKQwAMMICxxBje+P52nHv7HKb4iiAlwWMPsz4xF/U3zAAAsGKQyI92T+08ix1P7MLCG+dhTsU8DB1IgD2e+9k/uS/LwBCAaVKIipiRKMHI2Z7C9YI2Weng1QrjHHDfnS1YtnSB8tFozYrFS2+UUtbhg19hBDgZB/s2H8LOJ96FSnsotUPwGxYYQKAyhKlX1uPA84cwdVENDr90GKs/vxokCbuffA8V4Qgq6ysAMJSnCIobvnbXXwSf2v7DTsMvFwohSjsGVXnzR+7saf2nnxSuH7RJSQevVhBbt27F5cuX+BIXTn4jFAz+OREYADzX4/6OQdr3+vv03q8PwEs4iNohlAZCEIrAYHis4CvzY+cTu1GzoAqHXjyMSHkIEMDAuUGMdozACAbgL/EDAEzLgOepUoIoz2SzZ/1+HwEIFQftuQsDoYOF7AdtctLBq427pqYmXLZsiZ3qO/t34WDwPhDAzDlPec9seuC52tO7z63MjOXIkhKldggh04Y/6oc/4keqfQSe5yGbzqF4Thksy8Tqe1fig6mJnuO9sKUBx/MgTAmAYAVtKCB65bRltVteazt467qbQEQcCgUuwfSFPy90f2iTj364po27n99xBwY7jtzqs+17QDCYOZ0ey9z75ss7/vT0rrOmnw2eEoig3I7AliY8pTDUk4Bd4kdxfRSKGQ03zkJxaRjPfe1F/PSep9D9fjeICJmhTH6awvOgFAME+EI2EcFUOa/x0NET+y42Q0hDzu48fUQWtDO0SUkHrzaumppWYnR5ZWkkHGolggWAHU7f37Oz48evfGenP2zY0ywhBYEAAjxmKJXf/vH4W6fQcOMsWFEfKhZX4vyRCzCUQLxjCJlkPnDJY3hKwfU8ZMbyW+3aIRtm0IRiNKaHUic8pTIAWJCoCYfTdkE7RJuUdPBq42rjxqvgOcHbDcOoBQDHcV4pqhr+/pdb/15VloSnMnNQKYAtF0q6UErBUwzF+SUO+15+H1OWV0MYAsnuJGwyUGT6EQj6wcwwbAOeUvA8D8n4KADA8JkIloaJmecd2X7CdRznOAAWQsQMc0wHrzbudPBq46qoaAWVxYo/CSC/4MDzHtm48UlacWoXMimnXjGCFMlS7NMnIKKZfIiyglIKAoTO/Z2oWloN5SpkhjPw2IPreWACwIA/mn+xwmNGoi8JIL+vQ6wuBqVUHSkEUqn0+xebIwFDH/iqjTsdvNq4aWlpQWWsIWqZ5iUAwOABmP7927adYLl2LQE0TzksSm7ugH9eAuFPnEHOzsFTCooZphTwmRai9SVgxVCOB5cVXM6HMzMjXBaC6ykoVoh3xsGcfzmtoqEMyuOq1VOXlg30x48DIMWqz3FEppB9ok1OOni1cXSELPN0pRDCAACleMD292bQ1oZp2wMcltb8kGnh8H6BwWHGG92DOFPZBUtI+AwTadeFCBqwwzaICFJQfiqCFXLpHAAgPCUMJoYCkOxOQjn5TchK60oJRCYcnl1WHusngnKyzq9NnzNWsO7QJi29nEwbRyZAxr/fjtEAGaLENxOJmAgq5plSCIruqcVbQy6YgDkddVBgjGQzIAJCgRBI5k8UNm0THjPAjNF4CkIQ/FE/zJAJL+NibDCF1EgGkdIQiioiMCyJnOdcMprNjEWc4C625fe+/fBrBesNbfLSI15tHM3kTK7uglIqCwBCoKr3giyau249LkSjsUQuUzGSS0N5QOWxKlQerUIik0Uql4PHCh4zWADs5Vc62BH74vcKI4OjABEM20Dp1BgUM+IjoxjsHgIzwx/xwxfyIZvKNRYVBwNjyYG73t/xclwf/aMVgg5ebdy0traiL34omc05ewCASARNqGs+86fX08wZXQHFKuwoD6wYPjYQgAkJyoeryj9gcxwXYyNpkCAESwNQF4N3sHMo/08YKJtdhrTjgBWj51Qf6GIgWwELVsCsP7qt65+P9g6cWnPbX+vdybSC0MGrjavh4UM8lIj/CPn9bxAKB/8yW1Hs7/HPlgAkc/4EYUEECcofbAmGAsNjRiqZRl/nIKSUiFQXQTFDscJQVwLKYwz3jaBqXhU8zwMI6D7VCyEFiAAhCURk79j8ZGrNmvWF7QhtUtPBq42rjRu3wo4kn3UcZy8A2JZVX+5Xjy5ZMI9IIMvAb5aGqYuBSwAUKzAxGi6rR3ltDMpTKJ4aBRODAWQHUoj3DsMwJWJTowDlr9N3bgAkCE7WxdhoBiQxkEvp214rLH0HauOqra0NNfU3Jbv7E5/3lOoGAJ/PumvWiqktgeJA7oPlXx9g5F+eMAImLrttGXrO9CEZT4GZUVQVgeU3QQAG4yPoPt0LwzIQioVg+I38hjppB2Cg61QPhgdGQAJHfvnSIT3FoBWUDl5t3DU3N6N6xtC7iWT/BqVUB0Cisq7843c9tGHKh267DKVTS2D6DZi2gWhVMZZ9fDFueeBjOH/sAs4c7UTP2X6AAH9xAFbUh5xykcs6iHcNI5fOwbQN2AEbzIzKGRXwPA9vPPkWExggesOsMvVLE1pB6eVk2rhra2vDR27q569+9aHtq5bZl6cGBx8MBMO3RKui/qs/0ySu/kwTu1mXQIAwJI7tOInn/+5F9PQPImTY6D3ag4Vr5oKIUDI1ioHz+RclsmM5tB+7gJlLp0NaEoYlccUty/HSD9/AyXdOc3HQdzbod3fGL8T1iFcrKB28WkG0tR1BW9sNaGpq7Hnx+bc+7ToHvp4a8F95et+5v2SFmZnRLHpO9tKJd8+gr3sQpjRQJHwwhUD7sS4Q5R+8lU+L4fiOkyAC4h2DWLPhchzeeRx1S2pRXF6E5767Gcf2neGYP6CkJR4bUR1D53Cu0OVrk5wOXq2g2tqOIByNckvL7e3h5OLH27cdOutk0i97LtsEgkGSgoYFkyVclX9FeLAzDifnQEqJktoolKdAkpBJZiEMifLaGH7R8jxcpeBIj6O2n01b7i8vzvzrtvYLerSrFZwOXm1CaG39KYCf4v6y+7cFZwz8DeX4H9kBwwOYQdIQcLMeAEYmkcbI4CiKyyLwh31gpUBCIBILQRoCr//sLShiGKbkgDTZ8MmB8+meu4+1nx18+siRQpeqafrhmjax/Bg/hm1VfNfyGf9gWsITJiFSFmJpyvzR7QJgTyHePQyA4OQ8QALCFJh/VSN2bzmA/a8dgs802DYlG345FIp462tKRvfq0NUmCr37vjahjI2NoT3RqRbULHuTrdwAebw8Vh31D/cmICQREYGIMP3SOlQ2VKD9cCdyqSwWXT8fvV2DeOGxVzhi2WyYUklb7O0d6705dc579x8Pby50aZr2Gzp4tQlnODOMo6kT6o8W1uzuGcu+2rCgYVG8YzAipbCEICZJWHjNJQgUB/DMQy/ASzk4e+gcju47ySHbhs8yzghTfDuTMP+8Z+Dwucd7txa6JE37LXqOV5uQ+vv7cfemTfhuyz37562Z9/BA99Dg4LmBZqFwlc9vX1I9uzL8+qbtSPQPQxBlQTgfDQf3Cil+VR7KvBYqyvV/7+2zeBcHCl2Kpv0HeiG5NqE1NTXi4QfvDQatOX/2wjOvvDg1NIUWXr3gnxKjqbd//o1nNwe6Ignpvh0f9c9OllLU2zG4kwOxNOv5XG0i08GrTXhbt27Eiks3+Efi/SulKCqybbVbpYvar1+9lozuECi3g98sdCM17Xegg1f7L6GpqRHNzddi27Z9aG5ehNbWRwvdJE3TNE3TNE37PbS03Inu3ZtkS0vLH/S6ZWVlOPXSc2Lzyy/+Qa+rab8P/QKFNmE0NTXhvnvWCSdQ98Nb/miNv6XlL/6frvVBeLds2IADP3s8KKeWfXOot7P4D9VeTft96eDVJozm5hqQay8I+H3XFwWxsrn5QwDyo1Ugfzw8M//WJwCsX58/TeKD77Zu3YofPfYvxqfv3GAzM7Z1deGRza9mBofiz7yw+blUYarTtH+jH65pEwbzyzizL/S3hmX0B/y+RaVdo3dvfP11rL9h5XVuzqnIOo6YUlF+3bv7D3xuceOcr/cNDO144cXXnlv/8RtvPniy/ZeL5k7/Sk7x45JkoCTiv42IjHgi8dzilTfu+fWzP1vQOLvuf4Rj1V8sqaxLFLpWbXLTI15tQrjkkkvw+hYuVuwl++PxX0khLuusTlVv3HgXPMfpTwwP/6qyvGyB6+Q2f/zqkhGfbb0zrbaqZm5j3cJpU6v/eunC+XbAb7fXz4qe95l0rZNJHRrNZF8pjZbcjszrvKR++umA318upTALXaum6eDVJoRDh15BdSzQlHVypaaQH8s5rjMat1ZjbxxuoGJfaVXlIss2pyVy/Iuv/2Cv6h4a3mWa5vzLly1dOJJM7g776KOex2dLU2XcPTjwHBu+YtOQq0gghPRhEhUVTESsf+RpE4EOXq3gmurqkDp2UPosY/oU+P5+QcWM72XS6Qdj0eKbT9jSqhobDlaUFH9RCfsbzCPVH7mxyiwty3YIQsi2LDsU8D1rmtbnKqf6DmN6Dc1raHjonXff25sdS3eSIPS+Nz3EZ84KAikhhN6PVys4Hbxawc1auRQ9Sd/l6ZwzPRWb4mzr7MSYg3YCTRvq77t0LGytT6czyeGR3lDICH8m51TIuln1ruu4W1zP226GS3cZkt4U9uxBwGKl1IUrV1/x0UAgEDGELEqVRda8dPgwE4Hp4rHymlZI+neXVnAzZlSjecUq0yNX7tt3JLN23XoMnD4hv/nwt8QX7v8KfKapTANyNJ2VQcvnbdn+Zu7WW+/AsnkzxGgupYqLp2DFpYvEIz94XLW2tuL0sUMyFPSHJWjEHzjjO3XSsKWAWVla/IgVNj8XLrtEP1zTCkoHr/bfTlNTE5qbm9Ha2grmt3HyvWyLz293SSnLi6vMbwaLlniFbqOmadp/W01NTXjyh9+ZcmzXq2vPn9hfunWr3ptX0zTt/7uWlmbwnidIh66maZqmTVL/B6+D5hFEthFZAAAAAElFTkSuQmCC" alt="Azwaj" width="180" height="36" style="display:inline-block;max-width:180px;height:auto;border:0;outline:none;"><div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:8px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>Tu as fait le quiz et ton couple se reconnaît dans ce que j''appelle <em>Les Harmonieux</em>. C''est un profil <strong>rare</strong> — pas parce que l''harmonie est exceptionnelle dans l''absolu, mais parce que peu de couples prennent le temps d''entretenir activement ce qu''ils vivent.</p>

<p>Je te le dis en tant que clinicienne : ce que tu décris dans tes réponses — la communication fluide, l''intimité vivante, le respect des rythmes de chacun·e, la complicité dans l''épreuve — ce n''est pas de la chance. C''est le fruit d''une <em>attention constante</em> que tu portes, et que ton conjoint porte aussi, au lien qui vous unit.</p>

<p><a href="{{quiz_v2_pdf_url}}" style="color:#7C2D5A;font-weight:600;">→ Télécharger ton portrait complet (PDF)</a></p>

<p>Dans le Coran, Ar-Rûm 30:21 parle de <em>mawaddah wa rahma</em> — l''affection et la tendresse mutuelles que Dieu place entre les époux comme signe. Ce que tu vis aujourd''hui est une manifestation de ce signe. Ce n''est pas un accomplissement final : c''est une <em>barakah</em> à entretenir chaque jour par la parole juste, le geste attentionné, et la douʿa l''un pour l''autre.</p>

<p>Dans le PDF que tu viens de recevoir, tu trouveras les 3 gestes que les couples Harmonieux oublient parfois (et qui font l''érosion silencieuse) + comment traverser les grandes transitions (enfants, ménopause, crises pro) sans perdre ce que vous avez.</p>

<p>Pas d''autres emails après celui-ci — vous n''avez besoin de rien de plus. Juste mes félicitations sincères, et le rappel que si un jour vous sentez que quelque chose bouge (fatigue, distance, phase de vie), <a href="https://azwaj.be/consultation-sexologue-musulmane/" style="color:#7C2D5A;">vous pouvez consulter avant d''avoir besoin</a> — c''est ce que font les couples Harmonieux qui durent longtemps.</p>

<p>Que Dieu protège ce que tu portes.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
    <div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
  </td></tr>
</table>
</body></html>',
  now()
) ON CONFLICT (mail_code) DO UPDATE SET
  archetype = EXCLUDED.archetype,
  day_delay = EXCLUDED.day_delay,
  subject = EXCLUDED.subject,
  preheader = EXCLUDED.preheader,
  html = EXCLUDED.html,
  updated_at = now();

-- ════════════════════════════════════════════════════════════════════════
-- 3. Update enqueue_quiz_v2_emails : dispatch delays selon archetype
-- ════════════════════════════════════════════════════════════════════════
-- Harmonieux (archetype=7) : 1 seul email à J+0
-- Autres (1-6) : 5 emails à J+0, J+2, J+5, J+9, J+12 (inchangé)

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
    v_delays := ARRAY[0]; -- Harmonieux : 1 seul email
  ELSE
    v_delays := ARRAY[0, 2, 5, 9, 12]; -- Archétypes problématiques : séquence 5 emails
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

-- ════════════════════════════════════════════════════════════════════════
-- 4. Backfill pdf_url pour les submissions existantes
-- ════════════════════════════════════════════════════════════════════════
-- Backfill pdf_url pour les submissions existantes (28 PDFs → 14 combos uniques)
-- Match fait par (archetype + LOWER(first_name) normalisé en slug alphanum lowercase).
-- Les submissions sans match gardent pdf_url NULL (beaucoup sont des tests diagdirectpostgres/rpctest/etc).

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

-- Check result
-- SELECT archetype, first_name, pdf_url FROM quiz_submissions WHERE pdf_url IS NOT NULL ORDER BY created_at DESC LIMIT 30;
