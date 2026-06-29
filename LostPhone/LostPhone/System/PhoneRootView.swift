import SwiftUI

struct PhoneRootView: View {
    @StateObject private var phone = PhoneViewModel()

    var body: some View {
        ZStack {
            switch phone.phase {
            case .loading:
                ProgressView("Chargement LPSP…")
                    .tint(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black)
            case .error(let message):
                ContentUnavailableView("Erreur LPSP", systemImage: "exclamationmark.triangle", description: Text(message))
            case .lock:
                LockScreenView()
            case .pin:
                PinCodeView()
            case .home, .app:
                HomeShellView()
            }
        }
        .environmentObject(phone)
        .task {
            await phone.loadStory(storyId: "j3-louvre")
        }
    }
}
