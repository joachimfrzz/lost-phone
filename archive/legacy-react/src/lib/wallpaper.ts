/** Fond d'écran iOS — image LPSP (`source`) ou dégradé dérivé de la description. */

export interface WallpaperStyle {
  wallpaper: string;
  glow: string;
  isPhoto?: boolean;
}

export function wallpaperMood(description?: string, source?: string): WallpaperStyle {
  if (source) {
    const url = source.startsWith("/") ? source : `/${source}`;
    return {
      wallpaper: `url("${url}") center center / cover no-repeat`,
      glow: "rgba(0, 0, 0, 0.2)",
      isPhoto: true,
    };
  }

  const lower = (description ?? "").toLowerCase();
  if (
    lower.includes("anniversaire") ||
    lower.includes("gâteau") ||
    lower.includes("hugo") ||
    lower.includes("bougie") ||
    lower.includes("pâte d'amande")
  ) {
    return { wallpaper: birthdayWallpaper(), glow: "rgba(255, 180, 100, 0.35)", isPhoto: true };
  }
  if (lower.includes("louvre") || lower.includes("musée") || lower.includes("pyramide")) {
    return { wallpaper: louvreWallpaper(), glow: "rgba(92, 107, 122, 0.4)" };
  }
  if (lower.includes("nuit") || lower.includes("train")) {
    return { wallpaper: nightWallpaper(), glow: "rgba(26, 48, 80, 0.5)" };
  }
  return { wallpaper: defaultWallpaper(), glow: "rgba(74, 85, 104, 0.4)" };
}

/** Salon chaud, bokeh — indice visuel anniversaire */
function birthdayWallpaper(): string {
  return [
    "radial-gradient(ellipse 90% 70% at 50% 85%, rgba(255, 160, 80, 0.55) 0%, transparent 55%)",
    "radial-gradient(ellipse 60% 45% at 30% 25%, rgba(255, 220, 180, 0.35) 0%, transparent 50%)",
    "radial-gradient(ellipse 50% 40% at 75% 20%, rgba(255, 200, 140, 0.25) 0%, transparent 45%)",
    "radial-gradient(ellipse 100% 80% at 50% 100%, #3d2010 0%, transparent 60%)",
    "linear-gradient(165deg, #8b5a3c 0%, #5c3828 35%, #2a1810 70%, #120a06 100%)",
  ].join(", ");
}

function louvreWallpaper(): string {
  return [
    "radial-gradient(ellipse 80% 50% at 50% 30%, rgba(200, 210, 220, 0.45) 0%, transparent 55%)",
    "linear-gradient(180deg, rgba(255,255,255,0.08) 0%, transparent 25%)",
    "linear-gradient(180deg, #9aabbc 0%, #6b7d8f 28%, #3d4a56 58%, #1a2228 100%)",
  ].join(", ");
}

function nightWallpaper(): string {
  return [
    "radial-gradient(ellipse 70% 45% at 65% 8%, rgba(40, 80, 140, 0.5) 0%, transparent 50%)",
    "radial-gradient(ellipse 50% 30% at 20% 15%, rgba(60, 40, 100, 0.25) 0%, transparent 45%)",
    "linear-gradient(180deg, #0f1828 0%, #050810 100%)",
  ].join(", ");
}

function defaultWallpaper(): string {
  return [
    "radial-gradient(ellipse 90% 55% at 18% 8%, rgba(255, 80, 60, 0.55) 0%, transparent 52%)",
    "radial-gradient(ellipse 70% 45% at 82% 18%, rgba(120, 60, 180, 0.45) 0%, transparent 48%)",
    "radial-gradient(ellipse 80% 60% at 50% 85%, rgba(40, 180, 220, 0.35) 0%, transparent 55%)",
    "radial-gradient(ellipse 100% 80% at 50% 100%, #1a1030 0%, transparent 60%)",
    "linear-gradient(180deg, #0a0818 0%, #1a0a28 35%, #2a1848 65%, #081828 100%)",
  ].join(", ");
}
