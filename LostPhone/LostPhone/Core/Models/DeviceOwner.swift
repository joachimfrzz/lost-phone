import Foundation
import SwiftUI

/// Propriétaire du téléphone simulé (Réglages, Ma carte Contacts, etc.).
struct DeviceOwner: Equatable {
    let name: String
    let initials: String

    static let fallback = DeviceOwner(name: "John Appleseed", initials: "JA")

    init(name: String, initials: String? = nil) {
        self.name = name
        self.initials = initials ?? DeviceOwner.makeInitials(from: name)
    }

    private static func makeInitials(from name: String) -> String {
        let parts = name.split(separator: " ")
        let letters = parts.prefix(2).compactMap { $0.first.map(String.init) }
        return letters.joined().uppercased()
    }
}

private struct DeviceOwnerKey: EnvironmentKey {
    static let defaultValue = DeviceOwner.fallback
}

extension EnvironmentValues {
    var deviceOwner: DeviceOwner {
        get { self[DeviceOwnerKey.self] }
        set { self[DeviceOwnerKey.self] = newValue }
    }
}
