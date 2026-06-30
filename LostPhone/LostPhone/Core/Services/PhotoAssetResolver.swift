import UIKit

/// Charge les images Photos bundlées : Resources/stories/<storyId>/assets/<source>
enum PhotoAssetResolver {
    static func uiImage(source: String?, storyId: String?) -> UIImage? {
        image(storyId: storyId, relativeSource: source)
    }

    static func image(storyId: String?, relativeSource: String?) -> UIImage? {
        guard let storyId, let relativeSource, !relativeSource.isEmpty else { return nil }

        let candidates = [
            "stories/\(storyId)/assets/\(relativeSource)",
            "\(storyId)/assets/\(relativeSource)",
            relativeSource,
        ]

        for path in candidates {
            let nsPath = path as NSString
            let directory = nsPath.deletingLastPathComponent
            let filename = nsPath.lastPathComponent
            let name = (filename as NSString).deletingPathExtension
            let ext = (filename as NSString).pathExtension

            if !ext.isEmpty,
               let url = Bundle.main.url(forResource: name, withExtension: ext, subdirectory: directory.isEmpty ? nil : directory),
               let image = UIImage(contentsOfFile: url.path) {
                return image
            }

            if let url = Bundle.main.url(forResource: path, withExtension: nil),
               let image = UIImage(contentsOfFile: url.path) {
                return image
            }
        }

        return nil
    }
}
