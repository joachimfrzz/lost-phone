import Foundation

struct StoryEntry: Identifiable, Equatable {
    let id: String
    let title: String
    let subtitle: String?
}

enum StoryCatalog {
    /// Identifiants des histoires bundlées (`Resources/stories/<id>/lpsp.json`).
    /// J-3 en premier — Showroom = démo clones uniquement.
    static let storyIds = ["j3-louvre", "showroom-clone14", "demo-j3"]

    static func availableStories() -> [StoryEntry] {
        storyIds.compactMap { id in
            guard let package = try? LpspLoader.load(storyId: id) else { return nil }
            let subtitle: String? = if id == CloneShowroomLayout.storyId {
                "Démo UI · 14 clones Apple seulement · pas WhatsApp/Uber/etc."
            } else if id == "j3-louvre" {
                "Histoire complète · 18 apps · PIN 1503"
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
