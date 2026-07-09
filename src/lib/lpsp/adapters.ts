/** Normalise les payloads LPSP vers des formes stables pour les plugins UI */

export interface NormalizedMessage {
  id?: string;
  text: string;
  outgoing: boolean;
  time?: string;
}

export interface NormalizedThread {
  contact: string;
  messages: NormalizedMessage[];
  preview?: string;
}

export interface NormalizedRide {
  id?: string;
  pickup?: string;
  dropoff?: string;
  price?: string;
  driver?: string;
  date?: string;
  duration?: string;
}

function msgFromRaw(m: Record<string, unknown>, ownerHint?: string): NormalizedMessage {
  const sender = String(m.de ?? m.expediteur ?? m.from ?? "");
  const text = String(m.texte ?? m.contenu ?? m.body ?? m.message ?? "");
  const owner = (ownerHint ?? "mathieu").toLowerCase();
  const outgoing =
    sender.toLowerCase() === "moi" ||
    sender.toLowerCase() === "me" ||
    sender.toLowerCase() === "mathieu" ||
    sender.toLowerCase() === "m" ||
    sender.toLowerCase().includes(owner) ||
    sender.toLowerCase().includes("garnier");
  return {
    id: m.id as string | undefined,
    text,
    outgoing,
    time: m.date as string | undefined,
  };
}

export function adaptThreads(data: unknown): NormalizedThread[] {
  const d = data as { threads?: Array<Record<string, unknown>> };
  return (d?.threads ?? []).map((t) => {
    const messages = ((t.messages as Array<Record<string, unknown>>) ?? []).map((m) => msgFromRaw(m));
    const last = messages[messages.length - 1];
    return {
      contact: String(t.contact ?? "Inconnu"),
      messages,
      preview: last?.text?.slice(0, 90),
    };
  });
}

export function adaptSignal(data: unknown): NormalizedThread[] {
  const d = data as { conversations?: Array<Record<string, unknown>> };
  return (d?.conversations ?? []).map((c) => {
    const messages = ((c.messages as Array<Record<string, unknown>>) ?? []).map((m) => msgFromRaw(m));
    const last = messages[messages.length - 1];
    return {
      contact: String(c.contact ?? "Inconnu"),
      messages,
      preview: last?.text?.slice(0, 100) ?? `${c.messages_count ?? 0} messages`,
    };
  });
}

export function adaptUber(data: unknown): { account?: Record<string, unknown>; rides: NormalizedRide[] } {
  const d = data as { compte?: Record<string, unknown>; courses?: Array<Record<string, unknown>> };
  const rides = (d?.courses ?? []).map((r) => ({
    id: r.id as string | undefined,
    pickup: String(r.pickup ?? r.depart ?? ""),
    dropoff: String(r.dropoff ?? r.arrivee ?? r.trajet ?? ""),
    price: String(r.prix ?? r.montant ?? ""),
    driver: String(r.chauffeur ?? ""),
    date: r.date as string | undefined,
    duration: String(r.duree ?? ""),
  }));
  return { account: d?.compte, rides };
}

export function adaptBanking(data: unknown) {
  const d = data as Record<string, unknown>;
  const titulaire = d.titulaire;
  const holder =
    typeof titulaire === "string"
      ? titulaire
      : (titulaire as { nom?: string })?.nom ?? "";
  return {
    holder,
    accounts: (d.comptes as Array<{ nom?: string; solde?: number | string }>) ?? [],
    operations: (d.operations as Array<Record<string, unknown>>) ?? [],
    summary: (d.synthese_financiere as { commentaire?: string })?.commentaire,
    card: d.carte_bancaire as Record<string, unknown> | undefined,
  };
}

export function adaptInstagram(data: unknown) {
  const d = data as Record<string, unknown>;
  const profil = (d.profil as Record<string, unknown>) ?? {};
  return {
    username: String(profil.pseudo ?? profil.nom ?? ""),
    bio: String(profil.bio ?? ""),
    followers: Number(profil.abonnes ?? profil.followers ?? 0),
    following: Number(profil.abonnements ?? profil.following ?? 0),
    feed: ((d.feed as Array<Record<string, unknown>>) ?? []).map((p) => ({
      caption: String(p.caption ?? p.legende ?? ""),
      likes: Number(p.likes ?? 0),
      comments: Number(p.commentaires ?? p.comments ?? (Number(p.likes ?? 0) > 40 ? 3 : 1)),
      date: p.date as string | undefined,
    })),
    dms: ((d.dm_threads as Array<Record<string, unknown>>) ?? []).map((t) => {
      const owner = String(profil.pseudo ?? "mathieu");
      const messages = ((t.messages as Array<Record<string, unknown>>) ?? []).map((m) => msgFromRaw(m, owner));
      const last = messages[messages.length - 1];
      return {
        contact: String(t.contact_display_name ?? t.contact ?? ""),
        messages,
        preview: last?.text?.slice(0, 90) ?? "",
      };
    }),
    stories: ((d.stories as Array<Record<string, unknown>>) ?? []).map((s) => ({
      username: String(s.auteur ?? s.username ?? ""),
      seen: Boolean(s.vu),
    })),
  };
}

export function adaptNotes(data: unknown) {
  const notes = Array.isArray(data) ? data : [];
  return notes as Array<{
    id?: string;
    titre?: string;
    dossier?: string;
    contenu?: string;
    date_modification?: string;
  }>;
}

export interface FileNode {
  name: string;
  type?: string;
  size?: string;
  date?: string;
  description?: string;
  children?: FileNode[];
}

export function adaptFiles(data: unknown): FileNode[] {
  const d = data as { arborescence?: Record<string, unknown> };
  const tree = d?.arborescence ?? {};
  return Object.entries(tree).map(([root, items]) => ({
    name: root,
    children: parseFileFolders(items as unknown[]),
  }));
}

function parseFileFolders(items: unknown[]): FileNode[] {
  if (!Array.isArray(items)) return [];
  return items.map((item) => {
    const f = item as Record<string, unknown>;
    if (f.fichiers) {
      const files = (f.fichiers as Array<Record<string, unknown>>).map((file) => ({
        name: String(file.nom ?? ""),
        type: String(file.type ?? ""),
        size: String(file.taille ?? ""),
        date: String(file.date_modification ?? file.date_creation ?? ""),
        description: String(file.description ?? ""),
      }));
      const sub = f.sous_dossiers ? parseFileFolders(f.sous_dossiers as unknown[]) : [];
      return { name: String(f.dossier ?? ""), children: [...sub, ...files] };
    }
    return {
      name: String(f.nom ?? f.dossier ?? ""),
      type: String(f.type ?? "folder"),
      size: String(f.taille ?? ""),
      date: String(f.date_modification ?? f.date_creation ?? ""),
      description: String(f.description ?? ""),
    };
  });
}

export function adaptMaps(data: unknown) {
  const d = data as Record<string, unknown>;
  return {
    places: (d.adresses_enregistrees as Array<Record<string, unknown>>) ?? [],
    routes: (d.itineraires_sauvegardes as Array<Record<string, unknown>>) ?? [],
    history: (d.historique_trajets as Array<Record<string, unknown>>) ?? [],
  };
}

export function adaptReminders(data: unknown) {
  const d = data as { listes?: Array<Record<string, unknown>> };
  return (d?.listes ?? []).map((l) => ({
    name: String(l.nom ?? "Rappels"),
    items: ((l.rappels as Array<Record<string, unknown>>) ?? []).map((r) => ({
      title: String(r.titre ?? ""),
      done: Boolean(r.complete),
      date: r.date_rappel as string | undefined,
      notes: String(r.notes ?? ""),
    })),
  }));
}

export function adaptSpotify(data: unknown) {
  const d = data as Record<string, unknown>;
  return {
    account: d.compte as Record<string, unknown> | undefined,
    profile: d.profil as Record<string, unknown> | undefined,
    playlists: (d.playlists as Array<Record<string, unknown>>) ?? [],
    history: (d.historique_ecoute as Array<Record<string, unknown>>) ?? [],
  };
}

export function adaptDisney(data: unknown) {
  return adaptNetflix(data);
}

export function adaptNetflix(data: unknown) {
  const d = data as Record<string, unknown>;
  const cw = d.continuer_a_regarder as Record<string, unknown> | undefined;
  const mathieu = (cw?.profil_mathieu as Array<Record<string, unknown>>) ?? [];
  const hugo = (cw?.profil_hugo as Array<Record<string, unknown>>) ?? [];
  return {
    account: d.compte as Record<string, unknown> | undefined,
    profiles: (d.profils as Array<Record<string, unknown>>) ?? [],
    continueWatching: [...mathieu, ...hugo],
    continueByProfile: { mathieu, hugo },
    favorites: (d.recommandations as Array<Record<string, unknown>>) ?? [],
  };
}

export function adaptChatBot(data: unknown, fallback: NormalizedMessage[]): NormalizedMessage[] {
  const d = data as { messages?: Array<Record<string, unknown>>; historique?: Array<Record<string, unknown>> };
  const raw = d.messages ?? d.historique ?? [];
  if (raw.length === 0) return fallback;
  return raw.map((m) => msgFromRaw(m));
}

export function adaptTikTok(data: unknown) {
  const d = data as { feed?: Array<Record<string, unknown>>; videos?: Array<Record<string, unknown>> };
  const items = d.feed ?? d.videos ?? [];
  if (items.length > 0) {
    return items.map((v) => ({
      author: String(v.auteur ?? v.fullName ?? "créateur"),
      caption: String(v.caption ?? v.legende ?? ""),
      likes: String(v.likes ?? v.totalLikes ?? "0"),
    }));
  }
  return [
    { author: "mathieu.garnier.studio", caption: "Lumière du Louvre 🎨", likes: "1,2k" },
    { author: "pabordeaux", caption: "Vernissage hier soir", likes: "890" },
    { author: "studio_paris", caption: "Typo du jour", likes: "2,4k" },
  ];
}

export function adaptTinder(data: unknown) {
  const d = data as { matches?: Array<Record<string, unknown>>; profil?: Record<string, unknown> };
  const matches = (d.matches ?? []).map((m) => ({
    name: String(m.nom ?? m.name ?? "Match"),
    age: Number(m.age ?? 0) || undefined,
    bio: String(m.bio ?? ""),
    distance: String(m.distance ?? ""),
  }));
  if (matches.length > 0) return { profile: d.profil, matches };
  return {
    profile: d.profil ?? { nom: "Mathieu", bio: "Graphiste · Paris" },
    matches: [
      { name: "Léa", age: 29, bio: "Musées & vin naturel", distance: "3 km" },
      { name: "Camille", age: 31, bio: "Design & running", distance: "5 km" },
    ],
  };
}

export function adaptSocialFeed(data: unknown) {
  const d = data as { posts?: Array<Record<string, unknown>>; feed?: Array<Record<string, unknown>> };
  return (d.posts ?? d.feed ?? []).map((p) => ({
    author: String(p.auteur ?? p.author ?? "Contact"),
    text: String(p.texte ?? p.caption ?? p.contenu ?? ""),
    likes: Number(p.likes ?? p.reactions ?? 0),
    comments: Number(p.commentaires ?? p.comments ?? 0),
  }));
}

export function adaptTelephone(data: unknown) {
  const d = data as Record<string, unknown>;
  return {
    recents: ((d.recents as Array<Record<string, unknown>>) ?? []).map((r) => ({
      contact: String(r.contact ?? ""),
      type: String(r.type ?? ""),
      date: r.date as string | undefined,
      duration: String(r.duree_sec ?? r.duree ?? ""),
    })),
    voicemail: (d.messagerie_vocale as Array<Record<string, unknown>>) ?? [],
  };
}
