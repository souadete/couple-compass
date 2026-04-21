import { ARCHETYPES, TIE_BREAK_ORDER, type ArchetypeId } from "@/data/archetypes";
import { getPoints, type Choice } from "@/data/questions";

export interface ScoreResult {
  winner: ArchetypeId;
  scores: Record<ArchetypeId, number>;
  percentages: Record<ArchetypeId, number>;
}

const MAX_PER_ARCHETYPE = 45; // theoretical max per spec

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

  // Pick winner with tie-break
  let winner: ArchetypeId = TIE_BREAK_ORDER[0];
  let best = -1;
  for (const a of TIE_BREAK_ORDER) {
    if (scores[a] > best) {
      best = scores[a];
      winner = a;
    }
  }

  return { winner, scores, percentages };
}
