import SwiftUI

/// Port de `chat_detail_page.dart` — conversation 1:1.
struct VendoredTinderChatDetailView: View {
    let profile: VendoredTinderProfile
    @State private var messages: [VendoredTinderChatMessage]
    @State private var draft = ""

    init(profile: VendoredTinderProfile) {
        self.profile = profile
        _messages = State(initialValue: VendoredTinderData.thread(for: profile))
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                VendoredTinderBundledPhoto(imageName: profile.imageName)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 3) {
                    Text(profile.name)
                        .font(.system(size: 18, weight: .bold))
                    Text("Active now")
                        .font(.system(size: 14))
                        .foregroundStyle(.black.opacity(0.4))
                }
                Spacer()
                Image(systemName: "phone.fill")
                    .foregroundStyle(VendoredTinderTheme.primary)
                Image(systemName: "video.fill")
                    .foregroundStyle(VendoredTinderTheme.primary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.15))

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isMine { Spacer(minLength: 60) }
                            Text(message.text)
                                .font(.system(size: 16))
                                .foregroundStyle(message.isMine ? .black : .white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(
                                    message.isMine
                                        ? AnyShapeStyle(Color.gray.opacity(0.15))
                                        : AnyShapeStyle(VendoredTinderTheme.primaryGradient),
                                    in: RoundedRectangle(cornerRadius: 18, style: .continuous)
                                )
                            if !message.isMine { Spacer(minLength: 60) }
                        }
                    }
                }
                .padding(16)
            }

            HStack(spacing: 10) {
                TextField("Type a message", text: $draft)
                    .padding(12)
                    .background(Color.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 24))
                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundStyle(VendoredTinderTheme.primary)
                }
            }
            .padding(12)
            .background(Color.white)
        }
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func sendMessage() {
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        messages.append(
            VendoredTinderChatMessage(text: text, isMine: true)
        )
        draft = ""
    }
}
