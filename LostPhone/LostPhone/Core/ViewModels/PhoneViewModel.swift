import Foundation
import SwiftUI

@MainActor
final class PhoneViewModel: ObservableObject {
    @Published var phase: PhonePhase = .loading
    @Published var package: LpspPackage?
    @Published var notifications: [RuntimeNotification] = []
    @Published var pinError = false
    @Published var overlay: SystemOverlay = .none
    @Published var activeApp: String?

    private var pinCode = ""
    private var scenarioTask: Task<Void, Never>?
    private var firedEventIds = Set<String>()
    private var scheduledEvents: [ScenarioEngine.ScheduledEvent] = []
    private var storyStart = Date()

    var appNames: [String] {
        package?.manifest.appsPresentes ?? []
    }

    var dockApps: [String] {
        package?.content.system?.dock ?? Array(appNames.prefix(4))
    }

    var lockTime: String {
        package?.content.envelope.heureVerrou ?? "14:30"
    }

    var lockDate: String {
        package?.content.envelope.dateVerrou ?? ""
    }

    var unreadCount: Int {
        notifications.filter { !$0.lu }.count
    }

    func loadStory(storyId: String = "j3-louvre") async {
        phase = .loading
        scenarioTask?.cancel()
        do {
            let loaded = try LpspLoader.load(storyId: storyId)
            package = loaded
            notifications = ScenarioEngine.envelopeNotifications(loaded)
            let lock = LpspNormalize.parseLock(loaded.playerConfig.verrouillage)
            pinCode = lock.code
            storyStart = .now
            scheduledEvents = ScenarioEngine.schedule(loaded, startAt: storyStart)
            startScenarioLoop()
            phase = lock.requiresPin ? .lock : .home
        } catch {
            phase = .error(error.localizedDescription)
        }
    }

    func appData(for name: String) -> AnyCodable? {
        guard let package else { return nil }
        return LpspAdapters.appPayload(from: package, appName: name)
    }

    func swipeToUnlock() {
        phase = pinCode.isEmpty ? .home : .pin
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
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
        activeApp = name
        phase = .app(name)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    func closeApp() {
        activeApp = nil
        phase = .home
    }

    func markNotificationRead(_ id: String) {
        guard let index = notifications.firstIndex(where: { $0.id == id }) else { return }
        notifications[index].lu = true
    }

    func openNotificationCenter() {
        overlay = .notifications
    }

    func closeOverlay() {
        overlay = .none
    }

    private func startScenarioLoop() {
        scenarioTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                await self?.tickScenario()
            }
        }
    }

    private func tickScenario() {
        let now = Date()
        for item in scheduledEvents where item.fireAt <= now && !firedEventIds.contains(item.event.id) {
            firedEventIds.insert(item.event.id)
            if let notification = ScenarioEngine.eventToNotification(item.event) {
                notifications.insert(notification, at: 0)
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
        }
    }

    deinit {
        scenarioTask?.cancel()
    }
}
