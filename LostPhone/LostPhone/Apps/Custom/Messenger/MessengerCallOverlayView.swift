import SwiftUI

struct MessengerCallOverlayView: View {
    let contactName: String
    let onEnd: () -> Void
    @State private var phase = 0

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#1C1E21"), Color(hex: "#3A3B3C")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()
                MessengerAvatar(title: contactName, size: 120)
                Text(contactName)
                    .font(.title.weight(.semibold))
                    .foregroundStyle(.white)
                Text(statusLabel)
                    .foregroundStyle(.white.opacity(0.75))
                Spacer()
                Button {
                    onEnd()
                } label: {
                    Image(systemName: "phone.down.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 72, height: 72)
                        .background(Color.red)
                        .clipShape(Circle())
                }
                .padding(.bottom, 48)
            }
        }
        .onAppear {
            Task {
                try? await Task.sleep(for: .seconds(3))
                await MainActor.run { onEnd() }
            }
        }
    }

    private var statusLabel: String {
        switch phase {
        case 0: "Appel…"
        case 1: "Sonnerie…"
        default: "Appel terminé"
        }
    }
}

#Preview {
    MessengerCallOverlayView(contactName: "Léa Martin", onEnd: {})
}
