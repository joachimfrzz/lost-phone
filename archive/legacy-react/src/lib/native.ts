import { Capacitor } from "@capacitor/core";
import { StatusBar, Style } from "@capacitor/status-bar";
import { SplashScreen } from "@capacitor/splash-screen";
import { Keyboard, KeyboardStyle } from "@capacitor/keyboard";
import { App } from "@capacitor/app";
import { Haptics, ImpactStyle, NotificationType } from "@capacitor/haptics";

export type NativePlatform = "ios" | "web" | "android";

export function getNativePlatform(): NativePlatform {
  const p = Capacitor.getPlatform();
  if (p === "ios") return "ios";
  if (p === "android") return "android";
  return "web";
}

export function isNativeIOS(): boolean {
  return Capacitor.isNativePlatform() && Capacitor.getPlatform() === "ios";
}

export function isNativeApp(): boolean {
  return Capacitor.isNativePlatform();
}

/** iPhone / iPad (Safari ou WebView) */
export function isAppleMobile(): boolean {
  if (typeof navigator === "undefined") return false;
  return (
    /iPhone|iPad|iPod/.test(navigator.userAgent) ||
    (navigator.platform === "MacIntel" && navigator.maxTouchPoints > 1)
  );
}

/** Ajouté à l'écran d'accueil (Safari → Partager → Sur l'écran d'accueil) */
export function isStandalonePWA(): boolean {
  if (typeof window === "undefined") return false;
  const nav = navigator as Navigator & { standalone?: boolean };
  return window.matchMedia("(display-mode: standalone)").matches || nav.standalone === true;
}

/** Plein écran sans coque simulée — Capacitor ou PWA sur iPhone */
export function isImmersiveIOS(): boolean {
  return isNativeIOS() || (isStandalonePWA() && isAppleMobile());
}

/** Mode app (Capacitor ou PWA standalone) — pas de bouton quitter */
export function isAppShell(): boolean {
  return isNativeApp() || isStandalonePWA();
}

/** Initialise le shell immersif — Capacitor natif ou PWA iPhone */
export async function initNativeShell(): Promise<void> {
  if (isImmersiveIOS()) {
    document.documentElement.classList.add("ios-native");
    document.body.classList.add("ios-native");
  }

  if (!Capacitor.isNativePlatform()) return;

  document.documentElement.classList.add("capacitor-native");

  try {
    await SplashScreen.hide();
  } catch {
    /* dev web */
  }

  if (isNativeIOS()) {
    try {
      await StatusBar.setOverlaysWebView({ overlay: true });
      await StatusBar.setStyle({ style: Style.Light });
    } catch {
      /* ignore */
    }

    try {
      await Keyboard.setStyle({ style: KeyboardStyle.Dark });
      await Keyboard.setScroll({ isDisabled: false });
    } catch {
      /* ignore */
    }
  }

  App.addListener("backButton", ({ canGoBack }) => {
    if (canGoBack) window.history.back();
  });
}

/** Status bar sombre (apps fond clair) ou claire (lock/home) */
export async function setNativeStatusBar(light: boolean): Promise<void> {
  if (!isNativeIOS()) return;
  try {
    await StatusBar.setStyle({ style: light ? Style.Light : Style.Dark });
  } catch {
    /* ignore */
  }
}

export async function hapticLight(): Promise<void> {
  if (isNativeApp()) {
    try {
      await Haptics.impact({ style: ImpactStyle.Light });
    } catch {
      /* ignore */
    }
    return;
  }
  navigator.vibrate?.(10);
}

export async function hapticMedium(): Promise<void> {
  if (isNativeApp()) {
    try {
      await Haptics.impact({ style: ImpactStyle.Medium });
    } catch {
      /* ignore */
    }
    return;
  }
  navigator.vibrate?.(20);
}

export async function hapticError(): Promise<void> {
  if (isNativeApp()) {
    try {
      await Haptics.notification({ type: NotificationType.Error });
    } catch {
      /* ignore */
    }
    return;
  }
  navigator.vibrate?.([30, 40, 30]);
}

export async function hapticSuccess(): Promise<void> {
  if (isNativeApp()) {
    try {
      await Haptics.notification({ type: NotificationType.Success });
    } catch {
      /* ignore */
    }
    return;
  }
  navigator.vibrate?.(15);
}
