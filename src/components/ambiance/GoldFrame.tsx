/**
 * GoldFrame — thin geometric gold rectangle with rounded corners.
 * Placed behind a heading (absolute) to evoke the Azwaj "cadre doré géométrique flottant".
 *
 * Usage:
 *   <div className="relative inline-block">
 *     <GoldFrame />
 *     <h1 className="relative ...">Titre</h1>
 *   </div>
 */
const GoldFrame = ({ className = "" }: { className?: string }) => (
  <svg
    role="presentation"
    viewBox="0 0 100 100"
    preserveAspectRatio="none"
    xmlns="http://www.w3.org/2000/svg"
    className={
      "pointer-events-none absolute inset-0 w-full h-full animate-in fade-in duration-1000 " +
      className
    }
    aria-hidden
  >
    {/* Main rectangle — thin stroke, slight rounded corner */}
    <rect
      x="2"
      y="2"
      width="96"
      height="96"
      rx="1.2"
      ry="1.2"
      fill="none"
      stroke="hsl(39 60% 56% / 0.55)"
      strokeWidth="0.28"
      vectorEffect="non-scaling-stroke"
    />
    {/* Inner offset hint (gives depth) */}
    <rect
      x="4.5"
      y="4.5"
      width="91"
      height="91"
      rx="0.8"
      ry="0.8"
      fill="none"
      stroke="hsl(39 60% 56% / 0.22)"
      strokeWidth="0.18"
      vectorEffect="non-scaling-stroke"
    />
    {/* Corner dots (discreet, not ornate) */}
    <g fill="hsl(39 60% 56%)" opacity="0.75">
      <circle cx="2" cy="2" r="0.6" />
      <circle cx="98" cy="2" r="0.6" />
      <circle cx="2" cy="98" r="0.6" />
      <circle cx="98" cy="98" r="0.6" />
    </g>
  </svg>
);

export default GoldFrame;
