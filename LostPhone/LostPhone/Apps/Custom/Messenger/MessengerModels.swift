import SwiftUI

struct MessengerContact: Identifiable, Hashable {
    let id: String
    let name: String
    let initials: String
    let isOnline: Bool
    let activeLabel: String?
}

struct MessengerThread: Identifiable, Hashable {
    let id: String
    let title: String
    let isGroup: Bool
    let preview: String
    let timeLabel: String
    let unreadCount: Int
    let contact: MessengerContact?
    let memberCount: Int?
    let hasMedia: Bool
}

enum MessengerMessageKind: Hashable {
    case text(String)
    case image(String)
    case reply(String, quoted: String)
    case reaction(String, emoji: String)
    case system(String)
}

struct MessengerMessage: Identifiable, Hashable {
    let id: String
    let isSent: Bool
    let time: String
    let kind: MessengerMessageKind
    let senderName: String?
}

struct MessengerNotification: Identifiable, Hashable {
    let id: String
    let title: String
    let body: String
    let timeLabel: String
    let threadId: String
}

enum MessengerSampleData {
    static let contacts: [MessengerContact] = [
        MessengerContact(id: "lea", name: "Léa Martin", initials: "LM", isOnline: true, activeLabel: "En ligne"),
        MessengerContact(id: "julien", name: "Julien", initials: "J", isOnline: false, activeLabel: "Vu récemment"),
        MessengerContact(id: "emma", name: "Emma R.", initials: "ER", isOnline: false, activeLabel: "Active il y a 2 h"),
    ]

    static let threads: [MessengerThread] = [
        MessengerThread(id: "lea", title: "Léa Martin", isGroup: false, preview: "Tu as reçu la photo ?", timeLabel: "14:02", unreadCount: 2, contact: contacts[0], memberCount: nil, hasMedia: true),
        MessengerThread(id: "soiree", title: "Soirée vendredi", isGroup: true, preview: "Julien: On se retrouve vers 20h", timeLabel: "12:44", unreadCount: 0, contact: nil, memberCount: 5, hasMedia: false),
        MessengerThread(id: "julien", title: "Julien", isGroup: false, preview: "Appel manqué", timeLabel: "Hier", unreadCount: 0, contact: contacts[1], memberCount: nil, hasMedia: false),
        MessengerThread(id: "emma", title: "Emma R.", isGroup: false, preview: "❤️ sur « D'accord »", timeLabel: "Lun.", unreadCount: 1, contact: contacts[2], memberCount: nil, hasMedia: false),
    ]

    static let notifications: [MessengerNotification] = [
        MessengerNotification(id: "n1", title: "Léa Martin", body: "Tu as reçu la photo ?", timeLabel: "14:02", threadId: "lea"),
        MessengerNotification(id: "n2", title: "Soirée vendredi", body: "Julien: On se retrouve vers 20h", timeLabel: "12:44", threadId: "soiree"),
    ]

    static let groupMembers = ["Léa Martin", "Julien", "Emma R.", "Thomas", "Toi"]
    static let pinnedMessages = ["On se retrouve vers 20h", "Voici la photo du lieu"]

    static func messages(for threadId: String) -> [MessengerMessage] {
        switch threadId {
        case "lea":
            return [
                MessengerMessage(id: "1", isSent: false, time: "13:58", kind: .text("Salut !"), senderName: nil),
                MessengerMessage(id: "2", isSent: true, time: "14:00", kind: .text("Hey"), senderName: nil),
                MessengerMessage(id: "3", isSent: false, time: "14:01", kind: .image("Photo du bar"), senderName: nil),
                MessengerMessage(id: "4", isSent: false, time: "14:02", kind: .text("Tu as reçu la photo ?"), senderName: nil),
            ]
        case "soiree":
            return [
                MessengerMessage(id: "g1", isSent: false, time: "12:30", kind: .system("Emma a rejoint le groupe"), senderName: nil),
                MessengerMessage(id: "g2", isSent: false, time: "12:40", kind: .text("Quelqu'un a une adresse ?"), senderName: "Emma"),
                MessengerMessage(id: "g3", isSent: false, time: "12:44", kind: .text("On se retrouve vers 20h"), senderName: "Julien"),
            ]
        default:
            return [
                MessengerMessage(id: "d1", isSent: false, time: "09:00", kind: .text("Message de démonstration Lost Phone."), senderName: nil),
            ]
        }
    }

    static func thread(for id: String) -> MessengerThread? {
        threads.first { $0.id == id }
    }
}
