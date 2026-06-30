import Foundation
import SwiftUI

struct LpspMessage: Identifiable, Equatable {
    let id: String
    let text: String
    let isUser: Bool
    let date: Date?
    let dateRaw: String?
}

struct LpspConversation: Identifiable, Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id: String
    let contactName: String
    let messages: [LpspMessage]
    let isUnread: Bool

    var preview: String { messages.last?.text ?? "" }
    var lastDate: Date? { messages.last?.date }
    var lastDateRaw: String? { messages.last?.dateRaw }
}

struct LpspNote: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let content: String
    let folder: String
    let modified: Date?
    let modifiedRaw: String?

    var preview: String {
        let lines = content.components(separatedBy: .newlines).dropFirst()
        return lines.joined(separator: " ")
    }
}

struct LpspEmail: Identifiable, Equatable, Hashable {
    let id: String
    let sender: String
    let subject: String
    let preview: String
    let body: String
    let date: Date?
    let dateRaw: String?
    let isRead: Bool
}

struct LpspCall: Identifiable, Equatable {
    let id: String
    let contact: String
    let type: String
    let date: Date?
    let dateRaw: String?
    let durationSec: Int

    var isMissed: Bool { type.lowercased().contains("manque") }
    var isOutgoing: Bool { type.lowercased().contains("sortant") }
}

struct LpspPhoto: Identifiable, Equatable, Hashable {
    let id: String
    let description: String
    let date: Date?
    let dateRaw: String?
    let place: String?
    let assetSource: String?
    let isScreenshot: Bool
}

struct LpspSafariTab: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let url: String
}

struct LpspSafariSearch: Identifiable, Equatable {
    let id: String
    let query: String
    let date: Date?
    let dateRaw: String?
}

struct LpspCalendarEvent: Identifiable, Equatable {
    let id: String
    let title: String
    let location: String?
    let note: String?
    let start: Date
    let end: Date
    let hasReminder: Bool
}

struct LpspContact: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let nickname: String
    let relation: String
    let note: String

    var displayName: String {
        nickname.isEmpty ? name : nickname
    }

    var sortKey: String {
        displayName.folding(options: .diacriticInsensitive, locale: .current)
    }
}

enum LpspAdapters {
    static func deviceOwner(from package: LpspPackage?) -> DeviceOwner {
        guard let config = package?.content.system?.proprietaire,
              let name = config.nom, !name.isEmpty else {
            return .fallback
        }
        return DeviceOwner(name: name, initials: config.initiales)
    }

    static func messages(from payload: AnyCodable?) -> [LpspConversation] {
        threads(from: payload, key: "threads")
    }

    static func whatsApp(from payload: AnyCodable?) -> [LpspConversation] {
        threads(from: payload, key: "threads")
    }

    static func signal(from payload: AnyCodable?) -> [LpspConversation] {
        threads(from: payload, key: "conversations")
    }

    static func notes(from payload: AnyCodable?) -> [LpspNote] {
        let items = payload?.arrayValue ?? payload?["contenu"]?.arrayValue ?? []
        return items.enumerated().compactMap { index, raw in
            guard let object = raw.objectValue else { return nil }
            let content = object["contenu"]?.stringValue ?? ""
            let title = object["titre"]?.stringValue ?? content.components(separatedBy: .newlines).first ?? "Sans titre"
            let modifiedRaw = object["date_modification"]?.stringValue ?? object["date_creation"]?.stringValue
            return LpspNote(
                id: object["id"]?.stringValue ?? "note-\(index)",
                title: title.isEmpty ? "Sans titre" : title,
                content: content,
                folder: object["dossier"]?.stringValue ?? "Notes",
                modified: parseISO(modifiedRaw),
                modifiedRaw: modifiedRaw
            )
        }
    }

    static func mail(from payload: AnyCodable?) -> [LpspEmail] {
        guard let inbox = payload?["boite_reception"]?.arrayValue else { return [] }
        return inbox.enumerated().map { index, raw in
            let object = raw.objectValue ?? [:]
            let preview = object["extrait"]?.stringValue ?? ""
            let dateRaw = object["date"]?.stringValue
            return LpspEmail(
                id: "mail-\(index)",
                sender: object["de"]?.stringValue ?? "Inconnu",
                subject: object["objet"]?.stringValue ?? "(Sans objet)",
                preview: preview,
                body: preview,
                date: parseISO(dateRaw),
                dateRaw: dateRaw,
                isRead: object["lu"]?.boolValue ?? true
            )
        }
    }

    static func phoneRecents(from payload: AnyCodable?) -> [LpspCall] {
        guard let recents = payload?["recents"]?.arrayValue else { return [] }
        return recents.enumerated().map { index, raw in
            let object = raw.objectValue ?? [:]
            let dateRaw = object["date"]?.stringValue
            let duration = object["duree_sec"]?.intValue ?? 0
            return LpspCall(
                id: "call-\(index)",
                contact: object["contact"]?.stringValue ?? "Inconnu",
                type: object["type"]?.stringValue ?? "entrant",
                date: parseISO(dateRaw),
                dateRaw: dateRaw,
                durationSec: duration
            )
        }
    }

    static func photos(from payload: AnyCodable?) -> [LpspPhoto] {
        guard let recents = payload?["recents"]?.arrayValue else { return [] }
        return recents.enumerated().map { index, raw in
            let object = raw.objectValue ?? [:]
            let dateRaw = object["date"]?.stringValue
            let description = object["description"]?.stringValue ?? ""
            let type = object["type"]?.stringValue?.lowercased() ?? ""
            let isScreenshot = type == "screenshot"
                || type == "capture"
                || description.lowercased().contains("capture d'écran")
            return LpspPhoto(
                id: object["id"]?.stringValue ?? "photo-\(index)",
                description: description,
                date: parseISO(dateRaw),
                dateRaw: dateRaw,
                place: object["lieu"]?.stringValue,
                assetSource: object["source"]?.stringValue ?? object["fichier"]?.stringValue,
                isScreenshot: isScreenshot
            )
        }
    }

    static func photoAlbums(from payload: AnyCodable?) -> [String] {
        payload?["albums"]?.arrayValue?.compactMap(\.stringValue) ?? ["Récents"]
    }

    static func safariTabs(from payload: AnyCodable?) -> [LpspSafariTab] {
        guard let tabs = payload?["onglets_ouverts"]?.arrayValue else { return [] }
        return tabs.enumerated().map { index, raw in
            let object = raw.objectValue ?? [:]
            return LpspSafariTab(
                id: "tab-\(index)",
                title: object["titre"]?.stringValue ?? "Onglet",
                url: object["url"]?.stringValue ?? ""
            )
        }
    }

    static func safariHistory(from payload: AnyCodable?) -> [LpspSafariSearch] {
        guard let history = payload?["historique_recent"]?.arrayValue else { return [] }
        return history.enumerated().map { index, raw in
            let object = raw.objectValue ?? [:]
            let dateRaw = object["date"]?.stringValue
            return LpspSafariSearch(
                id: "search-\(index)",
                query: object["recherche"]?.stringValue ?? "",
                date: parseISO(dateRaw),
                dateRaw: dateRaw
            )
        }
    }

    static func calendar(from payload: AnyCodable?) -> [LpspCalendarEvent] {
        guard let events = payload?["evenements"]?.arrayValue else { return [] }
        return events.enumerated().compactMap { index, raw in
            guard let object = raw.objectValue else { return nil }
            let title = object["titre"]?.stringValue ?? "Événement"
            let dateRaw = object["date"]?.stringValue
            guard let start = parseISO(dateRaw) else { return nil }
            let durationMin = object["duree_min"]?.intValue ?? 60
            let end = Calendar.current.date(byAdding: .minute, value: durationMin, to: start) ?? start
            return LpspCalendarEvent(
                id: object["id"]?.stringValue ?? "event-\(index)",
                title: title,
                location: object["lieu"]?.stringValue,
                note: object["note"]?.stringValue,
                start: start,
                end: end,
                hasReminder: object["rappel"]?.boolValue ?? false
            )
        }
    }

    static func contacts(from payload: AnyCodable?) -> [LpspContact] {
        guard let cards = payload?["fiches"]?.arrayValue else { return [] }
        return cards.enumerated().compactMap { index, raw in
            guard let object = raw.objectValue else { return nil }
            let name = object["nom"]?.stringValue ?? "Inconnu"
            return LpspContact(
                id: object["id"]?.stringValue ?? "contact-\(index)",
                name: name,
                nickname: object["surnom"]?.stringValue ?? name,
                relation: object["relation"]?.stringValue ?? "",
                note: object["note"]?.stringValue ?? ""
            )
        }
    }

    static func musicTracks(from payload: AnyCodable?) -> [Track] {
        guard let items = payload?["pistes"]?.arrayValue ?? payload?["tracks"]?.arrayValue else {
            return MusicManager.storyFallbackTracks
        }
        return items.enumerated().compactMap { index, raw in
            guard let object = raw.objectValue else { return nil }
            let title = object["titre"]?.stringValue ?? object["title"]?.stringValue ?? "Titre"
            let artist = object["artiste"]?.stringValue ?? object["artist"]?.stringValue ?? "Artiste"
            return Track(
                stableId: object["id"]?.stringValue ?? "track-\(index)",
                trackName: title,
                artistName: artist
            )
        }
    }

    static func threads(from payload: AnyCodable?, key: String) -> [LpspConversation] {
        guard let threads = payload?[key]?.arrayValue else { return [] }
        return threads.enumerated().compactMap { index, thread in
            guard let object = thread.objectValue else { return nil }
            let contact = object["contact"]?.stringValue ?? "Inconnu"
            let rawMessages = object["messages"]?.arrayValue ?? []
            let messages = rawMessages.enumerated().map { messageIndex, raw in
                parseMessage(raw, index: messageIndex)
            }
            let unread = isThreadUnread(rawMessages: rawMessages)
            return LpspConversation(
                id: "\(key)-\(index)",
                contactName: contact,
                messages: messages,
                isUnread: unread
            )
        }
    }

    static func appPayload(from package: LpspPackage, appName: String) -> AnyCodable? {
        LpspNormalize.appPayload(from: package.content.apps, name: appName)
    }

    private static func parseMessage(_ raw: AnyCodable, index: Int) -> LpspMessage {
        let object = raw.objectValue ?? [:]
        let sender = (object["de"] ?? object["expediteur"] ?? object["from"])?.stringValue ?? ""
        let text = (object["texte"] ?? object["contenu"] ?? object["body"] ?? object["message"])?.stringValue ?? ""
        let lower = sender.lowercased()
        let isUser = ["moi", "me", "mathieu", "m"].contains(lower)
        let iso = object["date"]?.stringValue
        return LpspMessage(
            id: object["id"]?.stringValue ?? "msg-\(index)",
            text: text,
            isUser: isUser,
            date: parseISO(iso),
            dateRaw: iso
        )
    }

    private static func isThreadUnread(rawMessages: [AnyCodable]) -> Bool {
        for raw in rawMessages.reversed() {
            guard let object = raw.objectValue else { continue }
            let sender = (object["de"] ?? object["expediteur"] ?? object["from"])?.stringValue ?? ""
            let lower = sender.lowercased()
            let isUser = ["moi", "me", "mathieu", "m"].contains(lower)
            guard !isUser else { continue }
            if let read = object["lu"]?.boolValue {
                return !read
            }
            return true
        }
        return false
    }

    static func parseISO(_ iso: String?) -> Date? {
        guard let iso, !iso.isEmpty else { return nil }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: iso) { return date }
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: iso)
    }

    static func formatShortDate(_ date: Date?, fallback: String? = nil) -> String {
        if let date {
            if Calendar.current.isDateInToday(date) {
                return date.formatted(date: .omitted, time: .shortened)
            }
            return date.formatted(date: .numeric, time: .omitted)
        }
        return fallback ?? ""
    }

    static func formatMessageTime(_ message: LpspMessage) -> String? {
        if let date = message.date {
            return date.formatted(date: .omitted, time: .shortened)
        }
        if let raw = message.dateRaw, !raw.isEmpty {
            return raw
        }
        return nil
    }
}
