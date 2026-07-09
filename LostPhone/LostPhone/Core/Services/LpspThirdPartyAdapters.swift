import Foundation

extension LpspAdapters {

    /// Accepte `content.apps.X` avec ou sans wrapper `contenu`.
    static func contentObject(_ payload: AnyCodable?) -> [String: AnyCodable]? {
        guard let payload else { return nil }
        if let nested = payload["contenu"]?.objectValue { return nested }
        return payload.objectValue
    }

    // MARK: - Uber

    static func uber(from payload: AnyCodable?) -> [LpspRide] {
        guard let root = contentObject(payload),
              let courses = root["courses"]?.arrayValue else { return [] }
        return courses.enumerated().map { index, raw in
            let o = raw.objectValue ?? [:]
            let dateRaw = o["date"]?.stringValue ?? ""
            return LpspRide(
                id: o["id"]?.stringValue ?? "ride-\(index)",
                date: parseISO(dateRaw),
                dateRaw: dateRaw,
                pickup: o["pickup"]?.stringValue ?? "",
                dropoff: o["dropoff"]?.stringValue ?? "",
                duration: o["duree"]?.stringValue ?? "",
                price: o["prix"]?.stringValue ?? "",
                driver: o["chauffeur"]?.stringValue ?? "",
                vehicle: o["vehicule"]?.stringValue ?? "",
                status: o["statut"]?.stringValue ?? ""
            )
        }
        .sorted { ($0.date ?? .distantPast) > ($1.date ?? .distantPast) }
    }

    static func uberAccount(from payload: AnyCodable?) -> LpspUberAccount? {
        guard let root = contentObject(payload),
              let account = root["compte"]?.objectValue else { return nil }
        let places = (account["adresses_enregistrees"]?.arrayValue ?? []).enumerated().map { i, raw in
            let o = raw.objectValue ?? [:]
            return LpspMapPlace(
                id: "uber-place-\(i)",
                label: o["label"]?.stringValue ?? "",
                address: o["adresse"]?.stringValue ?? ""
            )
        }
        return LpspUberAccount(
            name: account["nom"]?.stringValue ?? "",
            email: account["email"]?.stringValue ?? "",
            phone: account["telephone"]?.stringValue ?? "",
            passengerRating: account["note_passager"]?.doubleValue ?? 0,
            paymentMethod: account["moyen_paiement"]?.stringValue ?? "",
            savedPlaces: places
        )
    }

    // MARK: - Banque

    static func banque(from payload: AnyCodable?) -> LpspBankData? {
        guard let root = contentObject(payload) else { return nil }
        let holder = root["titulaire"]?.objectValue ?? [:]
        let accounts = (root["comptes"]?.arrayValue ?? []).enumerated().map { index, raw in
            let o = raw.objectValue ?? [:]
            return LpspBankAccount(
                id: "acc-\(index)",
                type: o["type"]?.stringValue ?? "Compte",
                partialNumber: o["numero_partiel"]?.stringValue ?? "",
                balance: o["solde"]?.doubleValue ?? o["solde"]?.intValue.map(Double.init) ?? 0,
                currency: o["devise"]?.stringValue ?? "EUR"
            )
        }
        let ops = (root["operations"]?.arrayValue ?? []).enumerated().map { index, raw in
            let o = raw.objectValue ?? [:]
            let dateRaw = o["date"]?.stringValue ?? ""
            return LpspBankOperation(
                id: "op-\(index)",
                date: parseISO(dateRaw),
                dateRaw: dateRaw,
                label: o["libelle"]?.stringValue ?? "",
                amount: o["montant"]?.doubleValue ?? 0,
                category: o["categorie"]?.stringValue ?? ""
            )
        }
        let card = root["carte_bancaire"]?.objectValue ?? [:]
        return LpspBankData(
            holderName: holder["nom"]?.stringValue ?? "",
            advisor: holder["conseiller"]?.stringValue ?? "",
            branch: holder["agence"]?.stringValue ?? "",
            accounts: accounts,
            operations: ops,
            cardPartial: card["numero_partiel"]?.stringValue ?? ""
        )
    }

    // MARK: - Plans

    static func plans(from payload: AnyCodable?) -> LpspMapsData? {
        guard let root = contentObject(payload) else { return nil }
        let places = (root["adresses_enregistrees"]?.arrayValue ?? []).enumerated().map { i, raw in
            let o = raw.objectValue ?? [:]
            return LpspMapPlace(
                id: "place-\(i)",
                label: o["label"]?.stringValue ?? "",
                address: o["adresse"]?.stringValue ?? ""
            )
        }
        let trips = (root["historique_trajets"]?.arrayValue ?? []).enumerated().map { i, raw in
            let o = raw.objectValue ?? [:]
            let dateRaw = o["date"]?.stringValue ?? ""
            return LpspMapTrip(
                id: o["id"]?.stringValue ?? "trip-\(i)",
                date: parseISO(dateRaw),
                dateRaw: dateRaw,
                origin: o["depart"]?.stringValue ?? "",
                destination: o["arrivee"]?.stringValue ?? "",
                mode: o["mode"]?.stringValue ?? "",
                duration: o["duree"]?.stringValue ?? ""
            )
        }
        .sorted { ($0.date ?? .distantPast) > ($1.date ?? .distantPast) }
        let routes = (root["itineraires_sauvegardes"]?.arrayValue ?? []).enumerated().map { i, raw in
            let o = raw.objectValue ?? [:]
            return LpspSavedRoute(
                id: o["id"]?.stringValue ?? "route-\(i)",
                name: o["nom"]?.stringValue ?? "Itinéraire",
                origin: o["depart"]?.stringValue ?? "",
                destination: o["arrivee"]?.stringValue ?? "",
                duration: o["duree_estimee"]?.stringValue ?? ""
            )
        }
        return LpspMapsData(places: places, trips: trips, routes: routes)
    }

    // MARK: - Fichiers

    static func fichiers(from payload: AnyCodable?) -> [LpspFileItem] {
        guard let root = contentObject(payload) else { return [] }
        var items: [LpspFileItem] = []
        if let tree = root["arborescence"]?.objectValue {
            flattenFiles(node: tree, path: "", into: &items)
        }
        if let deleted = root["fichier_recemment_supprime"]?.arrayValue {
            for (i, raw) in deleted.enumerated() {
                let f = raw.objectValue ?? [:]
                items.append(LpspFileItem(
                    id: "deleted-\(i)",
                    name: f["nom"]?.stringValue ?? "fichier",
                    path: "Récemment supprimés/",
                    type: f["type"]?.stringValue ?? "PDF",
                    size: f["taille"]?.stringValue ?? "",
                    description: f["description"]?.stringValue ?? "",
                    modifiedRaw: f["date_suppression"]?.stringValue ?? "",
                    isDeleted: true
                ))
            }
        }
        return items.sorted { lhs, rhs in
            if lhs.isDeleted != rhs.isDeleted { return !lhs.isDeleted }
            return lhs.path < rhs.path
        }
    }

    private static func flattenFiles(node: [String: AnyCodable], path: String, into items: inout [LpspFileItem]) {
        if let folders = node["iCloud Drive"]?.arrayValue {
            for folder in folders {
                parseFolder(folder, path: "iCloud Drive/", into: &items)
            }
        }
        for (key, value) in node where key != "iCloud Drive" {
            if let arr = value.arrayValue {
                for folder in arr { parseFolder(folder, path: key + "/", into: &items) }
            }
        }
    }

    private static func parseFolder(_ raw: AnyCodable, path: String, into items: inout [LpspFileItem]) {
        guard let o = raw.objectValue else { return }
        let folderName = o["dossier"]?.stringValue ?? "Dossier"
        let current = path + folderName + "/"
        if let files = o["fichiers"]?.arrayValue {
            for (i, file) in files.enumerated() {
                let f = file.objectValue ?? [:]
                items.append(LpspFileItem(
                    id: "\(current)-\(i)",
                    name: f["nom"]?.stringValue ?? "fichier",
                    path: current,
                    type: f["type"]?.stringValue ?? "PDF",
                    size: f["taille"]?.stringValue ?? "",
                    description: f["description"]?.stringValue ?? "",
                    modifiedRaw: f["date_modification"]?.stringValue ?? f["date_creation"]?.stringValue ?? ""
                ))
            }
        }
        if let subs = o["sous_dossiers"]?.arrayValue {
            for sub in subs { parseFolder(sub, path: current, into: &items) }
        }
    }

    // MARK: - Rappels

    static func rappels(from payload: AnyCodable?) -> [LpspReminderList] {
        guard let root = contentObject(payload),
              let lists = root["listes"]?.arrayValue else { return [] }
        return lists.enumerated().map { listIndex, raw in
            let o = raw.objectValue ?? [:]
            let name = o["nom"]?.stringValue ?? "Liste"
            let items = (o["rappels"]?.arrayValue ?? []).enumerated().map { i, item in
                let r = item.objectValue ?? [:]
                return LpspReminderItem(
                    id: "\(listIndex)-\(i)",
                    title: r["titre"]?.stringValue ?? "",
                    notes: r["notes"]?.stringValue ?? "",
                    completed: r["complete"]?.boolValue ?? false,
                    dueRaw: r["date_rappel"]?.stringValue ?? "",
                    priority: r["priorite"]?.stringValue ?? ""
                )
            }
            return LpspReminderList(
                id: "list-\(listIndex)",
                name: name,
                emoji: o["icone"]?.stringValue ?? "📋",
                colorName: o["couleur"]?.stringValue ?? "bleu",
                items: items
            )
        }
    }

    // MARK: - Instagram

    static func instagram(from payload: AnyCodable?) -> LpspInstagramProfile? {
        let root = payload?.objectValue ?? contentObject(payload)
        guard let root else { return nil }
        let profil = root["profil"]?.objectValue ?? [:]
        let username = profil["pseudo"]?.stringValue ?? "compte"
        let posts = (root["feed"]?.arrayValue ?? []).enumerated().map { i, raw in
            let o = raw.objectValue ?? [:]
            let dateRaw = o["date"]?.stringValue ?? ""
            return LpspInstagramPost(
                id: "post-\(i)",
                author: o["auteur"]?.stringValue ?? username,
                caption: o["caption"]?.stringValue ?? "",
                date: dateRaw,
                dateParsed: parseDay(dateRaw),
                likes: o["likes"]?.intValue ?? 0
            )
        }
        .sorted { ($0.dateParsed ?? .distantPast) > ($1.dateParsed ?? .distantPast) }
        return LpspInstagramProfile(
            username: username,
            bio: profil["bio"]?.stringValue ?? "",
            posts: posts
        )
    }

    static func instagramDM(from payload: AnyCodable?) -> [LpspConversation] {
        let root = payload?.objectValue ?? contentObject(payload)
        guard let root,
              let threads = root["dm_threads"]?.arrayValue else { return [] }
        let owner = (root["profil"]?.objectValue?["pseudo"]?.stringValue ?? "mathieu").lowercased()
        return threads.enumerated().compactMap { index, thread in
            guard let object = thread.objectValue else { return nil }
            let contact = object["contact_display_name"]?.stringValue
                ?? object["contact"]?.stringValue
                ?? "Inconnu"
            let rawMessages = object["messages"]?.arrayValue ?? []
            let messages = rawMessages.enumerated().map { messageIndex, raw in
                parseInstagramMessage(raw, index: messageIndex, ownerUsername: owner)
            }
            let unread = isThreadUnread(rawMessages: rawMessages)
            return LpspConversation(
                id: "ig-dm-\(index)",
                contactName: contact,
                messages: messages,
                isUnread: unread
            )
        }
    }

    private static func parseInstagramMessage(
        _ raw: AnyCodable,
        index: Int,
        ownerUsername: String
    ) -> LpspMessage {
        let object = raw.objectValue ?? [:]
        let sender = (object["de"] ?? object["expediteur"] ?? object["from"])?.stringValue ?? ""
        let text = (object["texte"] ?? object["contenu"] ?? object["body"] ?? object["message"])?.stringValue ?? ""
        let lower = sender.lowercased()
        let isUser = lower == ownerUsername
            || lower.contains("mathieu")
            || ["moi", "me", "m"].contains(lower)
        let iso = object["date"]?.stringValue
        return LpspMessage(
            id: object["id"]?.stringValue ?? "ig-msg-\(index)",
            text: text,
            isUser: isUser,
            date: parseISO(iso),
            dateRaw: iso
        )
    }

    private static func parseDay(_ raw: String) -> Date? {
        guard !raw.isEmpty else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: raw)
    }

    // MARK: - Spotify

    static func spotify(from payload: AnyCodable?) -> LpspSpotifyData? {
        guard let root = contentObject(payload) else { return nil }
        let account = root["compte"]?.objectValue ?? [:]
        let playlists = (root["playlists"]?.arrayValue ?? []).enumerated().map { pi, raw in
            let o = raw.objectValue ?? [:]
            let tracks = (o["titres_visibles"]?.arrayValue ?? []).enumerated().map { ti, tr in
                let t = tr.objectValue ?? [:]
                return LpspSpotifyTrack(
                    id: "pl-\(pi)-\(ti)",
                    title: t["titre"]?.stringValue ?? "",
                    artist: t["artiste"]?.stringValue ?? "",
                    playedAtRaw: nil,
                    playedAt: nil
                )
            }
            return LpspSpotifyPlaylist(
                id: "playlist-\(pi)",
                title: o["titre"]?.stringValue ?? "Playlist",
                trackCount: o["nombre_titres"]?.intValue ?? tracks.count,
                tracks: tracks
            )
        }
        let recent = (root["historique_ecoute_recent"]?.arrayValue
            ?? root["ecoutes_recentes"]?.arrayValue ?? []).enumerated().map { i, raw in
            let o = raw.objectValue ?? [:]
            let dateRaw = o["date"]?.stringValue ?? o["date_ecoute"]?.stringValue
            return LpspSpotifyTrack(
                id: "recent-\(i)",
                title: o["titre"]?.stringValue ?? o["nom"]?.stringValue ?? "",
                artist: o["artiste"]?.stringValue ?? "",
                playedAtRaw: dateRaw,
                playedAt: parseISO(dateRaw)
            )
        }
        return LpspSpotifyData(
            username: account["nom_utilisateur"]?.stringValue ?? "",
            plan: account["abonnement"]?.stringValue ?? "",
            playlists: playlists,
            recentTracks: recent
        )
    }

    // MARK: - Apple Music

    static func appleMusic(from payload: AnyCodable?) -> LpspAppleMusicData? {
        guard let root = contentObject(payload) else { return nil }
        let account = root["compte"]?.objectValue ?? [:]
        let playlists = (root["playlists"]?.arrayValue ?? []).enumerated().map { pi, raw in
            let o = raw.objectValue ?? [:]
            let tracks = (o["titres_visibles"]?.arrayValue ?? []).enumerated().map { ti, tr in
                let t = tr.objectValue ?? [:]
                return LpspAppleMusicTrack(
                    id: "am-pl-\(pi)-\(ti)",
                    title: t["titre"]?.stringValue ?? "",
                    artist: t["artiste"]?.stringValue ?? ""
                )
            }
            return LpspAppleMusicPlaylist(
                id: "am-playlist-\(pi)",
                title: o["titre"]?.stringValue ?? "Playlist",
                trackCount: o["nombre_titres"]?.intValue ?? tracks.count,
                tracks: tracks
            )
        }
        let recent = (root["ecoutes_recentes"]?.arrayValue ?? []).enumerated().map { i, raw in
            let o = raw.objectValue ?? [:]
            return LpspAppleMusicTrack(
                id: "am-recent-\(i)",
                title: o["titre"]?.stringValue ?? o["nom"]?.stringValue ?? "",
                artist: o["artiste"]?.stringValue ?? ""
            )
        }
        return LpspAppleMusicData(
            username: account["nom_utilisateur"]?.stringValue ?? "",
            plan: account["abonnement"]?.stringValue ?? "",
            playlists: playlists,
            recentTracks: recent
        )
    }

    // MARK: - Netflix

    static func netflix(from payload: AnyCodable?) -> LpspNetflixData? {
        guard let root = contentObject(payload) else { return nil }
        let account = root["compte"]?.objectValue ?? [:]
        let profiles = (root["profils"]?.arrayValue ?? []).enumerated().map { i, raw in
            let o = raw.objectValue ?? [:]
            return LpspNetflixProfile(
                id: "profile-\(i)",
                name: o["nom"]?.stringValue ?? "",
                avatar: o["avatar"]?.stringValue ?? "🎬",
                isKids: o["nom"]?.stringValue?.contains("Hugo") ?? false
            )
        }
        var watching: [LpspNetflixItem] = []
        if let cw = root["continuer_a_regarder"]?.objectValue {
            for (profileName, items) in cw {
                let displayName = profileName
                    .replacingOccurrences(of: "profil_", with: "")
                    .capitalized
                for (i, raw) in (items.arrayValue ?? []).enumerated() {
                    let o = raw.objectValue ?? [:]
                    watching.append(LpspNetflixItem(
                        id: "\(profileName)-\(i)",
                        title: o["titre"]?.stringValue ?? "",
                        kind: o["type"]?.stringValue ?? "",
                        progress: o["progression"]?.stringValue ?? "",
                        profileName: displayName
                    ))
                }
            }
        }
        return LpspNetflixData(
            holder: account["titulaire"]?.stringValue ?? "",
            plan: account["abonnement"]?.stringValue ?? "",
            profiles: profiles,
            continueWatching: watching
        )
    }
}

private extension AnyCodable {
    var doubleValue: Double? {
        switch self {
        case .double(let d): return d
        case .int(let i): return Double(i)
        case .string(let s): return Double(s.replacingOccurrences(of: ",", with: "."))
        default: return nil
        }
    }
}
