import Foundation
import SwiftUI

/// Convertit les payloads LPSP en modèles des vues clone zerocode117.
enum LpspCloneBridge {
    static func notesManager(from items: [LpspNote]) -> NotesManager {
        NotesManager(notes: items.map { item in
            let body: String
            if item.content.hasPrefix(item.title) || item.title == "Sans titre" {
                body = item.content
            } else {
                body = "\(item.title)\n\(item.content)"
            }
            return Note(
                id: LpspStableId.uuid(item.id),
                content: body,
                lastModified: item.modified ?? .distantPast
            )
        })
    }

    static func mailManager(from items: [LpspEmail]) -> MailManager {
        MailManager(emails: items.map { item in
            Email(
                stableId: item.id,
                sender: item.sender,
                subject: item.subject,
                body: item.body,
                date: item.date ?? .distantPast,
                isRead: item.isRead,
                isFlagged: false
            )
        })
    }

    static func photoLibrary(from items: [LpspPhoto]) -> PhotoLibrary {
        PhotoLibrary(galleryPhotos: items.map { item in
            GalleryPhoto(
                id: item.id,
                caption: item.description,
                place: item.place,
                capturedAt: item.date,
                capturedLabel: item.dateRaw
            )
        })
    }

    static func recentCalls(from items: [LpspCall]) -> [RecentItem] {
        items.map { call in
            RecentItem(
                stableId: call.id,
                name: call.contact,
                label: call.isMissed ? "missed" : "mobile",
                date: LpspAdapters.formatShortDate(call.date, fallback: call.dateRaw),
                type: call.isMissed ? .missed : (call.isOutgoing ? .outgoing : .incoming)
            )
        }
    }

    static func messagesViewModel(from conversations: [LpspConversation]) -> MessagesViewModel {
        MessagesViewModel(conversations: conversations.map { thread in
            Conversation(
                stableId: thread.id,
                contactName: thread.contactName,
                avatarColor: .blue,
                messages: thread.messages.map { msg in
                    Message(
                        stableId: msg.id,
                        content: msg.text,
                        isUser: msg.isUser,
                        date: msg.date ?? .distantPast
                    )
                },
                isUnread: thread.isUnread
            )
        })
    }

    static func safariViewModel(tabs: [LpspSafariTab], history: [LpspSafariSearch]) -> SafariViewModel {
        SafariViewModel(
            lpspTabs: tabs.map { SafariTabItem(id: $0.id, title: $0.title, url: $0.url) },
            lpspHistory: history.map {
                SafariHistoryItem(
                    id: $0.id,
                    query: $0.query,
                    dateLabel: LpspAdapters.formatShortDate($0.date, fallback: $0.dateRaw)
                )
            }
        )
    }
}
