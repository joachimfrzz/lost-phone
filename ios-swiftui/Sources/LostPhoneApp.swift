import SwiftUI

@main
struct LostPhoneApp: App {
    var body: some Scene {
        WindowGroup {
            PhoneRootView()
        }
    }
}

struct PhoneRootView: View {
    @StateObject private var phone = PhoneViewModel()

    var body: some View {
        Group {
            switch phone.phase {
            case .loading:
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black)
            case .error(let message):
                ContentUnavailableView("Erreur", systemImage: "exclamationmark.triangle", description: Text(message))
            case .lock:
                LockScreenView(phone: phone)
            case .pin:
                PinCodeView(phone: phone)
            case .home:
                HomeScreenView(phone: phone)
            case .app(let name):
                AppHostView(appName: name, phone: phone)
            }
        }
        .preferredColorScheme(.dark)
        .task { await phone.loadStory(storyId: "j3-louvre") }
    }
}

#Preview {
    PhoneRootView()
}
