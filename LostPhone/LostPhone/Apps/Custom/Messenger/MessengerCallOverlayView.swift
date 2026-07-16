import SwiftUI

struct MessengerCallOverlayView: View {
    let contactName: String
    @Binding var isPresented: Bool

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
                Text("Appel…")
                    .foregroundStyle(.white.opacity(0.75))
                Spacer()
                Button {
                    isPresented = false
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
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(3))
                isPresented = false
            }
        }
    }
}

#Preview {
    MessengerCallOverlayView(contactName: "Léa Martin", isPresented: .constant(true))
}
