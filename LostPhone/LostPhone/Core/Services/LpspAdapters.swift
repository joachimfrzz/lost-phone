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

enum LpspAdapters {
    static func messages(from payload: AnyCodable?) -> [LpspConversation] {
        threads(from: payload, key: "threads")
    }

    static func whatsApp(from payload: AnyCodable?) -> [LpspConversation] {
        threads(from: payload, key: "threads")
    }

    static func signal(from payload: AnyCodable?) -> [LpspConversation] {
        threads(from: payload, key: "conversations")
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
