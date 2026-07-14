import type { StatusBarMode } from "../ios/StatusBar";

/** Barre d'état par app — texte noir sur fond clair vs blanc sur fond sombre */
const LIGHT_BG_APPS = new Set([
  "Messages",
  "WhatsApp",
  "Mail",
  "Safari",
  "Google Maps",
  "Calendrier",
  "Contacts",
  "Telephone",
  "Instagram",
  "Uber",
  "Crédit Agricole",
  "Fichiers",
  "Rappels",
  "Réglages",
]);

const DARK_BG_APPS = new Set(["Notes", "Photos", "Signal", "Spotify", "Netflix"]);

export function statusModeForApp(app: string | null): StatusBarMode {
  if (!app) return "app-light";
  if (DARK_BG_APPS.has(app)) return "app-dark";
  if (LIGHT_BG_APPS.has(app)) return "app-light";
  return "app-light";
}
