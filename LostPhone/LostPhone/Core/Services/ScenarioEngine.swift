import Foundation

enum ScenarioEngine {
    static func parseDelayMs(_ condition: String) -> Int {
        if condition == "immediate" { return 0 }
        if let range = condition.range(of: #"delay_(\d+)min"#, options: .regularExpression) {
            let digits = condition[range].filter(\.isNumber)
            if let minutes = Int(digits) { return minutes * 60_000 }
        }
        return 30_000
    }

    static func envelopeNotifications(_ package: LpspPackage) -> [RuntimeNotification] {
        (package.content.envelope.notificationsInitiales ?? []).enumerated().map { index, notification in
            RuntimeNotification(
                id: "init-\(index)",
                app: notification.app,
                titre: notification.titre,
                texte: notification.texte,
                heure: notification.heure,
                lu: notification.lu ?? false
            )
        }
    }

    static func eventToNotification(_ event: ScenarioEvent) -> RuntimeNotification? {
        let content = event.contenu ?? [:]
        switch event.type {
        case "notification":
            return RuntimeNotification(
                id: event.id,
                app: event.app,
                titre: content["titre"]?.stringValue ?? content["title"]?.stringValue ?? event.app,
                texte: content["texte"]?.stringValue ?? content["body"]?.stringValue ?? content["message"]?.stringValue ?? "",
                heure: content["heure"]?.stringValue ?? "maintenant",
                lu: false
            )
        case "message_entrant":
            return RuntimeNotification(
                id: event.id,
                app: event.app,
                titre: content["expediteur"]?.stringValue ?? content["contact"]?.stringValue ?? content["de"]?.stringValue ?? "Message",
                texte: content["texte"]?.stringValue ?? content["message"]?.stringValue ?? content["body"]?.stringValue ?? "",
                heure: content["heure"]?.stringValue ?? "maintenant",
                lu: false
            )
        case "appel_manque":
            return RuntimeNotification(
                id: event.id,
                app: "Telephone",
                titre: content["appelant"]?.stringValue ?? content["contact"]?.stringValue ?? "Appel manqué",
                texte: content["texte"]?.stringValue ?? "Appel manqué",
                heure: content["heure"]?.stringValue ?? "maintenant",
                lu: false
            )
        default:
            return nil
        }
    }

    struct ScheduledEvent {
        let event: ScenarioEvent
        let fireAt: Date
    }

    static func schedule(_ package: LpspPackage, startAt: Date = .now) -> [ScheduledEvent] {
        let events = package.scenario?.evenements ?? []
        var cursor = startAt
        var scheduled: [ScheduledEvent] = []

        for event in events {
            let delayMs = parseDelayMs(event.condition)
            if event.condition == "immediate" {
                scheduled.append(ScheduledEvent(event: event, fireAt: startAt))
            } else if delayMs > 0 {
                cursor = cursor.addingTimeInterval(TimeInterval(delayMs) / 1000)
                scheduled.append(ScheduledEvent(event: event, fireAt: cursor))
            } else {
                cursor = cursor.addingTimeInterval(30)
                scheduled.append(ScheduledEvent(event: event, fireAt: cursor))
            }
        }

        return scheduled.sorted { $0.fireAt < $1.fireAt }
    }
}
