/**
 * AmbianceBackground — Azwaj atmospheric layer.
 * Fixed full-viewport background combining:
 *   - radial warm cream gradient
 *   - subtle SVG grain texture (via .bg-grain utility)
 *   - 8 floating golden particles (CSS .particles)
 *
 * Non-interactive (pointer-events: none). Respects prefers-reduced-motion.
 * Designed to sit *behind* all content (z-index: 0 at most; content should be > 0).
 */
const AmbianceBackground = () => {
  return (
    <>
      {/* Radial warm gradient layer */}
      <div
        aria-hidden
        className="fixed inset-0 -z-10 bg-gradient-warm-radial"
      />
      {/* Grain overlay (applied globally via .bg-grain on body-like wrapper).
          Kept separate so the grain sits above the gradient. */}
      <div aria-hidden className="fixed inset-0 -z-10 bg-grain" />
      {/* Floating gold particles */}
      <div aria-hidden className="particles">
        {/* 6 spans + ::before/::after = 8 particles total */}
        <span />
        <span />
        <span />
        <span />
        <span />
        <span />
      </div>
    </>
  );
};

export default AmbianceBackground;
