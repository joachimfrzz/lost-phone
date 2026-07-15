import SwiftUI

struct WhatsAppContact: Identifiable, Hashable {
    let id: String
    let name: String
    let avatarInitials: String
    let isOnline: Bool
    let lastSeen: String?
    let phone: String
}

struct WhatsAppChat: Identifiable, Hashable {
    let id: String
    let title: String
    let isGroup: Bool
    let preview: String
    let timeLabel: String
    let unreadCount: Int
    let isRead: Bool
    let isArchived: Bool
    let contact: WhatsAppContact?
    let groupMemberCount: Int?
}

enum WhatsAppMessageKind: Hashable {
    case text(String)
    case image(String)
    case voice(String)
    case document(String)
    case reply(String, quoted: String)
    case reaction(String, emoji: String)
    case system(String)
}

struct WhatsAppMessage: Identifiable, Hashable {
    let id: String
    let isSent: Bool
    let time: String
    let kind: WhatsAppMessageKind
    let senderName: String?
}

enum WhatsAppCallKind: Hashable {
    case audio, video
}

enum WhatsAppCallDirection: Hashable {
    case incoming, outgoing, missed
}

struct WhatsAppCall: Identifiable, Hashable {
    let id: String
    let contact: WhatsAppContact
    let kind: WhatsAppCallKind
    let direction: WhatsAppCallDirection
    let dateLabel: String
}

enum WhatsAppSampleData {
    static let contacts: [WhatsAppContact] = [
        WhatsAppContact(id: "marie", name: "Marie Dupont", avatarInitials: "MD", isOnline: true, lastSeen: nil, phone: "+33 6 12 34 56 78"),
        WhatsAppContact(id: "thomas", name: "Thomas", avatarInitials: "T", isOnline: false, lastSeen: "hier à 23:14", phone: "+33 6 98 76 54 32"),
        WhatsAppContact(id: "sophie", name: "Sophie L.", avatarInitials: "SL", isOnline: false, lastSeen: "aujourd'hui à 08:02", phone: "+33 7 11 22 33 44"),
    ]

    static let chats: [WhatsAppChat] = [
        WhatsAppChat(id: "marie", title: "Marie Dupont", isGroup: false, preview: "Tu as vu le message de Thomas ?", timeLabel: "14:32", unreadCount: 2, isRead: false, isArchived: false, contact: contacts[0], groupMemberCount: nil),
        WhatsAppChat(id: "coloc", title: "Coloc 🏠", isGroup: true, preview: "Sophie: J'ai trouvé la clé sous le paillasson", timeLabel: "12:05", unreadCount: 0, isRead: true, isArchived: false, contact: nil, groupMemberCount: 4),
        WhatsAppChat(id: "thomas", title: "Thomas", isGroup: false, preview: "📎 Contrat.pdf", timeLabel: "Hier", unreadCount: 0, isRead: true, isArchived: false, contact: contacts[1], groupMemberCount: nil),
        WhatsAppChat(id: "sophie", title: "Sophie L.", isGroup: false, preview: "🎤 Message vocal (0:24)", timeLabel: "Lun.", unreadCount: 1, isRead: false, isArchived: false, contact: contacts[2], groupMemberCount: nil),
    ]

    static func messages(for chatId: String) -> [WhatsAppMessage] {
        switch chatId {
        case "marie":
            return [
                WhatsAppMessage(id: "1", isSent: false, time: "14:28", kind: .text("Salut, tu es dispo ce soir ?"), senderName: nil),
                WhatsAppMessage(id: "2", isSent: true, time: "14:30", kind: .text("Peut-être — pourquoi ?"), senderName: nil),
                WhatsAppMessage(id: "3", isSent: false, time: "14:32", kind: .reply("Tu as vu le message de Thomas ?", quoted: "Peut-être — pourquoi ?"), senderName: nil),
            ]
        case "coloc":
            return [
                WhatsAppMessage(id: "g1", isSent: false, time: "11:58", kind: .system("Sophie a rejoint le groupe"), senderName: nil),
                WhatsAppMessage(id: "g2", isSent: false, time: "12:01", kind: .text("Quelqu'un a une spare key ?"), senderName: "Thomas"),
                WhatsAppMessage(id: "g3", isSent: false, time: "12:05", kind: .text("J'ai trouvé la clé sous le paillasson"), senderName: "Sophie"),
            ]
        default:
            return [
                WhatsAppMessage(id: "d1", isSent: false, time: "09:00", kind: .text("Message de démonstration Lost Phone."), senderName: nil),
            ]
        }
    }

    static let calls: [WhatsAppCall] = [
        WhatsAppCall(id: "c1", contact: contacts[0], kind: .audio, direction: .missed, dateLabel: "Aujourd'hui 09:14"),
        WhatsAppCall(id: "c2", contact: contacts[1], kind: .video, direction: .outgoing, dateLabel: "Hier 21:03"),
        WhatsAppCall(id: "c3", contact: contacts[2], kind: .audio, direction: .incoming, dateLabel: "Lun. 18:40"),
    ]

    static let groupMembers = ["Marie Dupont", "Thomas", "Sophie L.", "Toi"]
}
