import Foundation

/// Persistance légère de la dernière histoire jouée (UserDefaults).
enum GameProgressStore {
    private static let lastStoryKey = "lostphone.lastStoryId"

    static var lastStoryId: String? {
        get { UserDefaults.standard.string(forKey: lastStoryKey) }
        set {
            if let newValue {
                UserDefaults.standard.set(newValue, forKey: lastStoryKey)
            } else {
                UserDefaults.standard.removeObject(forKey: lastStoryKey)
            }
        }
    }

    static func recordStoryStarted(_ storyId: String) {
        lastStoryId = storyId
    }
}
