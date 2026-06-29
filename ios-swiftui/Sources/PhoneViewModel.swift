import Foundation

enum PhonePhase: Equatable {
    case loading
    case error(String)
    case lock
    case pin
    case home
    case app(String)
}

@MainActor
final class PhoneViewModel: ObservableObject {
    @Published var phase: PhonePhase = .loading
    @Published var package: LpspPackage?
    @Published var pinError = false

    private var pinCode = ""

    func loadStory(storyId: String) async {
        phase = .loading
        do {
            guard let url = Bundle.main.url(forResource: storyId, withExtension: "json", subdirectory: "stories/\(storyId)") ??
                    Bundle.main.url(forResource: "lpsp", withExtension: "json")
            else {
                phase = .error("LPSP introuvable dans le bundle")
                return
            }
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(LpspPackage.self, from: data)
            package = decoded
            pinCode = decoded.playerConfig.verrouillage?.code ?? ""
            let needsPin = decoded.playerConfig.verrouillage?.type?.lowercased().contains("pin") == true
            phase = needsPin ? .lock : .home
        } catch {
            phase = .error(error.localizedDescription)
        }
    }

    func swipeToUnlock() {
        guard package != nil else { return }
        phase = pinCode.isEmpty ? .home : .pin
    }

    func submitPin(_ digits: String) {
        if digits == pinCode {
            pinError = false
            phase = .home
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } else {
            pinError = true
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }

    func openApp(_ name: String) {
        phase = .app(name)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    func closeApp() {
        phase = .home
    }
}
