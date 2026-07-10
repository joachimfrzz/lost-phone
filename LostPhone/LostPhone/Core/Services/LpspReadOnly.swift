import SwiftUI

private struct LpspReadOnlyKey: EnvironmentKey {
    static let defaultValue = true
}

private struct LpspStoryIdKey: EnvironmentKey {
    static let defaultValue: String? = nil
}

private struct LpspStoryDateKey: EnvironmentKey {
    static let defaultValue = Date()
}

extension EnvironmentValues {
    /// Les apps clone en mode Lost Phone sont en lecture seule (pas d'envoi / édition).
    var lpspReadOnly: Bool {
        get { self[LpspReadOnlyKey.self] }
        set { self[LpspReadOnlyKey.self] = newValue }
    }

    /// Identifiant histoire courante pour résoudre les assets bundlés.
    var lpspStoryId: String? {
        get { self[LpspStoryIdKey.self] }
        set { self[LpspStoryIdKey.self] = newValue }
    }

    /// Date de référence narrative (« aujourd'hui » dans l'histoire).
    var lpspStoryDate: Date {
        get { self[LpspStoryDateKey.self] }
        set { self[LpspStoryDateKey.self] = newValue }
    }
}
