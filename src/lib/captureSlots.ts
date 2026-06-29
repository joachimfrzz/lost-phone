import type { CaptureId } from "./captures";

export type CaptureSlot = {
  id: CaptureId;
  label: string;
  hint: string;
};

export type CaptureStep = {
  id: string;
  title: string;
  description: string;
  slots: CaptureSlot[];
};

/** Étapes d’envoi — une à la fois, ordre recommandé */
export const CAPTURE_STEPS: CaptureStep[] = [
  {
    id: "noyau",
    title: "Étape 1 — Noyau iOS",
    description: "Verrou, PIN, accueil, centres de notifications et de contrôle.",
    slots: [
      {
        id: "system.lock-vide",
        label: "Verrou sans notification",
        hint: "Écran verrouillé, aucune notif visible.",
      },
      {
        id: "system.lock-notifs",
        label: "Verrou avec notifications",
        hint: "2–3 notifications sur le verrou.",
      },
      { id: "system.pin", label: "Code PIN", hint: "Écran de saisie du code." },
      { id: "system.home-p1", label: "Accueil page 1", hint: "1re page + dock." },
      { id: "system.home-p2", label: "Accueil page 2", hint: "Swipe vers la 2e page." },
      {
        id: "system.notification-center",
        label: "Centre de notifications",
        hint: "Swipe depuis le haut.",
      },
      {
        id: "system.control-center",
        label: "Centre de contrôle",
        hint: "Swipe coin haut droit.",
      },
    ],
  },
  {
    id: "messages",
    title: "Étape 2 — Messages",
    description: "App Messages native (iMessage).",
    slots: [
      { id: "app.messages.liste", label: "Liste conversations", hint: "Vue principale Messages." },
      {
        id: "app.messages.conversation",
        label: "Conversation",
        hint: "Fil ouvert avec bulles visibles.",
      },
    ],
  },
  {
    id: "whatsapp-signal",
    title: "Étape 3 — WhatsApp & Signal",
    description: "Messagerie tierce.",
    slots: [
      { id: "app.whatsapp.liste", label: "WhatsApp — liste", hint: "Discussions." },
      { id: "app.whatsapp.conversation", label: "WhatsApp — conversation", hint: "Fil ouvert." },
      { id: "app.signal.liste", label: "Signal — liste", hint: "Conversations." },
      { id: "app.signal.conversation", label: "Signal — conversation", hint: "Fil ouvert." },
    ],
  },
  {
    id: "photos",
    title: "Étape 4 — Photos",
    description: "Bibliothèque Apple Photos.",
    slots: [
      { id: "app.photos.bibliotheque", label: "Bibliothèque", hint: "Grille photos." },
      { id: "app.photos.albums", label: "Albums", hint: "Liste des albums." },
      { id: "app.photos.detail", label: "Photo plein écran", hint: "Une photo ouverte." },
    ],
  },
  {
    id: "social-notes",
    title: "Étape 5 — Instagram & Notes",
    description: "",
    slots: [
      { id: "app.instagram.feed", label: "Instagram — fil", hint: "Feed + stories." },
      { id: "app.instagram.dm", label: "Instagram — DM", hint: "Messages privés." },
      { id: "app.notes.liste", label: "Notes — liste", hint: "Liste des notes." },
      { id: "app.notes.detail", label: "Notes — note ouverte", hint: "Contenu d'une note." },
    ],
  },
  {
    id: "native-p1",
    title: "Étape 6 — Mail, Contacts, Téléphone",
    description: "",
    slots: [
      { id: "app.mail.inbox", label: "Mail — boîte", hint: "Inbox." },
      { id: "app.mail.detail", label: "Mail — message", hint: "Email ouvert." },
      { id: "app.contacts.liste", label: "Contacts — liste", hint: "Liste A–Z." },
      { id: "app.telephone.recents", label: "Téléphone — récents", hint: "Historique appels." },
    ],
  },
  {
    id: "native-p2",
    title: "Étape 7 — Calendrier, Safari, Réglages",
    description: "",
    slots: [
      { id: "app.calendrier.mois", label: "Calendrier — mois", hint: "Vue mois." },
      { id: "app.safari.accueil", label: "Safari — accueil", hint: "Page d'accueil." },
      { id: "app.reglages.main", label: "Réglages — principal", hint: "Liste principale." },
    ],
  },
  {
    id: "transport",
    title: "Étape 8 — Maps, Uber, SNCF",
    description: "SNCF Connect : billets / trajets (capture accueil Uber en attendant slot dédié).",
    slots: [
      { id: "app.maps.carte", label: "Google Maps — carte", hint: "Carte avec pins." },
      { id: "app.uber.accueil", label: "Uber — accueil", hint: "Carte + activité récente." },
    ],
  },
  {
    id: "media-finance",
    title: "Étape 9 — Spotify, Netflix, Banque",
    description: "Banque = n'importe quelle app bancaire iOS (on adapte les couleurs).",
    slots: [
      { id: "app.spotify.accueil", label: "Spotify — accueil", hint: "Page d'accueil." },
      { id: "app.netflix.profils", label: "Netflix — profils", hint: "Choix profil." },
      { id: "app.netflix.accueil", label: "Netflix — accueil", hint: "Catalogue." },
      {
        id: "app.credit-agricole.compte",
        label: "Banque — compte",
        hint: "Solde + liste opérations (CA, LCL, BNP…).",
      },
    ],
  },
  {
    id: "utils",
    title: "Étape 10 — Fichiers & Rappels",
    description: "",
    slots: [
      { id: "app.fichiers.browser", label: "Fichiers", hint: "Navigateur fichiers." },
      { id: "app.rappels.liste", label: "Rappels — liste", hint: "Listes de rappels." },
    ],
  },
];

export function allSlotIds(): CaptureId[] {
  return CAPTURE_STEPS.flatMap((s) => s.slots.map((sl) => sl.id));
}

export function totalSlotCount(): number {
  return allSlotIds().length;
}
