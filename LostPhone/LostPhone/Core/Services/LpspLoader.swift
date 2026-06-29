import Foundation

enum LpspLoader {
    static func load(storyId: String = "j3-louvre") throws -> LpspPackage {
        let candidates = [
            Bundle.main.url(forResource: "lpsp", withExtension: "json", subdirectory: "stories/\(storyId)"),
            Bundle.main.url(forResource: "lpsp", withExtension: "json", subdirectory: "Resources/stories/\(storyId)"),
            Bundle.main.url(forResource: "lpsp", withExtension: "json"),
        ].compactMap { $0 }

        guard let url = candidates.first else {
            throw LpspLoaderError.notFound(storyId)
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(LpspPackage.self, from: data)
    }
}

enum LpspLoaderError: LocalizedError {
    case notFound(String)

    var errorDescription: String? {
        switch self {
        case .notFound(let id):
            return "LPSP introuvable pour « \(id) ». Vérifiez stories/\(id)/lpsp.json dans le bundle."
        }
    }
}
