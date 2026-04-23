/**
 * Fisher-Yates shuffle — returns a new shuffled array, doesn't mutate input.
 * Used to randomize option order in each quiz question per session.
 * The scoring is unaffected because it keys on opt.key (A/B/C/D), not position.
 */
export function shuffleArray<T>(arr: readonly T[]): T[] {
  const a = arr.slice();
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}
