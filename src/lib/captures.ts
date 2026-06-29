/**
 * Registre des captures iPhone — chaque entrée = …/screen.png
 * Pas de renommage custom : toujours "screen.png" dans le dossier indiqué.
 */

const BASE = "captures-ios";

export type CaptureId =
  | "system.lock-vide"
  | "system.lock-notifs"
  | "system.pin"
  | "system.home-p1"
  | "system.home-p2"
  | "system.notification-center"
  | "system.control-center"
  | "app.messages.liste"
  | "app.messages.conversation"
  | "app.whatsapp.liste"
  | "app.whatsapp.conversation"
  | "app.signal.liste"
  | "app.signal.conversation"
  | "app.photos.bibliotheque"
  | "app.photos.albums"
  | "app.photos.detail"
  | "app.mail.inbox"
  | "app.mail.detail"
  | "app.notes.liste"
  | "app.notes.detail"
  | "app.telephone.recents"
  | "app.contacts.liste"
  | "app.safari.accueil"
  | "app.calendrier.mois"
  | "app.reglages.main"
  | "app.fichiers.browser"
  | "app.rappels.liste"
  | "app.maps.carte"
  | "app.instagram.feed"
  | "app.instagram.dm"
  | "app.uber.accueil"
  | "app.credit-agricole.compte"
  | "app.spotify.accueil"
  | "app.netflix.profils"
  | "app.netflix.accueil";

/** id → chemin relatif (sans BASE_URL) */
export const CAPTURE_PATHS: Record<CaptureId, string> = {
  "system.lock-vide": `${BASE}/system/lock-vide/screen.png`,
  "system.lock-notifs": `${BASE}/system/lock-notifs/screen.png`,
  "system.pin": `${BASE}/system/pin/screen.png`,
  "system.home-p1": `${BASE}/system/home-p1/screen.png`,
  "system.home-p2": `${BASE}/system/home-p2/screen.png`,
  "system.notification-center": `${BASE}/system/notification-center/screen.png`,
  "system.control-center": `${BASE}/system/control-center/screen.png`,

  "app.messages.liste": `${BASE}/apps/messages/liste/screen.png`,
  "app.messages.conversation": `${BASE}/apps/messages/conversation/screen.png`,
  "app.whatsapp.liste": `${BASE}/apps/whatsapp/liste/screen.png`,
  "app.whatsapp.conversation": `${BASE}/apps/whatsapp/conversation/screen.png`,
  "app.signal.liste": `${BASE}/apps/signal/liste/screen.png`,
  "app.signal.conversation": `${BASE}/apps/signal/conversation/screen.png`,
  "app.photos.bibliotheque": `${BASE}/apps/photos/bibliotheque/screen.png`,
  "app.photos.albums": `${BASE}/apps/photos/albums/screen.png`,
  "app.photos.detail": `${BASE}/apps/photos/detail/screen.png`,
  "app.mail.inbox": `${BASE}/apps/mail/inbox/screen.png`,
  "app.mail.detail": `${BASE}/apps/mail/detail/screen.png`,
  "app.notes.liste": `${BASE}/apps/notes/liste/screen.png`,
  "app.notes.detail": `${BASE}/apps/notes/detail/screen.png`,
  "app.telephone.recents": `${BASE}/apps/telephone/recents/screen.png`,
  "app.contacts.liste": `${BASE}/apps/contacts/liste/screen.png`,
  "app.safari.accueil": `${BASE}/apps/safari/accueil/screen.png`,
  "app.calendrier.mois": `${BASE}/apps/calendrier/mois/screen.png`,
  "app.reglages.main": `${BASE}/apps/reglages/main/screen.png`,
  "app.fichiers.browser": `${BASE}/apps/fichiers/browser/screen.png`,
  "app.rappels.liste": `${BASE}/apps/rappels/liste/screen.png`,
  "app.maps.carte": `${BASE}/apps/maps/carte/screen.png`,
  "app.instagram.feed": `${BASE}/apps/instagram/feed/screen.png`,
  "app.instagram.dm": `${BASE}/apps/instagram/dm/screen.png`,
  "app.uber.accueil": `${BASE}/apps/uber/accueil/screen.png`,
  "app.credit-agricole.compte": `${BASE}/apps/credit-agricole/compte/screen.png`,
  "app.spotify.accueil": `${BASE}/apps/spotify/accueil/screen.png`,
  "app.netflix.profils": `${BASE}/apps/netflix/profils/screen.png`,
  "app.netflix.accueil": `${BASE}/apps/netflix/accueil/screen.png`,
};

export const CAPTURE_LABELS: Record<CaptureId, string> = {
  "system.lock-vide": "Verrou (sans notif)",
  "system.lock-notifs": "Verrou (avec notifs)",
  "system.pin": "Code PIN",
  "system.home-p1": "Accueil page 1",
  "system.home-p2": "Accueil page 2",
  "system.notification-center": "Centre de notifications",
  "system.control-center": "Centre de contrôle",

  "app.messages.liste": "Messages — liste",
  "app.messages.conversation": "Messages — conversation",
  "app.whatsapp.liste": "WhatsApp — liste",
  "app.whatsapp.conversation": "WhatsApp — conversation",
  "app.signal.liste": "Signal — liste",
  "app.signal.conversation": "Signal — conversation",
  "app.photos.bibliotheque": "Photos — bibliothèque",
  "app.photos.albums": "Photos — albums",
  "app.photos.detail": "Photos — détail",
  "app.mail.inbox": "Mail — boîte",
  "app.mail.detail": "Mail — message",
  "app.notes.liste": "Notes — liste",
  "app.notes.detail": "Notes — note",
  "app.telephone.recents": "Téléphone — récents",
  "app.contacts.liste": "Contacts — liste",
  "app.safari.accueil": "Safari — accueil",
  "app.calendrier.mois": "Calendrier — mois",
  "app.reglages.main": "Réglages — principal",
  "app.fichiers.browser": "Fichiers — navigateur",
  "app.rappels.liste": "Rappels — liste",
  "app.maps.carte": "Plans — carte",
  "app.instagram.feed": "Instagram — fil",
  "app.instagram.dm": "Instagram — DM",
  "app.uber.accueil": "Uber — accueil",
  "app.credit-agricole.compte": "Crédit Agricole — compte",
  "app.spotify.accueil": "Spotify — accueil",
  "app.netflix.profils": "Netflix — profils",
  "app.netflix.accueil": "Netflix — accueil",
};

const FILE = "screen.png";

export function captureUrl(id: CaptureId): string {
  return `${import.meta.env.BASE_URL}${CAPTURE_PATHS[id]}`;
}

/** Tous les ids triés (system d'abord) */
export function allCaptureIds(): CaptureId[] {
  return Object.keys(CAPTURE_PATHS) as CaptureId[];
}

export function captureFolderPath(id: CaptureId): string {
  return CAPTURE_PATHS[id].replace(`/${FILE}`, "");
}

/** Vérifie si la capture existe (HEAD) */
export async function captureExists(id: CaptureId): Promise<boolean> {
  try {
    const res = await fetch(captureUrl(id), { method: "HEAD", cache: "no-store" });
    return res.ok;
  } catch {
    return false;
  }
}

export async function captureStatus(): Promise<{ id: CaptureId; label: string; ok: boolean }[]> {
  const ids = allCaptureIds();
  const results = await Promise.all(
    ids.map(async (id) => ({
      id,
      label: CAPTURE_LABELS[id],
      ok: await captureExists(id),
    })),
  );
  return results;
}
