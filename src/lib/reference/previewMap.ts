import type { CaptureId } from "../captures";
import type { PhonePhase } from "../../types/lpsp";

/** Configuration runtime pour afficher l'écran React correspondant à une capture. */
export type ReferencePreviewConfig = {
  phase: PhonePhase;
  overlay?: "none" | "notifications" | "control-center";
  activeApp?: string | null;
  homePage?: number;
};

/**
 * id capture → état PhoneRuntime à reproduire (contenu LPSP, structure iOS).
 * Les captures ne servent qu'à calibrer le rendu — pas le contenu affiché.
 */
export const REFERENCE_PREVIEW: Partial<Record<CaptureId, ReferencePreviewConfig>> = {
  "system.lock-vide": { phase: "lock" },
  "system.lock-notifs": { phase: "lock" },
  "system.pin": { phase: "pin" },
  "system.home-p1": { phase: "home", homePage: 0 },
  "system.home-p2": { phase: "home", homePage: 1 },
  "system.notification-center": { phase: "lock", overlay: "notifications" },
  "system.control-center": { phase: "home", overlay: "control-center" },

  "app.messages.liste": { phase: "app", activeApp: "Messages" },
  "app.messages.conversation": { phase: "app", activeApp: "Messages" },
  "app.whatsapp.liste": { phase: "app", activeApp: "WhatsApp" },
  "app.whatsapp.conversation": { phase: "app", activeApp: "WhatsApp" },
  "app.signal.liste": { phase: "app", activeApp: "Signal" },
  "app.signal.conversation": { phase: "app", activeApp: "Signal" },
  "app.photos.bibliotheque": { phase: "app", activeApp: "Photos" },
  "app.photos.albums": { phase: "app", activeApp: "Photos" },
  "app.photos.detail": { phase: "app", activeApp: "Photos" },
  "app.mail.inbox": { phase: "app", activeApp: "Mail" },
  "app.mail.detail": { phase: "app", activeApp: "Mail" },
  "app.notes.liste": { phase: "app", activeApp: "Notes" },
  "app.notes.detail": { phase: "app", activeApp: "Notes" },
  "app.telephone.recents": { phase: "app", activeApp: "Telephone" },
  "app.contacts.liste": { phase: "app", activeApp: "Contacts" },
  "app.safari.accueil": { phase: "app", activeApp: "Safari" },
  "app.calendrier.mois": { phase: "app", activeApp: "Calendrier" },
  "app.reglages.main": { phase: "app", activeApp: "Réglages" },
  "app.fichiers.browser": { phase: "app", activeApp: "Fichiers" },
  "app.rappels.liste": { phase: "app", activeApp: "Rappels" },
  "app.maps.carte": { phase: "app", activeApp: "Google Maps" },
  "app.instagram.feed": { phase: "app", activeApp: "Instagram" },
  "app.instagram.dm": { phase: "app", activeApp: "Instagram" },
  "app.uber.accueil": { phase: "app", activeApp: "Uber" },
  "app.credit-agricole.compte": { phase: "app", activeApp: "Crédit Agricole" },
  "app.spotify.accueil": { phase: "app", activeApp: "Spotify" },
  "app.netflix.profils": { phase: "app", activeApp: "Netflix" },
  "app.netflix.accueil": { phase: "app", activeApp: "Netflix" },
};

export function previewForCapture(id: CaptureId): ReferencePreviewConfig | null {
  return REFERENCE_PREVIEW[id] ?? null;
}
