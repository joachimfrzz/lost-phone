import SwiftUI

struct VendoredSnapchatChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isMe: Bool
}

struct VendoredSnapchatChatDetailView: View {
    let user: VendoredSnapchatUserSnapchatResponse
    @State private var draft = ""
    @State private var messages: [VendoredSnapchatChatMessage] = [
        VendoredSnapchatChatMessage(text: "Hey! 👋", isMe: false),
        VendoredSnapchatChatMessage(text: "On se voit ce soir ?", isMe: true)
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(messages) { message in
                        if message.isMe {
                            HStack {
                                Spacer()
                                Text(message.text)
                                    .padding(12)
                                    .background(Color.vendoredSnapchatButtonPrimaryColor.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        } else {
                            HStack {
                                Text(message.text)
                                    .padding(12)
                                    .background(Color(uiColor: .secondarySystemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
            }
            HStack {
                TextField("Send a chat…", text: $draft)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { sendMessage() }
                Button("Send") { sendMessage() }
            }
            .padding()
            .background(Color(uiColor: .systemBackground))
        }
        .navigationTitle(user.fullname)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.light)
    }

    private func sendMessage() {
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        messages.append(VendoredSnapchatChatMessage(text: text, isMe: true))
        draft = ""
    }
}
