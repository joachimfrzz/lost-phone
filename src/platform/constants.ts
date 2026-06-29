/** Apps système iOS — ordre de développement phase 3 */
export const NATIVE_APPS = [
  "Réglages",
  "Messages",
  "Photos",
  "Telephone",
  "Contacts",
  "Mail",
  "Notes",
  "Calendrier",
  "Safari",
  "Fichiers",
  "Rappels",
  "Google Maps",
] as const;

/** Apps tierces — ordre de développement phase 4 */
export const THIRD_PARTY_APPS = [
  "WhatsApp",
  "Signal",
  "Instagram",
  "Uber",
  "Spotify",
  "Netflix",
  "Crédit Agricole",
] as const;

/** Dock par défaut d’un iPhone vide (dev / simulateur) */
export const DEFAULT_DOCK = ["Telephone", "Safari", "Messages", "Photos"] as const;

/** PIN simulateur (toujours 0000 en mode dev) */
export const SIMULATOR_PIN = "0000";
