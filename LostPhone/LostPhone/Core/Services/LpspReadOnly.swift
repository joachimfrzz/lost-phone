import SwiftUI

private struct LpspReadOnlyKey: EnvironmentKey {
    static let defaultValue = true
}

extension EnvironmentValues {
    /// Les apps clone en mode Lost Phone sont en lecture seule (pas d'envoi / édition).
    var lpspReadOnly: Bool {
        get { self[LpspReadOnlyKey.self] }
        set { self[LpspReadOnlyKey.self] = newValue }
    }
}
