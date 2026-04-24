import type { ArchetypeId } from "./archetypes";

export type Choice = "A" | "B" | "C" | "D";

export interface Question {
  id: number;
  text: string;
  options: { key: Choice; label: string }[];
}

// Scoring matrix: question index (0-20) → choice → archetype → points (0-3)
// Columns: [Silencieux, Éloignés, Débordés, En-Construction, Complices-Fatigués, Survivants, Harmonieux]
// 21 questions × 3 pts max = 63 pts max par archétype (v2.1)
const ARCHETYPE_ORDER: ArchetypeId[] = [
  "silencieux",
  "eloignes",
  "debordes",
  "en-construction",
  "complices-fatigues",
  "survivants",
  "harmonieux",
];

// Compact form, one row per question. Columns: A,B,C,D. Each cell is the points for the 7 archetypes.
const RAW_MATRIX: Record<Choice, [number, number, number, number, number, number, number]>[] = [
  // Q1 durée
  { A: [0,0,1,3,0,0,0], B: [1,0,2,2,0,1,0], C: [1,1,1,0,1,1,0], D: [2,2,0,0,3,1,0] },
  // Q2 enfants
  { A: [1,0,0,2,0,0,0], B: [1,1,3,1,0,1,0], C: [1,1,2,0,1,1,0], D: [1,1,3,0,1,1,0] },
  // Q3 parler jour
  { A: [0,0,0,0,0,0,3], B: [1,1,2,1,1,1,1], C: [2,2,2,1,1,1,0], D: [3,3,2,1,2,2,0] },
  // Q4 conv intime
  { A: [0,0,0,0,0,0,3], B: [1,1,1,1,0,1,1], C: [3,2,1,1,2,1,0], D: [3,3,2,1,2,2,0] },
  // Q5 intimité phys (fréquence)
  { A: [0,0,0,0,0,0,3], B: [1,1,1,1,1,1,1], C: [2,2,2,1,2,2,0], D: [3,3,2,2,1,2,0] },
  // Q6 NEW (a) satisfaction sexuelle qualitative
  { A: [0,0,0,0,0,0,3], B: [1,0,1,1,1,1,1], C: [2,1,2,1,1,1,0], D: [3,2,1,1,1,2,0] },
  // Q7 disputes (ex-Q6)
  { A: [0,0,0,1,0,0,3], B: [1,1,1,2,1,1,1], C: [2,1,1,1,1,1,0], D: [2,2,1,1,1,3,0] },
  // Q8 NEW (h) présence non-verbale
  { A: [0,0,0,0,2,0,3], B: [0,1,0,0,1,0,1], C: [2,1,1,1,0,1,0], D: [2,2,0,0,0,2,0] },
  // Q9 spirituel ensemble (ex-Q7)
  { A: [0,0,0,0,0,0,3], B: [1,1,1,1,1,1,1], C: [2,2,1,1,1,1,0], D: [3,3,1,2,2,2,0] },
  // Q10 NEW (c) respect spiritualité
  { A: [0,0,0,0,0,0,3], B: [0,0,0,1,0,0,1], C: [2,1,1,0,1,1,0], D: [1,1,1,2,1,2,0] },
  // Q11 sortie couple (ex-Q8)
  { A: [0,0,0,0,0,0,3], B: [1,1,0,1,1,1,1], C: [2,2,3,1,1,1,0], D: [3,3,3,1,2,2,0] },
  // Q12 vision 5 ans (ex-Q9)
  { A: [0,0,0,2,0,0,3], B: [0,0,0,1,0,0,1], C: [2,2,1,0,1,2,0], D: [2,3,1,0,1,2,0] },
  // Q13 NEW (b) soutien stress externe
  { A: [0,0,0,0,0,0,3], B: [0,1,0,1,0,0,1], C: [1,2,1,1,0,1,0], D: [2,3,1,1,1,2,0] },
  // Q14 épreuve (ex-Q10)
  { A: [0,0,0,0,0,0,3], B: [0,0,0,0,0,0,2], C: [1,1,0,0,0,3,0], D: [1,2,1,1,1,3,0] },
  // Q15 rire (ex-Q11)
  { A: [0,0,0,0,0,0,3], B: [0,1,0,0,0,1,2], C: [1,2,1,1,2,1,0], D: [2,3,2,1,2,2,0] },
  // Q16 NEW (i) charge mentale
  { A: [0,0,0,0,0,0,3], B: [0,0,1,1,0,0,1], C: [1,0,3,0,0,1,0], D: [2,2,2,1,1,1,0] },
  // Q17 NEW (d) belle-famille
  { A: [0,0,0,0,0,0,3], B: [0,0,0,1,0,0,1], C: [1,1,2,1,1,2,0], D: [2,2,1,0,1,1,0] },
  // Q18 besoins non exp (ex-Q12)
  { A: [0,0,0,0,0,0,3], B: [1,1,1,1,1,1,1], C: [3,2,1,1,2,2,0], D: [3,3,1,2,2,2,0] },
  // Q19 rêves conjoint (ex-Q13)
  { A: [0,0,0,0,0,0,3], B: [1,1,0,1,1,1,1], C: [2,1,1,2,1,1,0], D: [3,2,1,2,1,2,0] },
  // Q20 saison (ex-Q14)
  { A: [1,0,0,3,0,0,1], B: [1,0,0,1,2,0,3], C: [1,1,2,0,3,1,0], D: [2,3,1,0,1,2,0] },
  // Q21 intention (ex-Q15)
  { A: [1,0,0,1,0,0,2], B: [2,1,1,2,1,1,1], C: [1,2,2,2,2,2,0], D: [2,2,1,1,1,3,0] },
];

export const QUESTIONS: Question[] = [
  {
    id: 1,
    text: "Depuis combien de temps êtes-vous mariés ?",
    options: [
      { key: "A", label: "Moins d'un an" },
      { key: "B", label: "1 à 3 ans" },
      { key: "C", label: "4 à 10 ans" },
      { key: "D", label: "Plus de 10 ans" },
    ],
  },
  {
    id: 2,
    text: "Avez-vous des enfants ?",
    options: [
      { key: "A", label: "Non" },
      { key: "B", label: "Oui, en bas âge (0-6 ans)" },
      { key: "C", label: "Oui, plus grands" },
      { key: "D", label: "Oui, de plusieurs âges (famille nombreuse)" },
    ],
  },
  {
    id: 3,
    text: "Vous parlez-vous chaque jour, vraiment, en dehors de la logistique ?",
    options: [
      { key: "A", label: "Oui, systématiquement" },
      { key: "B", label: "Souvent, mais en décrochant à cause du téléphone/TV" },
      { key: "C", label: "Rarement" },
      { key: "D", label: "Presque jamais" },
    ],
  },
  {
    id: 4,
    text: "Quand avez-vous eu une vraie conversation intime (émotions, peurs, rêves) pour la dernière fois ?",
    options: [
      { key: "A", label: "Cette semaine" },
      { key: "B", label: "Ce mois-ci" },
      { key: "C", label: "Il y a plusieurs mois" },
      { key: "D", label: "Je ne me souviens plus" },
    ],
  },
  {
    id: 5,
    text: "Votre intimité physique (baisers, tendresse, sexualité) est actuellement :",
    options: [
      { key: "A", label: "Fréquente et partagée avec plaisir" },
      { key: "B", label: "Variable, mais globalement partagée" },
      { key: "C", label: "Trop espacée à notre goût" },
      { key: "D", label: "Rare, inexistante ou difficile" },
    ],
  },
  {
    id: 6,
    text: "Quand vous êtes intimement ensemble, comment vous sentez-vous après ?",
    options: [
      { key: "A", label: "Proches, apaisés, connectés" },
      { key: "B", label: "Globalement bien, avec des variations" },
      { key: "C", label: "Un des deux reste souvent sur sa faim" },
      { key: "D", label: "On évite le sujet parce que ça tangue" },
    ],
  },
  {
    id: 7,
    text: "Quand vous vous disputez, comment cela se résout-il ?",
    options: [
      { key: "A", label: "On en parle et ça se règle dans les 24 h" },
      { key: "B", label: "Ça dure quelques jours puis ça passe" },
      { key: "C", label: "On ne se dispute pas vraiment (on évite le conflit)" },
      { key: "D", label: "Les disputes laissent des blessures qui reviennent" },
    ],
  },
  {
    id: 8,
    text: "Dans une pièce à deux, sans parler, vous vous sentez comment ?",
    options: [
      { key: "A", label: "En lien — un regard, un geste suffit" },
      { key: "B", label: "Bien, mais le silence peut durer longtemps" },
      { key: "C", label: "Inconfortable, on cherche une distraction" },
      { key: "D", label: "Étranger·es l'un à l'autre" },
    ],
  },
  {
    id: 9,
    text: "Partagez-vous des moments spirituels ensemble (prière, dhikr, lecture) ?",
    options: [
      { key: "A", label: "Oui, régulièrement" },
      { key: "B", label: "Parfois, à certains moments" },
      { key: "C", label: "Rarement" },
      { key: "D", label: "Jamais ou presque" },
    ],
  },
  {
    id: 10,
    text: "Comment vit votre couple les différences de rythme spirituel (pratique, niveau d'engagement) ?",
    options: [
      { key: "A", label: "En acceptant nos rythmes respectifs, sans jugement" },
      { key: "B", label: "Avec quelques tensions mais on en parle" },
      { key: "C", label: "L'un fait avec les choix de l'autre en silence" },
      { key: "D", label: "C'est source de tensions récurrentes" },
    ],
  },
  {
    id: 11,
    text: "Sortez-vous seuls en couple (sans enfants) ?",
    options: [
      { key: "A", label: "Au moins 1 fois par mois" },
      { key: "B", label: "Quelques fois par an" },
      { key: "C", label: "Presque jamais" },
      { key: "D", label: "Jamais depuis longtemps" },
    ],
  },
  {
    id: 12,
    text: "Quand vous pensez à votre couple dans 5 ans, vous imaginez…",
    options: [
      { key: "A", label: "Une version plus profonde et complice du couple actuel" },
      { key: "B", label: "Quelque chose de stable et prévisible" },
      { key: "C", label: "J'ai peur de ce que je vois" },
      { key: "D", label: "Je n'arrive plus à me projeter" },
    ],
  },
  {
    id: 13,
    text: "Quand l'un de vous traverse une période difficile (travail, famille, santé), l'autre est-il là ?",
    options: [
      { key: "A", label: "Toujours — on se sent soutenu·e" },
      { key: "B", label: "Souvent, mais chacun gère à sa manière" },
      { key: "C", label: "Rarement — on fonctionne en parallèle" },
      { key: "D", label: "Pas vraiment — on ne se le dit même pas" },
    ],
  },
  {
    id: 14,
    text: "Une épreuve majeure (trahison, conflit familial, deuil, maladie) a-t-elle touché votre couple cette année ou l'année dernière ?",
    options: [
      { key: "A", label: "Non, rien de majeur" },
      { key: "B", label: "Un défi, mais gérable" },
      { key: "C", label: "Oui, et on est en train de s'en remettre" },
      { key: "D", label: "Oui, et on n'est pas sortis de l'épreuve" },
    ],
  },
  {
    id: 15,
    text: "Quand avez-vous ri ensemble, vraiment, pour la dernière fois ?",
    options: [
      { key: "A", label: "Hier ou aujourd'hui" },
      { key: "B", label: "Cette semaine" },
      { key: "C", label: "Le mois dernier" },
      { key: "D", label: "Je ne me souviens plus" },
    ],
  },
  {
    id: 16,
    text: "La logistique du foyer (enfants, courses, factures, rendez-vous, organisation), c'est…",
    options: [
      { key: "A", label: "Partagée équitablement — chacun·e sait où iel en est" },
      { key: "B", label: "Plutôt déséquilibrée, mais on en parle et on ajuste" },
      { key: "C", label: "Je porte presque tout, c'est un poids" },
      { key: "D", label: "On ne parle pas de ça, chacun gère dans son coin" },
    ],
  },
  {
    id: 17,
    text: "La belle-famille ou la famille étendue, ça se passe comment dans votre couple ?",
    options: [
      { key: "A", label: "Les limites sont claires, chacun·e protège son couple" },
      { key: "B", label: "Quelques frictions ponctuelles qu'on règle à deux" },
      { key: "C", label: "Source récurrente de disputes entre vous" },
      { key: "D", label: "L'un vit ça seul·e, l'autre ne prend pas position" },
    ],
  },
  {
    id: 18,
    text: "Vos besoins sexuels ou affectifs non satisfaits, vous en parlez…",
    options: [
      { key: "A", label: "Ouvertement, sans gêne" },
      { key: "B", label: "Avec quelques maladresses mais on en parle" },
      { key: "C", label: "Rarement (trop de pudeur ou peur du rejet)" },
      { key: "D", label: "Jamais" },
    ],
  },
  {
    id: 19,
    text: "Votre conjoint connaît-il vos rêves personnels actuels (projets, envies profondes) ?",
    options: [
      { key: "A", label: "Oui, parfaitement" },
      { key: "B", label: "En grande partie" },
      { key: "C", label: "Partiellement, ou il/elle n'en mesure pas l'importance" },
      { key: "D", label: "Non, je ne me suis pas partagé·e moi-même" },
    ],
  },
  {
    id: 20,
    text: "Si votre couple était une saison, ce serait :",
    options: [
      { key: "A", label: "Un printemps (renouveau)" },
      { key: "B", label: "Un été (chaleur, plénitude)" },
      { key: "C", label: "Un automne (beauté mais fatigue)" },
      { key: "D", label: "Un hiver (froid, attente)" },
    ],
  },
  {
    id: 21,
    text: "Qu'êtes-vous venu·e chercher aujourd'hui en faisant ce quiz ?",
    options: [
      { key: "A", label: "Confirmer une intuition" },
      { key: "B", label: "Mettre des mots sur ce que je ressens" },
      { key: "C", label: "Trouver des pistes d'action" },
      { key: "D", label: "Comprendre ce qui ne va pas" },
    ],
  },
];

export function getPoints(
  questionIndex: number,
  choice: Choice,
): Record<ArchetypeId, number> {
  const tuple = RAW_MATRIX[questionIndex][choice];
  const out = {} as Record<ArchetypeId, number>;
  ARCHETYPE_ORDER.forEach((a, i) => {
    out[a] = tuple[i];
  });
  return out;
}

export { ARCHETYPE_ORDER };
