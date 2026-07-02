import Foundation

enum RappelsRedditSmartList: String, Identifiable, CaseIterable {
    case today
    case scheduled
    case all
    case completed

    var id: String { rawValue }

    var title: String {
        switch self {
        case .today: return "Aujourd'hui"
        case .scheduled: return "Programmés"
        case .all: return "Tous"
        case .completed: return "Terminés"
        }
    }

    var icon: String {
        switch self {
        case .today: return "sun.max.fill"
        case .scheduled: return "calendar"
        case .all: return "tray.fill"
        case .completed: return "checkmark.circle"
        }
    }

    var tint: String {
        switch self {
        case .today: return "bleu"
        case .scheduled: return "rouge"
        case .all: return "gris"
        case .completed: return "gris"
        }
    }
}

enum RappelsRedditLPSP {
    static func allItems(in lists: [LpspReminderList]) -> [LpspReminderItem] {
        lists.flatMap(\.items)
    }

    static func count(for type: RappelsRedditSmartList, lists: [LpspReminderList]) -> Int {
        filtered(type, lists: lists).count
    }

    static func filtered(_ type: RappelsRedditSmartList, lists: [LpspReminderList]) -> [LpspReminderItem] {
        let items = allItems(in: lists)
        switch type {
        case .today:
            return items.filter { !$0.completed && isToday($0.dueRaw) }
        case .scheduled:
            return items.filter { !$0.completed && !$0.dueRaw.isEmpty }
        case .all:
            return items.filter { !$0.completed }
        case .completed:
            return items.filter(\.completed)
        }
    }

    static func list(for item: LpspReminderItem, in lists: [LpspReminderList]) -> LpspReminderList? {
        lists.first { list in list.items.contains(where: { $0.id == item.id }) }
    }

    static func parseDate(_ raw: String) -> Date? {
        guard !raw.isEmpty else { return nil }
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = iso.date(from: raw) {
            return date
        }
        iso.formatOptions = [.withInternetDateTime]
        return iso.date(from: raw)
    }

    static func isToday(_ raw: String) -> Bool {
        guard let date = parseDate(raw) else { return false }
        return Calendar.current.isDateInToday(date)
    }

    static func formatDue(_ raw: String) -> String {
        guard let date = parseDate(raw) else {
            return raw.isEmpty ? "" : LpspThirdPartyFormat.frenchDateRaw(raw)
        }
        if Calendar.current.isDateInToday(date) {
            return "Aujourd'hui"
        }
        if Calendar.current.isDateInTomorrow(date) {
            return "Demain"
        }
        return LpspThirdPartyFormat.frenchDate(date, style: .medium, time: .none)
    }

    static func formatTime(_ raw: String) -> String {
        guard let date = parseDate(raw) else { return "" }
        return LpspThirdPartyFormat.frenchDate(date, style: .none, time: .short)
    }
}
