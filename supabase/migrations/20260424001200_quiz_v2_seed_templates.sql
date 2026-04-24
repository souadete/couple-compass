-- Quiz V2 Azwaj — Seed 30 email templates (generated from Encharge backup 2026-04-23-15-54-32)
-- Canonicalized merge tags: {{firstName}}, {{unsubscribe_url}}, {{quiz_v2_pdf_url}}, physical address inlined.
-- Idempotent via ON CONFLICT (mail_code) DO UPDATE.

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M1.1', 'silencieux', 0, '{{firstName}}, ton portrait est arrivé', 'Tu es un couple « Silencieux ». Ce que ça veut dire, sans jugement.', '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">
<span style="display:none;font-size:0;color:transparent;line-height:0;max-height:0;max-width:0;opacity:0;overflow:hidden;">Tu es un couple « Silencieux ». Ce que ça veut dire, sans jugement.</span>
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>Tu viens de faire le quiz et ton couple se reconnaît dans ce que j''appelle <em>Les Silencieux</em>.</p>

<p>Ne lis pas ça comme un diagnostic. C''est une photographie, à un instant. Les Silencieux, ce ne sont pas des couples en crise. Ce sont des couples où il y a beaucoup de respect, beaucoup de pudeur — et souvent, quelque chose qui ne se dit plus vraiment. Les mots doux du début se sont raréfiés. Les frustrations aussi, d''ailleurs. Tout reste à l''intérieur.</p>

<p>Ton PDF détaillé est prêt — il approfondit ton portrait, donne un cadre spirituel apaisé, et propose 10 micro-actions concrètes à tester ce mois-ci.</p>

<p><a href="{{quiz_v2_pdf_url}}">→ Télécharger mon portrait complet (PDF)</a></p>

<p>Dans les 12 prochains jours, je vais t''envoyer 4 autres emails courts. Pas de blabla : une idée clé à la fois. Un zoom sur ta force principale, trois pièges à éviter, un témoignage anonymisé, et une invitation à aller plus loin si ça te parle.</p>

<p>Le silence dans un couple n''est jamais un échec. C''est un indicateur, inch''Allah. Et on peut le traverser.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M1.2', 'silencieux', 2, 'Ta force, c''est celle qu''on sous-estime le plus', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>La grande force des Silencieux, c''est <em>le respect mutuel</em>. Pas le respect de façade — le vrai, celui qui s''installe dans la durée, qui fait que ton couple est un lieu sûr, même quand il est un peu trop calme.</p>

<p>En consultation, j''entends souvent des femmes me dire : <em>« au moins il ne crie pas, il ne me manque jamais de respect »</em>. Et je les comprends — quand on a vu d''autres modèles autour, ce respect constant, c''est un trésor. Mais ce respect devient parfois un mur : <em>« on se respecte tellement qu''on ne se parle plus vraiment »</em>.</p>

<p>Voici une situation que j''ai en tête. Un couple marié depuis 9 ans. Il me dit : <em>« je ne sais pas ce qui ne va pas, on s''aime, on se respecte, mais j''ai l''impression qu''elle est loin »</em>. Elle me dit : <em>« je n''ai jamais osé lui dire que je me sens seule au lit ».</em> Chacun portait sa solitude, par respect.</p>

<p>Ta force, c''est cette base solide. À partir d''elle, tout devient possible — si tu acceptes d''ajouter un petit risque : celui de dire <em>un peu</em> plus que d''habitude. Pas tout d''un coup. Une phrase à la fois.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M1.3', 'silencieux', 5, 'Les 3 pièges silencieux (et comment les éviter)', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>Les Silencieux tombent souvent dans trois pièges. Je te les nomme, pour que tu puisses les repérer dans ta propre vie de couple.</p>

<p><strong>Piège 1 — Le « pour ne pas blesser »</strong>. Tu ne dis pas que quelque chose ne va pas pour <em>le préserver, la préserver</em>. Le problème : au bout de 3 ans, la frustration non dite se transforme en distance. Le soin devient un mur.</p>

<p><strong>Piège 2 — La pudeur confondue avec le mutisme</strong>. La <em>haya</em> (pudeur saine) protège — elle n''impose pas le silence absolu sur l''intime. Le Coran parle des épouses comme d''un <em>vêtement</em> l''un pour l''autre (2:187). Un vêtement qui couvre, oui — mais qui touche, qui réchauffe, qui parle à la peau. Il y a un lieu, un temps et des mots pour tout, conjugalement.</p>

<p><strong>Piège 3 — Le « on verra quand les enfants seront grands »</strong>. Sauf que dans 15 ans, les enfants partis, il se peut que vous vous retrouviez face à quelqu''un que vous n''avez plus appris à connaître. L''intimité conjugale, c''est maintenant — pas à la retraite.</p>

<p>Ces pièges, on en sort par de tout petits actes. Une question posée. Un désir nommé. Un silence qui devient parole. Ton PDF en propose 10 à tester.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M1.4', 'silencieux', 9, 'L. et S. — 12 ans de mariage, 1 phrase qui a tout changé', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>Je pense souvent à L. et S. Un couple que j''ai suivi il y a deux ans. 12 ans de mariage, 3 enfants, une maison, des projets. Et un silence qui s''était installé tranquillement. Sans violence, sans crise. Un silence poli.</p>

<p>Elle m''a dit en première séance : <em>« Souade, je l''aime, je suis sûre qu''il m''aime aussi. Mais quand je le regarde le soir, je réalise que je ne sais plus ce qu''il pense. »</em></p>

<p>On a travaillé ensemble quelques mois. Rien de spectaculaire. On a installé une petite habitude : 10 minutes chaque dimanche soir, rien que tous les deux, sans écrans, pour se dire une chose qu''ils n''avaient pas dite de la semaine. Juste ça.</p>

<p>Au bout de 4 séances, elle est revenue et m''a dit : <em>« la semaine dernière, il m''a dit qu''il avait peur de vieillir. C''était la première fois qu''il me disait qu''il avait peur de quelque chose, en 12 ans. »</em></p>

<p>Ce n''est pas une histoire de miracle. C''est une histoire de micro-ouverture. Le silence des Silencieux ne se casse pas par un grand discours — il s''ouvre par une fissure, puis une autre. <em>Kintsugi</em>, doucement.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M1.5', 'silencieux', 12, 'Un défi de 5 jours pour remettre de la parole', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>On arrive au bout de cette petite série. Si tu as lu jusqu''ici, c''est qu''il y a quelque chose qui t''a parlé dans ton archétype.</p>

<p>Je voulais te proposer quelque chose de concret, calibré exactement pour les Silencieux : <strong>IntimTalk</strong>. C''est un défi de 5 jours que j''ai conçu pour les couples musulmans qui veulent relancer le dialogue — sans thérapie lourde, sans exposition, sans forcer la pudeur.</p>

<p>Chaque jour pendant 5 jours, tu reçois un micro-exercice à faire en couple (5-10 minutes). Des questions simples, progressives, ancrées dans un cadre pudique. Pas de confession forcée, pas de « vide ton sac ». Juste des petites ouvertures, à ton rythme.</p>

<p>Les retours des couples qui l''ont fait sont souvent les mêmes : <em>« on a parlé de choses qu''on n''avait plus abordées depuis des années ».</em> Parfois c''est émouvant, parfois c''est léger, parfois ça fait rire. Rarement ça fait peur.</p>

<p>Tarif : <strong>49€</strong>, une seule fois. Tu gardes les exercices à vie.</p>

<p><a href="https://buy.stripe.com/4gM00j8JX9GN2Qv6J71kA03">→ Rejoindre IntimTalk (49€)</a></p>

<p>Si ce n''est pas le bon moment, pas de souci. Le simple fait d''avoir lu ces emails est déjà un pas. Attache ton cheval et tawakkal ''ala Allah.</p>

<p>Souade</p>

<p><em>PS — Si tu préfères en parler d''abord en 1-1, tu peux <a href="https://tidycal.com/souadetaje">réserver une consultation</a> (45 min).</em></p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M2.1', 'eloignes', 0, '{{firstName}}, ton portrait est arrivé', 'Tu es un couple « Éloigné ». Distance, pas fin.', '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">
<span style="display:none;font-size:0;color:transparent;line-height:0;max-height:0;max-width:0;opacity:0;overflow:hidden;">Tu es un couple « Éloigné ». Distance, pas fin.</span>
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>Tu as fait le quiz et ton couple se reconnaît dans ce que j''appelle <em>Les Éloignés</em>.</p>

<p>Ne le prends pas comme un verdict. C''est un constat, posé sans dramatiser. Les Éloignés, ce ne sont pas des couples en conflit — ce sont des couples où la distance s''est installée doucement. Tu partages un toit, des enfants peut-être, une vie organisée. Mais l''élan a diminué. Certains soirs, tu te demandes si c''est normal.</p>

<p>Ce que je peux te dire, c''est que c''est un profil que je vois très régulièrement en consultation. Et ce que je vois encore plus souvent, c''est que la distance se traverse — surtout quand elle est repérée à temps.</p>

<p><a href="{{quiz_v2_pdf_url}}">→ Télécharger mon portrait complet (PDF)</a></p>

<p>Dans les 12 prochains jours, 4 autres emails courts arrivent. Je t''envoie ta force principale, trois pièges classiques, un témoignage anonymisé, et une invitation pour aller plus loin si tu le sens.</p>

<p>Le fait que tu aies fait ce quiz, c''est déjà un premier mouvement. Beaucoup de couples restent dans le silence du <em>« bon, c''est comme ça »</em>. Toi, tu regardes. C''est une grande force.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M2.2', 'eloignes', 2, 'Ta force, c''est la loyauté — ne la sous-estime pas', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>La grande force des Éloignés, c''est <em>la loyauté</em>. Tu es encore là. Après 5, 10, 15 ans, après des phases d''ennui, de fatigue, de distance — tu es encore là. Ce n''est pas rien. Dans une époque où beaucoup jettent au premier signe d''usure, tu as choisi de tenir.</p>

<p>Mais attention, {{firstName}}. La loyauté sans soin devient cohabitation. Et la cohabitation, à force, use les deux. Les couples qui durent ne sont pas ceux qui ne connaissent jamais de distance — ce sont ceux qui savent la nommer et la traverser.</p>

<p>Le Prophète ﷺ a dit : <em>« Le meilleur d''entre vous est celui qui est le meilleur envers sa femme »</em> (Tirmidhi 3895). On cite souvent ce hadith aux hommes. Mais il y a un principe plus large dedans : la bonté conjugale est un <em>système</em>. Si un seul des deux l''alimente, le système fatigue.</p>

<p>La loyauté, c''est le socle. Elle ne suffit pas à nourrir un couple, mais sans elle, rien ne pousse. Tu en as déjà — c''est énorme. Ce qui reste à faire, c''est plus léger que tu ne crois : réintroduire du soin. Pas grand-chose. Une main posée. Une question sincère. Un soir sans téléphone.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M2.3', 'eloignes', 5, 'Les 3 pièges de la distance (et comment les éviter)', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>Les Éloignés tombent souvent dans trois pièges. Je te les nomme pour que tu les repères chez toi.</p>

<p><strong>Piège 1 — Le « c''est normal après X ans »</strong>. Non, ce n''est pas normal. C''est <em>fréquent</em>, ce n''est pas pareil. Banaliser la distance, c''est accepter qu''elle grandisse. Beaucoup de couples qui durent 40 ans te diront : on a traversé trois ou quatre zones de distance, et à chaque fois on s''est dit <em>« ce n''est pas ce qu''on veut »</em>.</p>

<p><strong>Piège 2 — Attendre que ça revienne tout seul</strong>. Le désir, l''envie, la complicité — ce ne sont pas des phénomènes météo. Ils ne reviennent pas spontanément si tu ne changes rien. Ils répondent à des gestes, à des rituels, à du temps partagé.</p>

<p><strong>Piège 3 — Confondre distance et incompatibilité</strong>. <em>« On n''a plus rien à se dire »</em>, c''est rarement vrai. C''est plutôt <em>« on a cessé de chercher ce qu''on a à se dire »</em>. L''incompatibilité se teste sur des essais — pas sur des constats faits depuis le canapé.</p>

<p>La sortie du piège, c''est souvent un rendez-vous — un vrai, dans l''agenda, sans enfants, sans écrans. Ton PDF en propose plusieurs déclinaisons.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M2.4', 'eloignes', 9, 'M. et Y. — la playlist qui a fait la bascule', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>M. et Y. sont venus me voir il y a un an et demi. 8 ans de mariage, 2 enfants, lui cadre, elle infirmière. Ils m''ont dit en substance : <em>« on ne se dispute jamais, on n''a plus grand-chose à se dire non plus ».</em></p>

<p>Pas de crise. Pas de colère. Juste une vie qui tourne, deux emplois du temps qui se croisent, et deux personnes qui s''étaient oubliées l''une l''autre.</p>

<p>Je leur ai posé une seule question en séance 2 : <em>« Qu''est-ce que vous écoutiez en voiture quand vous étiez fiancés ? »</em> Ils se sont regardés, ont ri, ont cherché. Une playlist des années 2013-2014. Ils l''ont retrouvée.</p>

<p>La séance suivante, M. m''a dit : <em>« on a mis la playlist un samedi en cuisinant. On s''est parlé pendant 2 heures. On ne savait plus qu''on pouvait faire ça. »</em></p>

<p>Ce n''est pas magique. Ce n''est pas une formule. C''est juste : <em>retrouver les gestes d''avant, quand on s''aimait sans y penser</em>. La distance se traverse souvent par l''arrière — par la mémoire vive du début — pas par la grande conversation de reconstruction.</p>

<p>Ton PDF propose une variante de cet exercice. Essaie-le.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M2.5', 'eloignes', 12, '5 jours pour sortir de la cohabitation', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>On arrive au bout. Si ces emails t''ont parlé, c''est que quelque chose en toi refuse la distance comme destination.</p>

<p>Je voulais te parler d''une chose concrète, qui colle bien aux Éloignés : <strong>IntimTalk</strong>. C''est un défi de 5 jours que j''ai construit pour les couples musulmans qui veulent relancer la parole conjugale.</p>

<p>Chaque jour, vous recevez un micro-exercice (5-10 minutes, ensemble). Des questions simples, pensées pour passer de la logistique à la personne. Pas de mise à nu, pas d''exposition. Juste des petits ponts, jetés à deux.</p>

<p>Ce qui marche pour les Éloignés, c''est <em>l''effet de rituel</em> : 5 jours d''affilée, vous vous retrouvez 10 minutes par soir sur quelque chose qui n''est pas les enfants, les courses, ou la belle-mère. Pour beaucoup, c''est le premier rituel conjugal depuis des années.</p>

<p>Tarif : <strong>49€</strong>. Acheté une fois, tes exercices à vie.</p>

<p><a href="https://buy.stripe.com/4gM00j8JX9GN2Qv6J71kA03">→ Commencer IntimTalk (49€)</a></p>

<p>Et si ce n''est pas le bon moment, ce n''est pas grave. Relire ton PDF et appliquer 2-3 micro-actions, c''est déjà un chemin, inch''Allah.</p>

<p>Souade</p>

<p><em>PS — Si tu veux en discuter d''abord en 1-1 : <a href="https://tidycal.com/souadetaje">réserver une consultation</a>.</em></p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M3.1', 'debordes', 0, '{{firstName}}, ton portrait est arrivé', 'Tu es un couple « Débordé ». La parentalité a mangé le couple — et c''est réparable.', '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">
<span style="display:none;font-size:0;color:transparent;line-height:0;max-height:0;max-width:0;opacity:0;overflow:hidden;">Tu es un couple « Débordé ». La parentalité a mangé le couple — et c''est réparable.</span>
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>Tu viens de faire le quiz et ton couple se reconnaît dans ce que j''appelle <em>Les Débordés</em>.</p>

<p>Si je devais te résumer ce profil en une phrase : <em>« vous êtes une équipe parentale géniale, et un couple qui se cherche »</em>. Tu aimes ton conjoint·e, tu aimes tes enfants. Mais tu ne sais plus très bien, certains soirs, si vous êtes encore un couple ou deux coéquipiers qui gèrent la même logistique.</p>

<p>C''est normal, {{firstName}}. Les jeunes parents musulmans qui viennent me voir sont quasiment tous passés par là. Le couple redevient visible quand on décide de le rendre visible — pas avant.</p>

<p><a href="{{quiz_v2_pdf_url}}">→ Télécharger mon portrait complet (PDF)</a></p>

<p>Dans les 12 prochains jours, tu vas recevoir 4 autres emails courts. Chacun approfondit un angle : la force principale des Débordés, les pièges classiques, un témoignage anonymisé, et une invitation pour aller plus loin si ça te parle.</p>

<p>Le couple n''est pas <em>après</em> les enfants. Il est <em>avec</em> eux. Et ça, ça s''entretient.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M3.2', 'debordes', 2, 'Ta force, c''est la coopération — et c''est précieux', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>La grande force des Débordés, c''est <em>la coopération</em>. Tu as construit une équipe. Tu sais qui gère l''école le lundi, qui prend les rendez-vous du pédiatre, qui fait la lessive du vendredi. Tu as un <em>système</em>. Et ce système tient dans des conditions difficiles : fatigue, bébé qui se réveille, famille qui demande, boulot qui déborde.</p>

<p>Ce n''est pas rien. Beaucoup de couples éclatent sur ce terrain-là. Le tien a tenu.</p>

<p>Salman al-Farisi a dit à Abu Darda — et le Prophète ﷺ a confirmé (Bukhari 1968) : <em>« Ton Seigneur a un droit sur toi, ton âme a un droit sur toi, ta famille a un droit sur toi. Donne à chacun son dû. »</em> Ce hadith est souvent cité pour l''équilibre spirituel. Mais il y a quelque chose dedans pour toi, {{firstName}} : <em>« ta famille » inclut ton conjoint·e — pas seulement tes enfants</em>. Le couple fait partie intégrante des droits que vous vous devez, au même titre que ton âme et ton Seigneur.</p>

<p>Ta force de coopération, elle peut être orientée vers les enfants — et aussi vers vous. Le même sens de l''organisation qui gère les lunchs scolaires peut planifier une soirée à deux. C''est même plus facile, parce que tu sais déjà le faire.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M3.3', 'debordes', 5, 'Les 3 pièges du couple débordé', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>Les Débordés tombent souvent dans trois pièges. Je te les nomme.</p>

<p><strong>Piège 1 — « On se retrouvera quand les petits seront grands »</strong>. Sauf que « grands » n''arrive jamais. À 3 ans ils demandent de l''attention, à 10 ans ils ont des activités, à 15 ils ont des émotions à gérer, à 20 ils partent et tu découvres quelqu''un que tu ne connais plus vraiment. Le couple s''entretient <em>pendant</em>, pas après.</p>

<p><strong>Piège 2 — La fatigue comme excuse universelle</strong>. Oui, tu es fatigué·e. C''est réel. Mais la fatigue est une raison, pas une destination. Un couple qui ne met plus rien sur le calendrier parce que <em>« on est trop fatigués »</em> devient, petit à petit, un couple qui ne se voit plus. Pose le rituel <em>avant</em> que la fatigue négocie.</p>

<p><strong>Piège 3 — La parentalité nocturne prolongée</strong>. Co-sleeping, bébé qui passe au lit, enfants qui squattent le salon tard — autant de configurations qui effacent l''espace conjugal. Si tu veux que ton couple ait de la place, il faut une place <em>physique</em>, pas seulement mentale.</p>

<p>Sortie des pièges : ton PDF propose 10 micro-actions, dont un rendez-vous mensuel, une nuit à l''extérieur, un check-in de 5 minutes chaque soir.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M3.4', 'debordes', 9, 'A. et H. — la règle du vendredi soir', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>A. et H. sont venus me voir il y a deux ans. 3 enfants de 2, 5 et 8 ans. Elle enseignante, lui indépendant. Elle m''a dit en première séance : <em>« je ne sais plus ce qui me plaît chez lui, et lui non plus je crois »</em>. Il a ri doucement, un peu triste. Ils n''étaient pas en crise. Ils étaient en gestion.</p>

<p>On a posé ensemble une seule règle, au bout de la troisième séance : <em>le vendredi soir à partir de 21h</em>, pas de téléphone, pas de tâche ménagère, pas d''enfant dans la chambre. 1 heure pour eux deux. N''importe quoi — un thé, une série, du silence, une conversation.</p>

<p>Ils ont tenu la règle 6 semaines. Pas toutes parfaites. Un soir la grande est tombée malade, ils ont fait comme ils ont pu. Un soir elle s''est endormie devant un film. Un soir, il m''a rapporté ça : <em>« elle m''a dit qu''elle trouvait que je prenais bien soin des enfants. Je ne savais plus qu''elle me regardait encore ».</em></p>

<p>Ce n''est pas une thérapie intensive. C''est un rituel tenu. Les Débordés ne se réparent pas par des grandes conversations — ils se réparent par <em>un créneau hebdomadaire protégé</em>. Essaie ça avant tout le reste.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M3.5', 'debordes', 12, '5 soirs de 10 minutes — juste vous deux', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>On arrive au bout. Si ces emails t''ont parlé, c''est qu''il y a un coin de toi qui sait que le couple mérite plus que la logistique.</p>

<p>Je voulais te proposer <strong>IntimTalk</strong>. C''est un défi de 5 jours, pensé exactement pour des couples comme le tien : fatigués, pressés, mais qui veulent quand même remettre 10 minutes par soir dans leur couple.</p>

<p>Chaque jour pendant 5 jours, vous recevez un micro-exercice (5-10 min). Questions simples, bienveillantes, dans un cadre pudique. Après les enfants couchés, juste vous deux, avec un thé. Cinq soirs, c''est faisable même dans une vie chargée.</p>

<p>Ce que j''entends souvent de la part des couples Débordés qui l''ont fait : <em>« on a redécouvert qu''on pouvait se parler sans que ça concerne les enfants »</em>. C''est l''enjeu exact.</p>

<p>Tarif : <strong>49€</strong> — acheté une fois, à vie. Le prix d''une pizza à deux — mais c''est un investissement couple durable.</p>

<p><a href="https://buy.stripe.com/4gM00j8JX9GN2Qv6J71kA03">→ Commencer IntimTalk (49€)</a></p>

<p>Et si ce n''est pas le moment, aucune pression. Relire ton PDF et tenir 1 seul rituel (le rendez-vous mensuel, par exemple) pendant 3 mois — c''est déjà énorme.</p>

<p>Souade</p>

<p><em>PS — Couple en difficulté plus lourde ? <a href="https://tidycal.com/souadetaje">Consultation 1-1</a> (45 min).</em></p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M4.1', 'en-construction', 0, '{{firstName}}, ton portrait est arrivé', 'Vos 3 premières années posent les fondations. Voici le portrait.', '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">
<span style="display:none;font-size:0;color:transparent;line-height:0;max-height:0;max-width:0;opacity:0;overflow:hidden;">Vos 3 premières années posent les fondations. Voici le portrait.</span>
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>Tu as fait le quiz et ton couple se reconnaît dans ce que j''appelle <em>Les En-Construction</em>.</p>

<p>Si je devais te résumer ce profil : <em>« vous êtes mariés depuis moins de 3 ans, pleins d''élan, en apprentissage mutuel, parfois à vif »</em>. Les disputes sont intenses parce que les codes ne sont pas encore posés. Les moments de grâce aussi sont intenses, parce que tout est nouveau.</p>

<p>Ne t''inquiète pas si certains jours ça tangue. Les premières années sont rarement lisses. Ce qui compte, c''est la direction : est-ce que chaque dispute vous apprend quelque chose, ou est-ce qu''elle creuse un sillon que vous rejouez ensuite ?</p>

<p><a href="{{quiz_v2_pdf_url}}">→ Télécharger mon portrait complet (PDF)</a></p>

<p>Dans les 12 jours qui viennent, 4 emails courts : ta force principale, les pièges classiques des premières années, un témoignage anonymisé, et une invitation pour aller plus loin.</p>

<p>Les couples qui durent 30 ans sont d''abord passés par les 3 premières années. Tu es dans la bonne phase — celle où <em>ce qui se règle maintenant évite les grands problèmes plus tard</em>.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M4.2', 'en-construction', 2, 'Ta force, c''est l''élan — et il vaut de l''or', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>La grande force des En-Construction, c''est <em>l''élan</em>. Vous avez encore la curiosité l''un de l''autre. Vous découvrez, vous posez des questions, vous vous regardez avec intérêt. Ce n''est pas rien. Des couples mariés depuis 15 ans me disent parfois : <em>« on voudrait juste retrouver la curiosité du début »</em>. Toi, tu l''as. C''est du carburant.</p>

<p>Le défi des En-Construction, ce n''est pas l''élan — c''est <em>apprendre à le gérer en période de friction</em>. L''élan fait que tu aimes avec intensité. Il fait aussi que tu te déçois avec intensité. Quand la grande curiosité du début rencontre la petite réalité quotidienne — les chaussettes, la famille, les silences — il y a parfois un vertige.</p>

<p>C''est là que le <em>jihad an-nafs</em> prend sens dans le couple. Le grand combat doux contre soi-même : apprendre à ne pas répondre à chaud, apprendre à céder sans se perdre, apprendre à différer un point de désaccord pour le reprendre à froid.</p>

<p>Ton élan est une force. Ta patience avec l''autre sera ce qui la rend durable. Les deux s''apprennent, alhamdoulilah.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M4.3', 'en-construction', 5, 'Les 3 pièges des premières années', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>Les En-Construction tombent souvent dans trois pièges. Je te les nomme.</p>

<p><strong>Piège 1 — Confondre différence et incompatibilité</strong>. Vos deux familles ne font pas pareil. Pas grave. Vos deux cultures spirituelles ont des nuances. Pas grave. Une différence, ce n''est pas une incompatibilité — c''est une négociation à poser. Ce qui devient incompatible, c''est quand on refuse d''en parler.</p>

<p>Des couples mariés depuis 2 ans me disent : <em>« on ne mange pas pareil, on ne prie pas pareil, on ne pense pas pareil »</em>. Je leur réponds : <em>« c''est normal. Faites-en un sujet, pas un verdict. »</em></p>

<p><strong>Piège 2 — Ne pas se donner le droit de ne pas tout savoir</strong>. À 25 ans, 28 ans, 32 ans, beaucoup pensent qu''un bon couple se fait intuitivement. Faux. Un couple, ça s''apprend. Lire, échanger avec des couples plus anciens, consulter — ce sont des compétences, pas des faiblesses.</p>

<p><strong>Piège 3 — L''intimité sexuelle vécue comme une performance</strong>. Les premières années posent le socle de la sexualité conjugale. Si elle est vécue comme <em>« il faut bien faire »</em>, elle devient stressante. Si elle est explorée avec curiosité et douceur, elle devient un terrain commun.</p>

<p>Ton PDF propose 10 micro-actions pour traverser ces pièges.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M4.4', 'en-construction', 9, 'R. et K. — la dispute qui les a sauvés', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>R. et K. étaient mariés depuis 18 mois quand ils sont venus me voir. Elle 27 ans, lui 30. Ils s''aimaient. Ils se disputaient aussi — des disputes intenses, de couleur, rapides à enflammer et longues à éteindre.</p>

<p>Le sujet du jour où ils sont venus : les vacances. Elle voulait sa famille (Maroc). Lui voulait la sienne (Tunisie). Chacun défendait sa position avec une ferveur qui dépassait largement l''enjeu réel.</p>

<p>On a mis 3 séances à défaire la dispute. Ce n''était pas les vacances. C''était : <em>« est-ce que ta famille passe avant la mienne ? »</em> Et derrière : <em>« est-ce que je compte autant que tes parents ? »</em> Des questions de fondation, pas de logistique.</p>

<p>La règle qu''on a posée ensuite : <em>« quand la dispute dure plus de 15 minutes, on fait une pause de 2 heures, et on revient dessus en disant ce qu''il y a vraiment derrière ».</em> 2 ans après, ils appliquent toujours. Et leurs disputes durent rarement plus de 20 minutes, parce qu''elles vont vite au fond.</p>

<p>Les premières années, c''est ça : apprendre à lire le message sous le message. Pas facile, mais ça se forme.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M4.5', 'en-construction', 12, 'Commencer par les bonnes questions', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>On arrive au bout. Si ces emails t''ont parlé, c''est qu''il y a un réflexe d''apprentissage en toi — précieux pour un jeune couple.</p>

<p>Je voulais te parler d''<strong>IntimTalk</strong>. C''est un défi de 5 jours que j''ai construit pour les couples musulmans qui veulent mettre en place de <em>bonnes habitudes de parole</em> dès le début. Pas une thérapie — une gym conjugale.</p>

<p>Chaque soir pendant 5 jours, vous recevez un micro-exercice (5-10 min). Questions simples, progressives, pensées pour apprendre à <em>vous dire les choses</em> : ce qui va, ce qui ne va pas, ce qui pourrait aller mieux. Avant que les 3 ans de mariage aient installé des plis durables.</p>

<p>Ce qui marche pour les En-Construction, c''est d''acquérir un <em>réflexe</em>. Après 5 jours d''exercices, les couples qui l''ont fait me disent souvent : <em>« on a retrouvé un espace pour se parler qu''on avait déjà commencé à perdre ».</em> À 25 mois de mariage, déjà. C''est parlant.</p>

<p>Tarif : <strong>49€</strong>, une fois, à vie.</p>

<p><a href="https://buy.stripe.com/4gM00j8JX9GN2Qv6J71kA03">→ Commencer IntimTalk (49€)</a></p>

<p>Et si ce n''est pas le bon moment — relire le PDF, tenir 2-3 micro-actions pendant un mois, c''est déjà un bon pas. Les fondations se posent lentement, bismillah.</p>

<p>Souade</p>

<p><em>PS — Besoin d''un regard clinique sur une dynamique précise ? <a href="https://tidycal.com/souadetaje">Consultation 1-1</a>.</em></p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M5.1', 'complices-fatigues', 0, '{{firstName}}, ton portrait est arrivé', '10+ ans de mariage. L''étincelle n''est pas morte — elle dort.', '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">
<span style="display:none;font-size:0;color:transparent;line-height:0;max-height:0;max-width:0;opacity:0;overflow:hidden;">10+ ans de mariage. L''étincelle n''est pas morte — elle dort.</span>
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>Tu as fait le quiz et ton couple se reconnaît dans ce que j''appelle <em>Les Complices-Fatigués</em>.</p>

<p>Si je devais résumer : <em>« vous vous aimez profondément, vous êtes des alliés éprouvés, et l''étincelle quotidienne s''est émoussée »</em>. Pas éteinte. Émoussée. Nuance importante.</p>

<p>Ce profil est un <em>passage</em>, pas une destination. Beaucoup de couples mariés depuis 12, 15, 20 ans traversent cette zone — certains la nomment, la travaillent, en sortent. D''autres s''y installent par défaut et découvrent, 10 ans plus tard, qu''ils ne se reconnaissent plus. La différence, c''est <em>qu''on regarde</em>, ou non.</p>

<p>Toi, tu regardes. C''est la première moitié du travail.</p>

<p><a href="{{quiz_v2_pdf_url}}">→ Télécharger mon portrait complet (PDF)</a></p>

<p>Dans les 12 prochains jours, tu recevras 4 emails courts : ta force principale, 3 pièges classiques, un témoignage anonymisé, une invitation pour aller plus loin si ça te parle.</p>

<p>Allah a mis, dans le couple, <em>mawaddah wa rahma</em> — l''affection et la miséricorde (Ar-Rum 30:21). L''affection, ça se ravive. La miséricorde, ça se cultive. Ni l''une ni l''autre ne sont des acquis définitifs.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M5.2', 'complices-fatigues', 2, 'Ta force, c''est la profondeur — ne la gaspille pas', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>La grande force des Complices-Fatigués, c''est <em>la profondeur de lien</em>. Vous avez traversé. Des naissances, des deuils peut-être, des déménagements, des périodes financières tendues, des disputes familiales — et vous êtes toujours ensemble. Vous vous connaissez par cœur. Vous pouvez lire une phrase dans un regard, un silence dans un plissement de front.</p>

<p>C''est un trésor, {{firstName}}. Beaucoup de couples de 3 ans donneraient cher pour cette profondeur. Elle ne s''invente pas — elle se construit par les années et par ce qu''on y a traversé ensemble.</p>

<p>Le piège, c''est que cette profondeur devienne <em>une excuse pour ne plus se parler</em>. <em>« On se connaît tellement qu''on n''a plus besoin de mots »</em> — tu as peut-être déjà entendu cette phrase, ou tu l''as peut-être déjà dite. C''est un faux ami. La connaissance mutuelle alimente la complicité <em>si on la renouvelle</em> ; sinon elle devient une carte périmée d''un territoire qui a évolué.</p>

<p>Tu n''es plus la personne que tu étais à 25 ans. Ton conjoint·e non plus. Ce qui vous liait à 25 ans reste — mais ce qui vous lierait à 45 ne se découvre pas sans le chercher.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M5.3', 'complices-fatigues', 5, 'Les 3 pièges du couple long', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>Les Complices-Fatigués tombent souvent dans trois pièges. Je te les nomme.</p>

<p><strong>Piège 1 — Le « on n''a plus rien à découvrir »</strong>. Si tu penses tout savoir de l''autre, c''est que tu as arrêté de poser des questions. Il y a une énorme différence entre la personne que ton conjoint·e <em>était</em> à 28 ans et celle qu''il ou elle <em>est</em> à 42. Ses peurs ont changé. Ses rêves aussi. Ce qui le ou la fait rire, souffrir, espérer — tout a bougé. Pose à nouveau les questions.</p>

<p>⚠️ <em>Note : si tu as déjà essayé de reparler et que ton conjoint·e réagit avec agacement ou fermeture, ne prends pas ça pour un rejet personnel. Après 10 ans, certains conjoint·es se sont installés dans un rythme et toute tentative de changement les insécurise. Ce n''est pas contre toi — c''est contre le changement lui-même. La patience paie, inch''Allah.</em></p>

<p><strong>Piège 2 — L''intimité sexuelle devenue prévisible</strong>. Même lieu, même moment, même geste. Rien de mal à ça en soi — sauf que la prévisibilité finit par désengager les deux corps. Varier les moments, les lieux (dans l''intimité du foyer), les approches : c''est un renouvellement, pas une révolution.</p>

<p><strong>Piège 3 — Accepter la routine comme identité</strong>. <em>« C''est comme ça, on est vieux »</em>. Tu as peut-être 42 ans. Ce n''est pas vieux. C''est le milieu du couple. 40 ans encore possibles devant vous incha Allah.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M5.4', 'complices-fatigues', 9, 'F. et O. — 15 ans de mariage, 3 questions qui ont tout bougé', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>F. et O. sont venus me voir il y a 8 mois. 15 ans de mariage, 4 enfants dont l''aîné à l''université. Elle me disait : <em>« on est comme un frère et une sœur un peu trop proches. On s''aime mais ça fait 4 ans que je n''ai plus envie, et lui non plus je crois »</em>.</p>

<p>Pas de conflit. Pas de trahison. Une longue amitié conjugale, pleine de tendresse, et un désert érotique.</p>

<p>On a fait en séance 3 un exercice simple : chacun écrit, sans l''autre, la réponse à trois questions. <em>Qu''est-ce qui te fait rêver aujourd''hui ? Qu''est-ce que tu n''as jamais osé me dire ? Qu''est-ce que tu veux qu''on fasse avant d''être vieux ?</em></p>

<p>Ils sont revenus la séance suivante avec leurs feuilles. Ils les ont lues à voix haute, sans commentaire. F. m''a raconté après : <em>« j''ai découvert qu''il voulait faire le Hajj avec moi et qu''il n''avait jamais osé me le dire parce qu''il pensait que je préférais l''argent pour les enfants. Et moi, j''ai réalisé que j''avais envie de reprendre la danse — quelque chose que j''avais arrêté à 22 ans. »</em></p>

<p>Ils n''ont pas changé de vie. Ils ont changé de conversation. Le désir est revenu — pas tout de suite, pas totalement, mais il est revenu. Parce qu''ils ont recommencé à se découvrir.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M5.5', 'complices-fatigues', 12, '5 jours pour poser les questions qu''on ne pose plus', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>On arrive au bout. Si tu lis encore, c''est que quelque chose en toi refuse l''idée qu''après 10 ou 15 ans, le couple serait forcément sur pilote automatique.</p>

<p>Je voulais te parler d''<strong>IntimTalk</strong>. C''est un défi de 5 jours construit pour les couples musulmans qui veulent <em>réveiller la parole</em> — sans thérapie lourde, sans grand déballage, sans rendez-vous au cabinet.</p>

<p>Chaque soir pendant 5 jours, vous recevez une question ou un micro-exercice (5-10 minutes). Des questions qui ne se posent plus après 10 ans. <em>Qu''est-ce qui t''a touché cette semaine ? Qu''est-ce qui te manque ? Qu''est-ce que tu veux qu''on essaye ?</em></p>

<p>Ce que les Complices-Fatigués qui l''ont fait me disent souvent : <em>« on a découvert qu''on pouvait avoir une conversation de 2 heures sans parler des enfants ni du boulot. On ne savait plus »</em>. Le désir n''est pas séparé de la parole. Souvent, remettre de la parole, c''est remettre de la curiosité. Et la curiosité est la mère du désir.</p>

<p>Tarif : <strong>49€</strong>, une fois pour toujours.</p>

<p><a href="https://buy.stripe.com/4gM00j8JX9GN2Qv6J71kA03">→ Commencer IntimTalk (49€)</a></p>

<p>Si ce n''est pas le moment, pas de problème. Les 10 micro-actions du PDF en contiennent plusieurs qui peuvent t''aider, tenues pendant 3 mois.</p>

<p>Souade</p>

<p><em>PS — Si tu veux un espace plus profond pour regarder ta dynamique de couple long : <a href="https://tidycal.com/souadetaje">consultation 1-1</a>.</em></p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M6.1', 'survivants', 0, '{{firstName}}, ton portrait est arrivé', 'Tu as traversé une épreuve majeure. Être encore là, c''est déjà immense.', '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">
<span style="display:none;font-size:0;color:transparent;line-height:0;max-height:0;max-width:0;opacity:0;overflow:hidden;">Tu as traversé une épreuve majeure. Être encore là, c''est déjà immense.</span>
<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>Tu as fait le quiz et ton couple se reconnaît dans ce que j''appelle <em>Les Survivants</em>.</p>

<p>{{firstName}}, je veux te dire quelque chose d''emblée, avant d''aller plus loin : <em>tu n''es pas seul·e</em>. Ce profil est celui d''un couple qui a traversé une épreuve majeure — trahison, conflit grave, perte, difficulté familiale lourde — et qui tient encore. C''est déjà immense. Beaucoup ne tiennent pas. Toi, tu tiens.</p>

<p>Mais je veux aussi être honnête : la reconstruction d''un couple abîmé, ça ne se fait pas par email, et ça ne se fait presque jamais seul·e. Les emails que je vais t''envoyer sont une main tendue, pas un protocole de soin. Un protocole de soin, il demande un accompagnement thérapeutique — individuel et/ou de couple.</p>

<p><a href="{{quiz_v2_pdf_url}}">→ Télécharger mon portrait complet (PDF)</a></p>

<p>Dans les 12 jours qui viennent, tu recevras 4 emails courts. Je vais te parler de ta force (et elle existe, même si tu ne la vois plus), des pièges classiques, d''un témoignage, et d''une invitation pour aller plus loin.</p>

<p>La porte de la <em>tawba</em> reste ouverte tant que l''âme vit. La porte de la reconstruction aussi. Va à ton rythme, ne reste pas seul·e, et sois tendre avec toi — ce que tu vis demande du temps.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M6.2', 'survivants', 2, 'Ta force, c''est la vérité — et c''est rare', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>La grande force des Survivants, c''est <em>la vérité</em>. Fini le déni. Fini la façade. Tu as touché quelque chose de réel — une faille, une blessure, une rupture — et tu ne peux plus faire semblant. C''est douloureux, et c''est aussi un cadeau rare.</p>

<p>Beaucoup de couples passent 30 ans sans oser dire ce qui ne va pas. Ils vivent en surface, maintiennent une apparence, et ne touchent jamais au fond. Toi, tu as été forcé·e d''y aller. Ce n''est pas confortable. Mais c''est un point de départ que d''autres couples mettent des décennies à atteindre.</p>

<p>La lucidité est une grâce, alhamdoulilah. Elle fait mal, elle est désorientante, mais elle est une matière première. Ce que tu reconstruis <em>depuis</em> cette vérité, s''il se reconstruit, sera plus solide que ce qui était avant. Plus vrai. Plus incarné. Les couples que j''ai suivis et qui ont traversé une trahison, un conflit grave, une crise majeure — quand ils s''en sont sortis, ce n''était pas en revenant « comme avant ». C''était en construisant <em>quelque chose d''autre</em>.</p>

<p>Tu ne reviendras pas au point d''avant. Tu iras ailleurs. Et l''ailleurs, s''il se travaille, peut être plus beau.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M6.3', 'survivants', 5, 'Les 3 pièges de la reconstruction', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>Les Survivants tombent souvent dans trois pièges. Je te les nomme avec douceur — et avec fermeté, parce qu''ils font vraiment mal.</p>

<p><strong>Piège 1 — Vouloir que tout reprenne comme avant</strong>. Non. Avant n''existe plus. Insister pour y revenir, c''est refuser ce qui s''est passé — et ça empêche la reconstruction. Fais le deuil d''avant. Vraiment. Doucement. Mais fais-le.</p>

<p><strong>Piège 2 — Rejouer la blessure tous les jours</strong>. La nommer, oui. La poser, oui. La remettre en scène chaque soir, non. Une blessure qu''on frotte tous les jours ne cicatrise pas. Pose-la. Reviens dessus quand tu es en séance, ou quand tu es stable — pas au milieu d''une dispute logistique.</p>

<p><strong>Piège 3 — Confondre pardon et oubli</strong>. Pardonner, ce n''est pas oublier. Pardonner, c''est décider de <em>ne plus être l''otage du passé</em>. Tu peux te souvenir, être vigilant·e, protéger tes besoins — et ne plus laisser la blessure te définir. Ces deux choses ne s''excluent pas.</p>

<p>Et je le redis : seul·e, c''est très difficile. La reconstruction se fait presque toujours avec un tiers professionnel. Le PDF propose 10 micro-actions — dont certaines à faire seul·e, d''autres à deux, et une ligne rouge : <em>ne reste pas sans accompagnement</em>.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M6.4', 'survivants', 9, 'T. et B. — 18 mois après la crise', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam {{firstName}},</p>

<p>T. et B. sont venus me voir il y a environ 2 ans. Mariés depuis 11 ans, 2 enfants. La raison : une crise familiale lourde du côté de T. avait mis à nu plusieurs non-dits du couple, et une forme de trahison émotionnelle ancienne avait refait surface.</p>

<p>La première séance, B. n''arrivait pas à regarder T. dans les yeux. T. ne savait pas par où commencer. Je leur ai dit : <em>« on ne va pas essayer de régler ça aujourd''hui. On va juste essayer d''être dans la même pièce sans se blesser davantage »</em>. C''était déjà le travail.</p>

<p>Le parcours a duré environ 14 mois — pas un mois de moins. Séances individuelles pour chacun, séances de couple en alternance, un thérapeute individuel de son côté à elle, des moments où l''un voulait arrêter et l''autre non, des rechutes, des retours en arrière.</p>

<p>18 mois plus tard, T. m''a dit : <em>« on n''est pas revenus où on était. On est ailleurs. Et on s''aime différemment. C''est plus fragile mais c''est plus vrai. »</em></p>

<p>Je te raconte ça pour que tu saches : <em>la reconstruction est lente</em>. Ne juge pas ton parcours sur 2 semaines ni 3 mois. Les couples qui s''en sortent sont rarement ceux qui cherchent une solution rapide — ce sont ceux qui acceptent d''aller en temps long.</p>

<p>Souade</p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

INSERT INTO public.quiz_v2_email_templates (mail_code, archetype, day_delay, subject, preheader, html, updated_at) VALUES ('M6.5', 'survivants', 12, '{{firstName}}, la suite (honnêtement)', NULL, '<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Azwaj · Mon Couple Aujourd''hui</title>
</head>
<body style="margin:0;padding:0;background:#F6F1EC;font-family:''Helvetica Neue'',Arial,sans-serif;color:#2B1E23;line-height:1.6;">

<table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F6F1EC;padding:32px 16px;">
  <tr><td align="center">
    <table role="presentation" width="560" cellspacing="0" cellpadding="0" border="0" style="background:#fff;border-radius:16px;overflow:hidden;max-width:560px;">
      <tr><td style="padding:36px 40px 24px 40px;text-align:center;border-bottom:2px solid #D4A24C;">
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:20px;color:#7C2D5A;font-weight:700;letter-spacing:2px;text-transform:uppercase;">Azwaj</div>
        <div style="font-family:''Playfair Display'',Georgia,serif;font-size:13px;color:#D4A24C;font-style:italic;margin-top:4px;">Mon Couple Aujourd''hui</div>
      </td></tr>
      <tr><td style="padding:32px 40px;font-size:16px;color:#2B1E23;line-height:1.65;">
        <p>Salam aleykoum {{firstName}},</p>

<p>On arrive au bout. Je veux être directe avec toi, {{firstName}} — plus qu''avec d''autres archétypes.</p>

<p>Pour les Survivants, la priorité absolue, c''est <strong>un accompagnement thérapeutique</strong>. Pas un défi de 5 jours. Pas une série d''emails. Un professionnel (psychologue, thérapeute de couple) qui te voit régulièrement, qui écoute le fond, qui te guide pendant le temps long de la reconstruction.</p>

<p>Si tu n''en as pas encore, c''est le pas numéro 1. Je peux t''accompagner en 1-1 si tu le veux, ou t''orienter vers un·e collègue :</p>

<p><a href="https://tidycal.com/souadetaje">→ Réserver une consultation (45 min)</a></p>

<p>En complément seulement — si vous avez déjà un accompagnement en place et que vous cherchez un <em>outil doux</em> à utiliser en couple entre les séances — <strong>IntimTalk</strong> peut avoir sa place. Le défi de 5 jours (49€) est pensé pour remettre de la parole, pas pour traiter une blessure.</p>

<p>Mais pour toi, je ne vais pas insister sur IntimTalk en premier. Ce n''est pas l''outil adapté à ta situation actuelle.</p>

<p>Ce qui est adapté : un accompagnement. Du temps. De la patience. Et la certitude que <em>la tawba — le retour — reste possible</em>, tant qu''il y a un souffle et une intention sincère chez l''un ou l''autre.</p>

<p>Prends soin de toi, {{firstName}}. Sincèrement.</p>

<p>Souade</p>

<p><em>PS — Si tu n''as pas encore de thérapeute et que tu hésites : <a href="https://tidycal.com/souadetaje">un premier entretien avec moi</a> peut aider à clarifier le chemin.</em></p>
      </td></tr>
      <tr><td style="padding:24px 40px 32px 40px;border-top:1px solid #eee;font-size:13px;color:#6E5A63;text-align:center;">
        <strong>Souade Taje</strong> — sexologue clinicienne (UCL), Bruxelles<br>
        <a href="https://azwaj.be" style="color:#7C2D5A;text-decoration:none;">azwaj.be</a>
        · <a href="{{unsubscribe_url}}" style="color:#6E5A63;">Se désinscrire</a>
      </td></tr>
    </table>
  </td></tr>
</table>
<div style="text-align:center;font-size:11px;color:#9a9a9a;margin:24px 0 8px 0;font-family:Arial,sans-serif;line-height:1.5;">Azwaj · Rue le Lorrain 110 · 1080 Bruxelles · Belgique</div>
</body></html>', now()) ON CONFLICT (mail_code) DO UPDATE SET archetype=EXCLUDED.archetype, day_delay=EXCLUDED.day_delay, subject=EXCLUDED.subject, preheader=EXCLUDED.preheader, html=EXCLUDED.html, updated_at=now();

