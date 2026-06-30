import SwiftUI

/// Mail — UI clone zerocode117, contenu LPSP (lecture seule).
struct LpspMailView: View {
    let emails: [LpspEmail]
    @State private var selected: LpspEmail?

    var unreadCount: Int { emails.filter { !$0.isRead }.count }

    var body: some View {
        NavigationStack {
            Group {
                if emails.isEmpty {
                    ContentUnavailableView(
                        "Mail",
                        systemImage: "envelope.fill",
                        description: Text("Ajoutez des e-mails dans lpsp.json → content.apps.Mail")
                    )
                } else {
                    List(emails) { email in
                        Button { selected = email } label: {
                            LpspEmailRow(email: email)
                        }
                        .buttonStyle(.plain)
                        .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Boîte de réception")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("Mis à jour").font(.caption2)
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.secondary.opacity(0.35))
                    }
                }
            }
            .navigationDestination(item: $selected) { email in
                LpspEmailDetailView(email: email)
            }
        }
    }
}

struct LpspEmailRow: View {
    let email: LpspEmail

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(email.isRead ? Color.clear : Color.blue)
                .frame(width: 10, height: 10)
                .padding(.top, 6)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(email.sender)
                        .font(.headline)
                        .fontWeight(email.isRead ? .regular : .semibold)
                        .lineLimit(1)
                    Spacer()
                    Text(LpspAdapters.formatShortDate(email.date, fallback: email.dateRaw))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Text(email.subject)
                    .font(.subheadline)
                    .fontWeight(email.isRead ? .regular : .semibold)
                    .lineLimit(1)
                Text(email.preview)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
    }
}

struct LpspEmailDetailView: View {
    let email: LpspEmail

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Circle()
                        .fill(.blue.gradient)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Text(String(email.sender.prefix(1)))
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                        }
                    VStack(alignment: .leading) {
                        Text(email.sender).font(.headline)
                        Text(LpspAdapters.formatShortDate(email.date, fallback: email.dateRaw))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Text(email.subject)
                    .font(.title3.weight(.semibold))
                Text(email.body)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Text("Lecture seule — contenu LPSP")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.bar)
        }
    }
}
