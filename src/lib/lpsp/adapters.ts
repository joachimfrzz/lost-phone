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

function msgFromRaw(m: Record<string, unknown>): NormalizedMessage {
  const sender = String(m.de ?? m.expediteur ?? m.from ?? "");
  const text = String(m.texte ?? m.contenu ?? m.body ?? m.message ?? "");
  const outgoing =
    sender.toLowerCase() === "moi" ||
    sender.toLowerCase() === "me" ||
    sender.toLowerCase() === "mathieu" ||
    sender.toLowerCase() === "m";
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
    const messages = ((t.messages as Array<Record<string, unknown>>) ?? []).map(msgFromRaw);
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
    const messages = ((c.messages as Array<Record<string, unknown>>) ?? []).map(msgFromRaw);
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
      comments: Number(p.commentaires ?? 0),
      date: p.date as string | undefined,
    })),
    dms: ((d.dm_threads as Array<Record<string, unknown>>) ?? []).map((t) => ({
      contact: String(t.contact ?? ""),
      preview: String(
        ((t.messages as Array<Record<string, unknown>>) ?? []).at(-1)?.texte ??
          ((t.messages as Array<Record<string, unknown>>) ?? []).at(-1)?.contenu ??
          ""
      ),
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
  const d = data as Record<string, unknown>;
  return {
    account: d.compte as Record<string, unknown> | undefined,
    profiles: (d.profils as Array<Record<string, unknown>>) ?? [],
    continueWatching: (d.continuer_a_regarder as Array<Record<string, unknown>>) ?? [],
    favorites: (d.catalogue_favori as Array<Record<string, unknown>>) ?? [],
  };
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
