import Foundation

struct StoryEntry: Identifiable, Equatable {
    let id: String
    let title: String
    let subtitle: String?
}

enum StoryCatalog {
    /// Identifiants des histoires bundlées (`Resources/stories/<id>/lpsp.json`).
    static let storyIds = ["showroom-clone14", "j3-louvre", "demo-j3"]

    static func availableStories() -> [StoryEntry] {
        storyIds.compactMap { id in
            guard let package = try? LpspLoader.load(storyId: id) else { return nil }
            let subtitle: String? = if id == CloneShowroomLayout.storyId {
                "14 apps · disposition Reddit · sans PIN"
            } else {
                package.content.envelope.dateVerrou.map { date in
                    if let time = package.content.envelope.heureVerrou {
                        return "\(date) · \(time)"
                    }
                    return date
                }
            }
            return StoryEntry(id: id, title: package.manifest.title, subtitle: subtitle)
        }
    }
}
