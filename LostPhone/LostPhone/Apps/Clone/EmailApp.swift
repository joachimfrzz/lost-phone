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

    init(emails: [Email] = []) {
        self.emails = emails
    }
    
    func delete(_ email: Email) {
        if let index = emails.firstIndex(where: { $0.id == email.id }) {
            emails.remove(at: index)
        }
    }
    
    func toggleFlag(_ email: Email) {
        if let index = emails.firstIndex(where: { $0.id == email.id }) {
            emails[index].isFlagged.toggle()
        }
    }
    
    func toggleRead(_ email: Email) {
        if let index = emails.firstIndex(where: { $0.id == email.id }) {
            emails[index].isRead.toggle()
        }
    }
    
    func markAsRead(_ email: Email) {
        if let index = emails.firstIndex(where: { $0.id == email.id }) {
            if !emails[index].isRead {
                emails[index].isRead = true
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

    init(manager: MailManager = MailManager()) {
        _manager = StateObject(wrappedValue: manager)
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Section 1: Smart Folders
                Section {
                    NavigationLink(destination: InboxView(manager: manager, title: "All Inboxes")) {
                        MailboxRow(icon: "tray.2.fill", title: "All Inboxes", count: manager.unreadCount, color: .blue)
                    }
                    NavigationLink(destination: InboxView(manager: manager, title: "iCloud")) {
                        MailboxRow(icon: "tray.fill", title: "iCloud", count: 0, color: .blue)
                    }
                    NavigationLink(destination: InboxView(manager: manager, title: "VIP")) {
                        MailboxRow(icon: "star.fill", title: "VIP", count: 0, color: .yellow)
                    }
                }
                
                // Section 2: iCloud Accounts
                Section(header: Text("iCloud").textCase(nil)) {
                    MailboxRow(icon: "tray", title: "Inbox", count: 0, color: .blue)
                    MailboxRow(icon: "doc", title: "Drafts", count: 0, color: .blue)
                    MailboxRow(icon: "paperplane", title: "Sent", count: 0, color: .blue)
                    MailboxRow(icon: "bin.xmark", title: "Junk", count: 0, color: .blue)
                    MailboxRow(icon: "trash", title: "Trash", count: 0, color: .blue)
                    MailboxRow(icon: "archivebox", title: "Archive", count: 0, color: .blue)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Mailboxes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {}
                }
                
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                        Spacer()
                        VStack(spacing: 0) {
                            Text("Updated Just Now")
                                .font(.caption2)
                                .foregroundStyle(.primary)
                        }
                        Spacer()
                        Button(action: { showCompose.toggle() }) {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
            }
            .sheet(isPresented: $showCompose) {
                ComposeView()
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
        if searchText.isEmpty {
            return manager.emails
        } else {
            return manager.emails.filter {
                $0.sender.localizedCaseInsensitiveContains(searchText) ||
                $0.subject.localizedCaseInsensitiveContains(searchText) ||
                $0.body.localizedCaseInsensitiveContains(searchText)
            }
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
                            withAnimation { manager.delete(email) }
                        } label: {
                            Label("Trash", systemImage: "trash")
                        }

                        Button {
                            withAnimation { manager.toggleFlag(email) }
                        } label: {
                            Label("Flag", systemImage: "flag")
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
                    Spacer()
                    Text("Updated Just Now").font(.caption2)
                    Spacer()
                    Button(action: {}) { Image(systemName: "square.and.pencil") }
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
                            Text("To: John Appleseed")
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
                    Button(action: {}) { Image(systemName: "trash") }
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button(action: {}) { Image(systemName: "archivebox") }
                    Spacer()
                    Button(action: {}) { Image(systemName: "folder") }
                    Spacer()
                    Button(action: {}) { Image(systemName: "arrowshape.turn.up.forward") }
                    Spacer()
                    Button(action: {}) { Image(systemName: "square.and.pencil") }
                }
            }
        }
        .onAppear {
            // Mark read when opened
            manager.markAsRead(email)
        }
    }
}

// MARK: - 4. Compose Sheet

struct ComposeView: View {
    @Environment(\.dismiss) var dismiss
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
                        Text("To:")
                            .foregroundStyle(.secondary)
                            .frame(width: 50, alignment: .trailing)
                        TextField("", text: $to)
                            .focused($focusedField, equals: .to)
                    }
                    .padding(.vertical, 10)
                    Divider()
                    
                    HStack {
                        Text("Cc/Bcc:")
                            .foregroundStyle(.secondary)
                            .frame(width: 50, alignment: .trailing)
                        TextField("", text: $cc)
                            .focused($focusedField, equals: .cc)
                    }
                    .padding(.vertical, 10)
                    Divider()
                    
                    HStack {
                        Text("Subject:")
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
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Send") {
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