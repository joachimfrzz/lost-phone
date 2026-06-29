import lockScreen from "./screens/lock-screen.json";
import homeScreen from "./screens/home-screen.json";

export type FigmaScreenId =
  | "lock-screen"
  | "home-screen"
  | "pin-screen"
  | "control-center"
  | "notification-center";

export type FigmaScreenSpecs = {
  screen: string;
  source: {
    fileKey: string;
    nodeId: string;
    name: string;
    exportedAt: string;
  };
  frame: { width: number; height: number };
  referenceImage: string;
  tokens: Record<string, string>;
  symbols?: { flashlight?: string; camera?: string };
  assets?: { wallpaper?: string; wallpaperNodeId?: string };
};

const CACHE: Partial<Record<FigmaScreenId, FigmaScreenSpecs>> = {
  "lock-screen": lockScreen as FigmaScreenSpecs,
  "home-screen": homeScreen as FigmaScreenSpecs,
};

export function getFigmaScreen(id: FigmaScreenId): FigmaScreenSpecs | null {
  return CACHE[id] ?? null;
}

export function hasFigmaScreen(id: FigmaScreenId): boolean {
  return CACHE[id] != null;
}

/** Fond d'écran simulateur — exporté depuis le kit Apple (calque Wallpaper). */
export function figmaSimulatorWallpaper(): string | undefined {
  const lock = getFigmaScreen("lock-screen");
  return lock?.assets?.wallpaper ?? undefined;
}

export function figmaReferenceUrl(id: FigmaScreenId): string | undefined {
  return getFigmaScreen(id)?.referenceImage;
}

export function applyFigmaTokensToRoot(el: HTMLElement, id: FigmaScreenId) {
  const specs = getFigmaScreen(id);
  if (!specs?.tokens) return;
  for (const [key, val] of Object.entries(specs.tokens)) {
    el.style.setProperty(key, val);
  }
}
