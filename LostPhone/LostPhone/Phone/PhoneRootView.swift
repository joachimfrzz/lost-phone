import SwiftUI

struct PhoneRootView: View {
    @EnvironmentObject private var phone: PhoneViewModel
    private let stories = StoryCatalog.availableStories()

    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.05, blue: 0.12).ignoresSafeArea()

            switch phone.phase {
            case .menu:
                GameHomeView(stories: stories)
            case .loading:
                ProgressView("Chargement de l'histoire…")
                    .tint(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black)
            case .error(let message):
                ContentUnavailableView("Erreur LPSP", systemImage: "exclamationmark.triangle", description: Text(message))
                    .overlay(alignment: .bottom) {
                        Button("Retour au menu") { phone.returnToMenu() }
                            .buttonStyle(.borderedProminent)
                            .padding(.bottom, 40)
                    }
            case .lock:
                LockScreenView()
                    .phoneSystemChrome()
            case .pin:
                PinCodeView()
            case .home, .app:
                HomeShellView()
                    .phoneSystemChrome()
            }
        }
        .environmentObject(phone)
        .task {
            await PreviewTourDriver.run(phone: phone)
        }
    }
}
