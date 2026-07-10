//
//  Email.swift
//  iOS
//
//  Created by Pallav Agarwal on 11/20/25.
//


import SwiftUI
import Combine

// MARK: - Models

struct Email: Identifiable, Hashable {
    let id: UUID
    let sender: String
    let subject: String
    let body: String
    let date: Date
    var isRead: Bool
    var isFlagged: Bool

    init(stableId: String, sender: String, subject: String, body: String, date: Date, isRead: Bool, isFlagged: Bool) {
        self.id = LpspStableId.uuid(stableId)
        self.sender = sender
        self.subject = subject
        self.body = body
        self.date = date
        self.isRead = isRead
        self.isFlagged = isFlagged
    }

    var preview: String {
        body.replacingOccurrences(of: "\n", with: " ")
    }
}

class MailManager: ObservableObject {
    @Published var emails: [Email] = []
    @Published var sent: [Email] = []
    @Published var drafts: [Email] = []

    init(emails: [Email] = [], sent: [Email] = [], drafts: [Email] = []) {
        self.emails = emails
        self.sent = sent
        self.drafts = drafts
    }

    func emails(for title: String) -> [Email] {
        switch title {
        case Fr.drafts, "Brouillons":
            return drafts
        case Fr.sent, "Envoyés":
            return sent
        case Fr.junk, "Indésirables", Fr.trash, "Corbeille", Fr.archive, "Archives":
            return []
        default:
            return emails
        }
    }
    
    func delete(_ email: Email, from title: String) {
        let list = folderKey(for: title)
        remove(email, from: list)
    }

    func delete(_ email: Email) {
        remove(email, from: \.emails)
    }
    
    private func folderKey(for title: String) -> WritableKeyPath<MailManager, [Email]> {
        switch title {
        case Fr.drafts, "Brouillons": return \.drafts
        case Fr.sent, "Envoyés": return \.sent
        default: return \.emails
        }
    }

    private func remove(_ email: Email, from keyPath: WritableKeyPath<MailManager, [Email]>) {
        var list = self[keyPath: keyPath]
        if let index = list.firstIndex(where: { $0.id == email.id }) {
            list.remove(at: index)
            self[keyPath: keyPath] = list
        }
    }
    
    func toggleFlag(_ email: Email) {
        mutateEmail(email) { $0.isFlagged.toggle() }
    }
    
    func toggleRead(_ email: Email) {
        mutateEmail(email) { $0.isRead.toggle() }
    }
    
    func markAsRead(_ email: Email) {
        mutateEmail(email) {
            if !$0.isRead { $0.isRead = true }
        }
    }

    func appendSent(_ email: Email) {
        sent.insert(email, at: 0)
    }

    private func mutateEmail(_ email: Email, _ transform: (inout Email) -> Void) {
        for keyPath in [\.emails, \.sent, \.drafts] as [WritableKeyPath<MailManager, [Email]>] {
            var list = self[keyPath: keyPath]
            if let index = list.firstIndex(where: { $0.id == email.id }) {
                transform(&list[index])
                self[keyPath: keyPath] = list
                return
            }
        }
    }
    
    var unreadCount: Int {
        emails.filter { !$0.isRead }.count
    }
}

// MARK: - 1. Root Mailboxes View

struct MailView: View {
    @StateObject private var manager: MailManager
    @State private var showCompose = false
    @Environment(\.lpspReadOnly) private var readOnly

    init(manager: MailManager = MailManager()) {
        _manager = StateObject(wrappedValue: manager)
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Section 1: Smart Folders
                Section {
                    NavigationLink(destination: InboxView(manager: manager, title: "Toutes les boîtes")) {
                        MailboxRow(icon: "tray.2.fill", title: "Toutes les boîtes", count: manager.unreadCount, color: .blue)
                    }
                    NavigationLink(destination: InboxView(manager: manager, title: "iCloud")) {
                        MailboxRow(icon: "tray.fill", title: "iCloud", count: 0, color: .blue)
                    }
                    NavigationLink(destination: InboxView(manager: manager, title: "VIP")) {
                        MailboxRow(icon: "star.fill", title: "VIP", count: 0, color: .yellow)
                    }
                }
                
                // Section 2: iCloud Accounts
                Section(header: Text(Fr.iCloud).textCase(nil)) {
                    NavigationLink(destination: InboxView(manager: manager, title: Fr.inbox)) {
                        MailboxRow(icon: "tray", title: Fr.inbox, count: manager.unreadCount, color: .blue)
                    }
                    NavigationLink(destination: InboxView(manager: manager, title: Fr.drafts)) {
                        MailboxRow(icon: "doc", title: Fr.drafts, count: manager.drafts.count, color: .blue)
                    }
                    NavigationLink(destination: InboxView(manager: manager, title: Fr.sent)) {
                        MailboxRow(icon: "paperplane", title: Fr.sent, count: manager.sent.count, color: .blue)
                    }
                    NavigationLink(destination: InboxView(manager: manager, title: Fr.junk)) {
                        MailboxRow(icon: "bin.xmark", title: Fr.junk, count: 0, color: .blue)
                    }
                    NavigationLink(destination: InboxView(manager: manager, title: Fr.trash)) {
                        MailboxRow(icon: "trash", title: Fr.trash, count: 0, color: .blue)
                    }
                    NavigationLink(destination: InboxView(manager: manager, title: Fr.archive)) {
                        MailboxRow(icon: "archivebox", title: Fr.archive, count: 0, color: .blue)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Boîtes mail")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Modifier") {}
                        .disabled(readOnly)
                }
                
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                        .disabled(readOnly)
                        Spacer()
                        VStack(spacing: 0) {
                            Text("Mis à jour à l'instant")
                                .font(.caption2)
                                .foregroundStyle(.primary)
                        }
                        Spacer()
                        Button(action: { showCompose.toggle() }) {
                            Image(systemName: "square.and.pencil")
                        }
                        .disabled(readOnly)
                        .opacity(readOnly ? 0.35 : 1)
                    }
                }
            }
            .sheet(isPresented: $showCompose) {
                ComposeView(manager: manager)
            }
        }
    }
}

struct MailboxRow: View {
    let icon: String
    let title: String
    let count: Int
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.body)
                .foregroundStyle(color)
                .frame(width: 24)
            
            Text(title)
            
            Spacer()
            
            if count > 0 {
                Text("\(count)")
                    .foregroundStyle(.gray)
            }
        }
    }
}

// MARK: - 2. Inbox List View

struct InboxView: View {
    @ObservedObject var manager: MailManager
    let title: String
    @State private var searchText = ""
    @Environment(\.lpspReadOnly) private var readOnly
    
    var filteredEmails: [Email] {
        let folderEmails = manager.emails(for: title)
        if searchText.isEmpty {
            return folderEmails
        }
        return folderEmails.filter {
            $0.sender.localizedCaseInsensitiveContains(searchText) ||
            $0.subject.localizedCaseInsensitiveContains(searchText) ||
            $0.body.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredEmails, id: \.self) { email in
                ZStack {
                    NavigationLink(destination: EmailDetailView(email: email, manager: manager)) {
                        EmptyView()
                    }
                    .opacity(0)
                    
                    EmailRow(email: email)
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                .swipeActions(edge: .trailing, allowsFullSwipe: !readOnly) {
                    if !readOnly {
                        Button(role: .destructive) {
                            withAnimation { manager.delete(email, from: title) }
                        } label: {
                            Label("Corbeille", systemImage: "trash")
                        }

                        Button {
                            withAnimation { manager.toggleFlag(email) }
                        } label: {
                            Label("Signaler", systemImage: "flag")
                        }
                        .tint(.orange)
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: !readOnly) {
                    if !readOnly {
                        Button {
                            withAnimation { manager.toggleRead(email) }
                        } label: {
                            Label(email.isRead ? "Unread" : "Read", systemImage: "envelope.badge")
                        }
                        .tint(.blue)
                    }
                }
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button(action: {}) { Image(systemName: "line.3.horizontal.decrease.circle") }
                        .disabled(readOnly)
                    Spacer()
                    Text("Mis à jour à l'instant").font(.caption2)
                    Spacer()
                    Button(action: {}) { Image(systemName: "square.and.pencil") }
                        .disabled(readOnly)
                        .opacity(readOnly ? 0.35 : 1)
                }
            }
        }
    }
}

struct EmailRow: View {
    let email: Email
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            // Unread Indicator
            if !email.isRead {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                    .padding(.top, 4)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                // Header Line: Sender and Date
                HStack {
                    Text(email.sender)
                        .font(.headline)
                        .fontWeight(email.isRead ? .regular : .semibold)
                    
                    Spacer()
                    
                    Text(formatDate(email.date))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                
                // Subject
                Text(email.subject)
                    .font(.subheadline)
                    .fontWeight(email.isRead ? .regular : .semibold)
                
                // Preview
                Text(email.preview)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        // Handle indent if read (to align text with unread rows)
        .padding(.leading, email.isRead ? 10 : 0)
    }
    
    func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return date.formatted(date: .omitted, time: .shortened)
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            return formatter.string(from: date)
        }
    }
}

// MARK: - 3. Email Detail View

struct EmailDetailView: View {
    let email: Email
    @ObservedObject var manager: MailManager
    @Environment(\.deviceOwner) private var owner
    @Environment(\.lpspReadOnly) private var readOnly
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Info
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text(email.subject)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                        if email.isFlagged {
                            Image(systemName: "flag.fill")
                                .foregroundStyle(.orange)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        // Avatar
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text(String(email.sender.prefix(1)))
                                    .font(.title3)
                                    .foregroundStyle(.gray)
                            )
                        
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text(email.sender)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            Text("À : \(owner.name)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Divider()
                }
                .padding(.horizontal)
                
                // Body Content
                Text(email.body)
                    .font(.body)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button(action: {}) { Image(systemName: "arrowshape.turn.up.backward") }
                        .disabled(readOnly)
                    Button(action: {}) { Image(systemName: "trash") }
                        .disabled(readOnly)
                }
                .opacity(readOnly ? 0.35 : 1)
            }
            
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button(action: {}) { Image(systemName: "archivebox") }
                        .disabled(readOnly)
                    Spacer()
                    Button(action: {}) { Image(systemName: "folder") }
                        .disabled(readOnly)
                    Spacer()
                    Button(action: {}) { Image(systemName: "arrowshape.turn.up.forward") }
                        .disabled(readOnly)
                    Spacer()
                    Button(action: {}) { Image(systemName: "square.and.pencil") }
                        .disabled(readOnly)
                }
                .opacity(readOnly ? 0.35 : 1)
            }
        }
        .onAppear {
            if !readOnly {
                manager.markAsRead(email)
            }
        }
    }
}

// MARK: - 4. Compose Sheet

struct ComposeView: View {
    @ObservedObject var manager: MailManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.deviceOwner) private var owner
    @State private var to = ""
    @State private var cc = ""
    @State private var subject = ""
    @State private var message = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case to, cc, subject, body
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header Fields
                VStack(spacing: 0) {
                    HStack {
                        Text("À :")
                            .foregroundStyle(.secondary)
                            .frame(width: 50, alignment: .trailing)
                        TextField("", text: $to)
                            .focused($focusedField, equals: .to)
                    }
                    .padding(.vertical, 10)
                    Divider()
                    
                    HStack {
                        Text("Cc/Cci :")
                            .foregroundStyle(.secondary)
                            .frame(width: 50, alignment: .trailing)
                        TextField("", text: $cc)
                            .focused($focusedField, equals: .cc)
                    }
                    .padding(.vertical, 10)
                    Divider()
                    
                    HStack {
                        Text("Objet :")
                            .foregroundStyle(.secondary)
                            .frame(width: 50, alignment: .trailing)
                        TextField("", text: $subject)
                            .focused($focusedField, equals: .subject)
                    }
                    .padding(.vertical, 10)
                    Divider()
                }
                .padding(.horizontal)
                .background(Color(uiColor: .systemBackground))
                
                // Body
                TextEditor(text: $message)
                    .focused($focusedField, equals: .body)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Nouveau message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(Fr.send) {
                        let email = Email(
                            stableId: "sent-\(UUID().uuidString)",
                            sender: owner.name,
                            subject: subject.isEmpty ? "(Sans objet)" : subject,
                            body: message,
                            date: Date(),
                            isRead: true,
                            isFlagged: false
                        )
                        manager.appendSent(email)
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .disabled(to.isEmpty)
                }
            }
            .onAppear {
                focusedField = .to
            }
        }
    }
}

#Preview {
    MailView()
}