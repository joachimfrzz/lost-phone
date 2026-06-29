import type { LpspPackage } from "../types/lpsp";
import { DEFAULT_DOCK, NATIVE_APPS, SIMULATOR_PIN, THIRD_PARTY_APPS } from "./constants";

export { SIMULATOR_PIN };

/** iPhone vide — aucune histoire, aucun scénario. Base de développement plateforme. */
export const EMPTY_DEVICE: LpspPackage = {
  lpsp_version: "1.0",
  manifest: {
    project_id: "platform-simulator",
    title: "iPhone (simulateur)",
    apps_presentes: [...NATIVE_APPS, ...THIRD_PARTY_APPS],
    coeur_narratif: null,
  },
  player_config: {
    verrouillage: { type: "pin", code: SIMULATOR_PIN },
    apps_accessibles: [...NATIVE_APPS, ...THIRD_PARTY_APPS],
  },
  content: {
    envelope: {
      heure_verrou: "18:04",
      date_verrou: "Lun. 29 juin",
      notifications_initiales: [],
      fond_ecran: {
        description: "ios abstract default",
        source: "/figma/assets/wallpaper-lock.png",
      },
    },
    system: {
      dock: [...DEFAULT_DOCK],
      batterie: "40%",
      focus_actif: "Aucun",
    },
    apps: {},
  },
  scenario: {
    profil: "simulator",
    evenements: [],
  },
};
