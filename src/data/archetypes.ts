export type ArchetypeId =
  | "silencieux"
  | "eloignes"
  | "debordes"
  | "en-construction"
  | "complices-fatigues"
  | "survivants"
  | "harmonieux";

export interface Archetype {
  id: ArchetypeId;
  name: string;
  shortLabel: string;
  description: string;
  forces: string[];
  challenges: string[];
  spiritual: string;
  actions: string[];
}

export const ARCHETYPES: Record<ArchetypeId, Archetype> = {
  silencieux: {
    id: "silencieux",
    name: "Les Silencieux",
    shortLabel: "Silencieux",
    description:
      "Vous vous aimez, mais l'intimité profonde (émotionnelle et sexuelle) est un territoire que vous explorez peu. La pudeur s'est parfois installée au détriment de la parole vraie.",
    forces: [
      "Respect mutuel profond",
      "Stabilité et prévisibilité rassurantes",
      "Sens du foyer comme sanctuaire",
    ],
    challenges: [
      "Frustrations refoulées qui fermentent dans le silence",
      "Besoins sexuels ou affectifs non exprimés",
      "Risque d'éloignement à long terme",
    ],
    spiritual:
      "Le mariage est appelé à être un lieu de mawaddah wa rahma — affection et tendresse mutuelles. Mettre des mots sur ce qui se vit n'est pas une rupture de pudeur, c'est l'honorer.",
    actions: [
      "Question du soir : « Qu'est-ce qui t'a touché aujourd'hui ? » (30 secondes)",
      "Règle du « je » : parler de ses ressentis plutôt que des faits",
      "10 minutes une fois par semaine pour dire ce qui a été difficile",
    ],
  },
  eloignes: {
    id: "eloignes",
    name: "Les Éloignés",
    shortLabel: "Éloignés",
    description:
      "Vous partagez un toit, des enfants peut-être, une vie administrative — mais l'intimité s'est éteinte depuis plusieurs mois. L'élan n'est plus là, et vous commencez à vous demander si c'est normal.",
    forces: [
      "Engagement solide (vous êtes encore là)",
      "Loyauté à long terme",
      "Conscience de la situation (vous avez fait ce quiz)",
    ],
    challenges: [
      "Distance affective prolongée (plus de 2 mois sans vraie connexion)",
      "Risque d'érosion du désir",
      "Sentiment de solitude dans le couple",
    ],
    spiritual:
      "L'intention (niyya) de reconnecter est déjà un premier pas. Le mariage demande entretien, comme tout ce qui est précieux.",
    actions: [
      "Un rendez-vous fixé (agenda partagé), sans enfants, cette semaine",
      "Toucher non-sexuel quotidien (main, épaule, étreinte de 20 sec)",
      "Une conversation sans téléphone, 15 min, hors logistique",
    ],
  },
  debordes: {
    id: "debordes",
    name: "Les Débordés",
    shortLabel: "Débordés",
    description:
      "Jeunes parents ou parents de plusieurs enfants, votre couple est passé au second plan. Vous vous aimez mais vous n'avez plus le temps ni l'énergie pour vous.",
    forces: [
      "Coopération parentale forte",
      "Complicité dans l'adversité quotidienne",
      "Vision alignée du projet familial",
    ],
    challenges: [
      "Identité de couple diluée dans l'identité de parents",
      "Fatigue chronique qui éteint le désir",
      "Peu d'espaces « juste nous deux »",
    ],
    spiritual:
      "Le couple est le socle, les enfants sont une bénédiction — mais ils ne doivent pas remplacer le lien conjugal qui les a fait naître.",
    actions: [
      "Rituel de 5 minutes à 2 après le coucher des enfants (thé + regard)",
      "1 nuit par mois à l'extérieur (babysitting famille ou amis)",
      "Reprendre de petits gestes d'avant-mariés (texto doux, attention)",
    ],
  },
  "en-construction": {
    id: "en-construction",
    name: "Les En-Construction",
    shortLabel: "En-Construction",
    description:
      "Vous êtes mariés depuis 0 à 3 ans. Vous êtes en apprentissage mutuel, parfois intense. Les disputes de fond révèlent que vous n'avez pas encore les codes de l'autre — et c'est normal.",
    forces: [
      "Énergie et élan de début",
      "Curiosité l'un de l'autre",
      "Rêves communs encore très vivaces",
    ],
    challenges: [
      "Différences familiales/culturelles en train d'émerger",
      "Apprentissage de la sexualité conjugale",
      "Frustrations non résolues qui risquent de se chroniciser",
    ],
    spiritual:
      "Les premières années comme jihad an-nafs : un combat doux contre soi-même pour apprendre à céder sans se perdre.",
    actions: [
      "Une règle non négociable : on ne se couche pas fâchés",
      "Check-in mensuel : « Qu'est-ce qui va bien / moins bien pour toi ? »",
      "Chercher un mentor couple (parent, ami, praticien) si bloqué",
    ],
  },
  "complices-fatigues": {
    id: "complices-fatigues",
    name: "Les Complices-Fatigués",
    shortLabel: "Complices-Fatigués",
    description:
      "Plus de 10 ans de mariage. Vous vous connaissez par cœur, vous vous aimez profondément, vous êtes des alliés. Mais l'étincelle, celle du désir neuf, est devenue rare. Ce n'est pas la fin — c'est un passage.",
    forces: [
      "Profondeur de lien inégalable",
      "Résilience éprouvée (vous avez traversé des tempêtes)",
      "Confiance mutuelle solide",
    ],
    challenges: [
      "Routine qui anesthésie le désir",
      "Risque de devenir colocataires affectueux",
      "Peur de raviver la flamme (effort, vulnérabilité)",
    ],
    spiritual:
      "Le mariage long est une sunnah, mais il doit rester vivant. La constance n'est pas l'immobilité.",
    actions: [
      "Un rendez-vous surprise par mois (l'un organise, l'autre découvre)",
      "Nouvelle activité commune (sport, cours, voyage court)",
      "3 questions « comme au début » : qu'est-ce qui te fait rêver ?",
    ],
  },
  survivants: {
    id: "survivants",
    name: "Les Survivants",
    shortLabel: "Survivants",
    description:
      "Vous venez de traverser une épreuve majeure : conflit grave, trahison, perte, difficulté familiale lourde. Vous êtes encore là, mais la confiance est fissurée.",
    forces: [
      "Vérité et lucidité (fini le déni)",
      "Capacité de dialogue forgée dans la douleur",
      "Engagement renouvelé (vous êtes encore là)",
    ],
    challenges: [
      "Méfiance résiduelle",
      "Cicatrices émotionnelles ouvertes",
      "Peur que ça recommence",
    ],
    spiritual:
      "La voie de la tawba et du pardon. La reconstruction demande temps et accompagnement — un professionnel est souvent utile.",
    actions: [
      "Un accompagnement thérapeutique (individuel ou de couple)",
      "Poser les bases verbalement : « voici ce dont j'ai besoin maintenant »",
      "Temps long, petits pas — ne pas tout vouloir récupérer en une fois",
    ],
  },
  harmonieux: {
    id: "harmonieux",
    name: "Les Harmonieux",
    shortLabel: "Harmonieux",
    description:
      "Votre couple fonctionne. Vous communiquez, vous vous respectez, vous cheminez ensemble — dans l'intime comme dans le quotidien. Ce n'est pas de la chance : c'est le fruit d'une attention constante que vous portez à votre lien. Félicitations.",
    forces: [
      "Dialogue ouvert et ajusté mutuellement",
      "Intimité vivante (émotionnelle, physique, spirituelle)",
      "Résilience dyadique face aux épreuves",
      "Projets et rêves partagés",
    ],
    challenges: [
      "L'équilibre reste un mouvement — pas un acquis définitif",
      "Les phases de la vie (enfants, crises, ménopause, transitions pro) testeront ces bases",
      "Ne pas tenir la complicité pour acquise — c'est ce qui la maintient",
    ],
    spiritual:
      "Ce que vous vivez est une manifestation de la mawaddah wa rahma décrite dans le Coran (Ar-Rûm 30:21). Ce n'est pas un accomplissement final, c'est une barakah à entretenir chaque jour par l'attention, le dialogue et la douʿa l'un pour l'autre.",
    actions: [
      "Continuez vos rituels de reconnexion — ne les laissez pas s'éroder par le confort",
      "Faites un bilan annuel à deux (rétrospective + intentions) — comme un « check-up » du couple",
      "Partagez votre expérience autour de vous avec humilité : vos exemples inspirent d'autres couples",
    ],
  },
};

// Tie-break order: most "urgent" archetypes win in case of equal score.
// NOTE: "harmonieux" n'apparaît PAS dans cet ordre — il est géré séparément
// dans scoring.ts avec la règle "gagne seulement si score > max_autres + 3"
// pour éviter qu'un couple avec des signaux d'alerte tombe par défaut dans ce profil sain.
export const TIE_BREAK_ORDER: ArchetypeId[] = [
  "survivants",
  "debordes",
  "eloignes",
  "en-construction",
  "silencieux",
  "complices-fatigues",
];

// Gap minimum requis pour que "Harmonieux" l'emporte sur le plus haut archétype problématique.
// Sinon, fallback sur le tie-break standard.
export const HARMONIEUX_MIN_GAP = 3;
