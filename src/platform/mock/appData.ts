/**
 * Données vides par app — simulateur sans histoire.
 * Chaque app native/tierce doit afficher son état vide iOS réel avec ces mocks.
 */

const EMPTY: Record<string, unknown> = {
  Messages: { conversations: [] },
  WhatsApp: { conversations: [] },
  Signal: { conversations: [] },
  Mail: { messages: [] },
  Photos: { albums: [], photos: [] },
  Notes: { notes: [] },
  Contacts: { contacts: [] },
  Telephone: { recents: [] },
  Safari: { tabs: [], history: [] },
  Calendrier: { events: [] },
  Fichiers: { items: [] },
  Rappels: { lists: [] },
  "Google Maps": { places: [] },
  Instagram: { feed: [], dms: [] },
  Uber: { rides: [] },
  Spotify: { playlists: [] },
  Netflix: { profiles: [] },
  "Crédit Agricole": { accounts: [] },
  Réglages: {},
};

export function getMockAppData(appName: string): unknown {
  return EMPTY[appName] ?? {};
}
