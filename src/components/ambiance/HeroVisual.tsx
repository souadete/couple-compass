/**
 * HeroVisual — stylized minimal line-art of two silhouettes facing a golden halo.
 * Azwaj identity: contre-jour silhouettes + halo doré + subtle golden mist.
 * No faces, no photo-realism, no literal religious symbols (per charte Azwaj).
 * Renders inline SVG (no external asset, crisp at any size, tiny bytes).
 */
const HeroVisual = ({ className = "" }: { className?: string }) => (
  <svg
    role="presentation"
    viewBox="0 0 800 320"
    xmlns="http://www.w3.org/2000/svg"
    className={className}
    aria-hidden
  >
    <defs>
      {/* Soft radial halo behind the couple */}
      <radialGradient id="hv-halo" cx="50%" cy="58%" r="45%">
        <stop offset="0%" stopColor="hsl(39 65% 62% / 0.55)" />
        <stop offset="40%" stopColor="hsl(39 60% 56% / 0.28)" />
        <stop offset="75%" stopColor="hsl(39 50% 50% / 0.08)" />
        <stop offset="100%" stopColor="hsl(39 50% 50% / 0)" />
      </radialGradient>
      {/* Subtle ground fog (mauve-to-transparent) */}
      <linearGradient id="hv-fog" x1="0" y1="1" x2="0" y2="0">
        <stop offset="0%" stopColor="hsl(328 30% 60% / 0.2)" />
        <stop offset="100%" stopColor="hsl(328 30% 60% / 0)" />
      </linearGradient>
      {/* Golden vertical god-ray between the two silhouettes */}
      <linearGradient id="hv-ray" x1="0.5" y1="0" x2="0.5" y2="1">
        <stop offset="0%" stopColor="hsl(39 70% 70% / 0)" />
        <stop offset="30%" stopColor="hsl(39 65% 62% / 0.35)" />
        <stop offset="70%" stopColor="hsl(39 65% 62% / 0.2)" />
        <stop offset="100%" stopColor="hsl(39 50% 50% / 0)" />
      </linearGradient>
    </defs>

    {/* Golden halo */}
    <circle cx="400" cy="190" r="170" fill="url(#hv-halo)" />

    {/* Vertical god-ray */}
    <rect x="390" y="30" width="20" height="280" fill="url(#hv-ray)" />

    {/* Ground fog baseline */}
    <rect x="0" y="210" width="800" height="110" fill="url(#hv-fog)" />

    {/* Subtle horizon line */}
    <line
      x1="0"
      y1="260"
      x2="800"
      y2="260"
      stroke="hsl(39 60% 56% / 0.35)"
      strokeWidth="0.6"
    />

    {/* Left silhouette — facing right (toward light).
        Simple profile-abstract line: head (circle) + torso curve + implied robe. */}
    <g fill="hsl(271 39% 20%)" opacity="0.92">
      <circle cx="290" cy="118" r="22" />
      <path
        d="M265 140
           Q268 165 272 185
           L255 260
           L248 268
           Q242 270 242 262
           L242 178
           Q242 160 254 148
           Q264 138 265 140 Z"
      />
    </g>

    {/* Right silhouette — facing left (toward light). Mirrored profile. */}
    <g fill="hsl(271 39% 20%)" opacity="0.92">
      <circle cx="510" cy="118" r="22" />
      <path
        d="M535 140
           Q532 165 528 185
           L545 260
           L552 268
           Q558 270 558 262
           L558 178
           Q558 160 546 148
           Q536 138 535 140 Z"
      />
    </g>

    {/* Small gold flecks around the halo (particles) */}
    <g fill="hsl(39 60% 56%)">
      <circle cx="350" cy="90" r="1.8" opacity="0.7" />
      <circle cx="460" cy="100" r="2.2" opacity="0.65" />
      <circle cx="315" cy="210" r="1.6" opacity="0.55" />
      <circle cx="485" cy="220" r="1.8" opacity="0.6" />
      <circle cx="400" cy="70" r="1.4" opacity="0.5" />
      <circle cx="400" cy="240" r="1.6" opacity="0.55" />
    </g>
  </svg>
);

export default HeroVisual;
