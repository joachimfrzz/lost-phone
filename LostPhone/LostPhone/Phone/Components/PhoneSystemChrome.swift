import SwiftUI

/// Gestes système (centre notifs / centre contrôle).
///
/// NC et CC sont **désactivés** : inutiles au gameplay et source de confusion
/// avec le vrai centre de notifications / contrôle de l’appareil du joueur.
/// Les notifications scénario restent visibles sur l’écran de verrouillage (`LockScreenView`).
struct PhoneSystemChrome: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func phoneSystemChrome() -> some View {
        modifier(PhoneSystemChrome())
    }
}
