import Foundation

/// Automated walkthrough for CI screen recordings (`-UIPreviewTour` launch argument).
enum PreviewTourDriver {
    static var isEnabled: Bool {
        ProcessInfo.processInfo.arguments.contains("-UIPreviewTour")
            || ProcessInfo.processInfo.environment["LOSTPHONE_PREVIEW_TOUR"] == "1"
    }

    private static let storyId = "j3-louvre"
    private static let pin = "1503"

    /// Apps shown in order during the tour (filtered against the loaded story).
    private static let preferredApps = [
        "Messages",
        "Photos",
        "WhatsApp",
        "Signal",
        "Notes",
        "Safari",
        "Mail",
        "Contacts",
        "Calendrier",
        "Telephone",
        "Spotify",
        "Instagram",
        "Google Maps",
        "Netflix",
        "Réglages",
    ]

    @MainActor
    static func run(phone: PhoneViewModel) async {
        guard isEnabled else { return }

        try? await sleep(seconds: 2.5)

        await phone.startStory(storyId)
        await waitForPhase(in: [.lock, .home, .pin], phone: phone, timeout: 15)

        if phone.phase == .lock {
            try? await sleep(seconds: 3)
            phone.swipeToUnlock()
            await waitForPhase(.pin, phone: phone, timeout: 5)
        }

        if phone.phase == .pin {
            try? await sleep(seconds: 1.2)
            phone.submitPin(pin)
            await waitForPhase(.home, phone: phone, timeout: 5)
        }

        try? await sleep(seconds: 1.5)

        let apps = tourApps(from: phone)
        for app in apps {
            phone.openApp(app)
            try? await sleep(seconds: 4.5)
            phone.closeApp()
            try? await sleep(seconds: 0.8)
        }

        try? await sleep(seconds: 2)
    }

    @MainActor
    private static func tourApps(from phone: PhoneViewModel) -> [String] {
        var available = Set(phone.appNames)
        available.insert("Réglages")
        return preferredApps.filter { available.contains($0) }
    }

    @MainActor
    private static func waitForPhase(
        _ target: PhonePhase,
        phone: PhoneViewModel,
        timeout: TimeInterval
    ) async {
        await waitForPhase(in: [target], phone: phone, timeout: timeout)
    }

    @MainActor
    private static func waitForPhase(
        in targets: Set<PhonePhase>,
        phone: PhoneViewModel,
        timeout: TimeInterval
    ) async {
        let deadline = Date().addingTimeInterval(timeout)
        while Date() < deadline {
            if targets.contains(phone.phase) { return }
            if case .error = phone.phase { return }
            try? await sleep(seconds: 0.2)
        }
    }

    private static func sleep(seconds: TimeInterval) async throws {
        try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}
