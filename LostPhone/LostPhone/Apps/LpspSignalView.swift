import SwiftUI

/// Signal — style clone iOS, contenu 100 % LPSP (lecture seule).
struct LpspSignalView: View {
    let conversations: [LpspConversation]
    @State private var selected: LpspConversation?

    private let signalBlue = Color(red: 0.227, green: 0.463, blue: 0.941)
    private let darkBackground = Color(red: 0.043, green: 0.043, blue: 0.043)

    var body: some View {
        NavigationStack {
            Group {
                if conversations.isEmpty {
                    ContentUnavailableView(
                        "Signal",
                        systemImage: "lock.fill",
                        description: Text("Ajoutez des conversations dans lpsp.json → content.apps.Signal")
                    )
                } else {
                    List(conversations) { conversation in
                        Button {
                            selected = conversation
                        } label: {
                            LpspSignalInboxRow(conversation: conversation, accent: signalBlue)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Signal")
            .navigationBarTitleDisplayMode(.large)
            .safeAreaInset(edge: .top, spacing: 0) {
                if !conversations.isEmpty {
                    HStack(spacing: 6) {
                        Image(systemName: "lock.fill")
                            .font(.caption2)
                        Text("Chiffré de bout en bout")
                            .font(.subheadline)
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                }
            }
            .navigationDestination(item: $selected) { conversation in
                LpspThemedChatDetailView(
                    conversation: conversation,
                    theme: .signal,
                    headerAccessory: AnyView(LpspSignalEncryptionBanner())
                )
                .toolbarBackground(darkBackground, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
            }
        }
        .preferredColorScheme(nil)
    }
}

struct LpspSignalInboxRow: View {
    let conversation: LpspConversation
    let accent: Color

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(accent.gradient)
                .frame(width: 48, height: 48)
                .overlay {
                    Image(systemName: "lock.fill")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(conversation.contactName)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.primary)
                    Spacer()
                    if conversation.isUnread {
                        Circle()
                            .fill(accent)
                            .frame(width: 10, height: 10)
                    }
                }

                Text(conversation.preview)
                    .font(.subheadline)
                    .foregroundStyle(conversation.isUnread ? .primary : .secondary)
                    .lineLimit(2)
                    .fontWeight(conversation.isUnread ? .semibold : .regular)
            }
        }
        .padding(.vertical, 4)
    }
}
