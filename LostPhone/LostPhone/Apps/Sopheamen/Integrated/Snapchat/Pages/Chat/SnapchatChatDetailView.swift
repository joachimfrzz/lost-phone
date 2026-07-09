import SwiftUI

struct SnapchatChatDetailView: View {
    let user: UserSnapchatResponse
    @Environment(\.dismiss) private var dismiss
    @State private var draft = ""

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Text("Hey! 👋")
                            .padding(12)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    HStack {
                        Text("On se voit ce soir ?")
                            .padding(12)
                            .background(Color.buttonPrimaryColor.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        Spacer()
                    }
                }
                .padding()
            }
            HStack {
                TextField("Send a chat…", text: $draft)
                    .textFieldStyle(.roundedBorder)
                Button("Send") { draft = "" }
            }
            .padding()
            .background(Color(uiColor: .systemBackground))
        }
        .navigationTitle(user.fullname)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.light)
    }
}
