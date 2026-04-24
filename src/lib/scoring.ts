import { ARCHETYPES, TIE_BREAK_ORDER, HARMONIEUX_MIN_GAP, type ArchetypeId } from "@/data/archetypes";
import { getPoints, type Choice } from "@/data/questions";

export interface ScoreResult {
  winner: ArchetypeId;
  scores: Record<ArchetypeId, number>;
  percentages: Record<ArchetypeId, number>;
}

const MAX_PER_ARCHETYPE = 63; // 21 questions × 3 pts max = 63 (v2.1)

export function computeScore(answers: Choice[]): ScoreResult {
  const scores = {} as Record<ArchetypeId, number>;
  (Object.keys(ARCHETYPES) as ArchetypeId[]).forEach((a) => (scores[a] = 0));

  answers.forEach((choice, qi) => {
    const pts = getPoints(qi, choice);
    (Object.keys(pts) as ArchetypeId[]).forEach((a) => {
      scores[a] += pts[a];
    });
  });

  const percentages = {} as Record<ArchetypeId, number>;
  (Object.keys(scores) as ArchetypeId[]).forEach((a) => {
    percentages[a] = Math.round((scores[a] / MAX_PER_ARCHETYPE) * 100);
  });

  // Step 1 — meilleur score parmi les 6 archétypes problématiques (tie-break)
  let problemWinner: ArchetypeId = TIE_BREAK_ORDER[0];
  let problemBest = -1;
  for (const a of TIE_BREAK_ORDER) {
    if (scores[a] > problemBest) {
      problemBest = scores[a];
      problemWinner = a;
    }
  }

  // Step 2 — "Harmonieux" ne gagne QUE si son score dépasse de ≥ HARMONIEUX_MIN_GAP
  // le plus haut archétype problématique. Empêche qu'un couple avec signaux
  // d'alerte tombe en "Harmonieux" par défaut.
  const winner: ArchetypeId =
    scores.harmonieux >= problemBest + HARMONIEUX_MIN_GAP ? "harmonieux" : problemWinner;

  return { winner, scores, percentages };
}
