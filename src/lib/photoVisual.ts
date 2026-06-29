/** Miniatures Photos — rendu visuel depuis description LPSP */

export function photoBackground(description?: string, titre?: string): string {
  const text = `${description ?? ""} ${titre ?? ""}`.toLowerCase();

  if (
    text.includes("anniversaire") ||
    text.includes("gâteau") ||
    text.includes("hugo") ||
    text.includes("bougie") ||
    text.includes("10")
  ) {
    return thumbBirthday();
  }
  if (text.includes("louvre") || text.includes("musée") || text.includes("salle 710")) {
    return thumbLouvre();
  }
  if (text.includes("pizza") || text.includes("montreuil") || text.includes("nadia")) {
    return thumbIndoor();
  }
  if (text.includes("nuit") || text.includes("bar") || text.includes("café")) {
    return thumbNight();
  }
  if (text.includes("compact") || text.includes("appareil")) {
    return thumbObject();
  }
  return thumbGeneric(text);
}

function svgUrl(inner: string): string {
  return `url("data:image/svg+xml,${encodeURIComponent(inner)}") center/cover no-repeat`;
}

function thumbBirthday(): string {
  return svgUrl(`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200">
    <rect fill="#c4885a" width="200" height="200"/>
    <rect x="40" y="110" width="120" height="50" rx="6" fill="#4a2818"/>
    <rect x="35" y="95" width="130" height="20" rx="4" fill="#6b3820"/>
    <text x="100" y="142" text-anchor="middle" fill="#4fc3f7" font-size="22" font-weight="700" font-family="system-ui">10</text>
    <ellipse cx="100" cy="70" rx="40" ry="35" fill="#2a1810" opacity="0.4"/>
    <ellipse cx="162" cy="88" rx="5" ry="7" fill="#ff9800"/>
    <ellipse cx="100" cy="82" rx="6" ry="8" fill="#ff9800"/>
    <ellipse cx="38" cy="88" rx="5" ry="7" fill="#ff9800"/>
  </svg>`);
}

function thumbLouvre(): string {
  return svgUrl(`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200">
    <rect fill="#5c6b7a" width="200" height="200"/>
    <polygon points="100,60 60,140 140,140" fill="#c8b896"/>
    <rect x="50" y="140" width="100" height="40" fill="#b8a886"/>
  </svg>`);
}

function thumbIndoor(): string {
  return svgUrl(`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200">
    <rect fill="#3a2820" width="200" height="200"/>
    <circle cx="100" cy="100" r="50" fill="#e8a040" opacity="0.7"/>
    <circle cx="80" cy="90" r="8" fill="#c04020" opacity="0.8"/>
    <circle cx="110" cy="95" r="6" fill="#c04020" opacity="0.7"/>
  </svg>`);
}

function thumbNight(): string {
  return svgUrl(`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200">
    <rect fill="#1a1828" width="200" height="200"/>
    <circle cx="100" cy="80" r="30" fill="#ffd060" opacity="0.3"/>
    <rect x="30" y="130" width="140" height="50" rx="4" fill="#2a2030"/>
  </svg>`);
}

function thumbObject(): string {
  return svgUrl(`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200">
    <rect fill="#e8e8ed" width="200" height="200"/>
    <rect x="60" y="70" width="80" height="55" rx="6" fill="#333"/>
    <circle cx="100" cy="97" r="18" fill="#111"/>
    <rect x="130" y="85" width="8" height="8" rx="1" fill="#ffd60a"/>
  </svg>`);
}

function thumbGeneric(text: string): string {
  const hues = [220, 280, 160, 30, 340];
  const h = hues[Math.abs(hashCode(text)) % hues.length];
  return `linear-gradient(135deg, hsl(${h},45%,42%) 0%, hsl(${h},35%,22%) 100%)`;
}

function hashCode(s: string): number {
  let h = 0;
  for (let i = 0; i < s.length; i++) h = (Math.imul(31, h) + s.charCodeAt(i)) | 0;
  return h;
}
