import Foundation

struct LpspPackage: Codable {
    let manifest: LpspManifest
    let playerConfig: PlayerConfig
    let content: LpspContent

    enum CodingKeys: String, CodingKey {
        case manifest
        case playerConfig = "player_config"
        case content
    }
}

struct LpspManifest: Codable {
    let title: String
    let appsPresentes: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case appsPresentes = "apps_presentes"
    }
}

struct PlayerConfig: Codable {
    let verrouillage: Verrouillage?
}

struct Verrouillage: Codable {
    let type: String?
    let code: String?
}

struct LpspContent: Codable {
    let envelope: LpspEnvelope
    let system: LpspSystem?
    let apps: [String: LpspAppEntry]?
}

struct LpspEnvelope: Codable {
    let heureVerrou: String?
    let dateVerrou: String?
    let fondEcran: FondEcran?

    enum CodingKeys: String, CodingKey {
        case heureVerrou = "heure_verrou"
        case dateVerrou = "date_verrou"
        case fondEcran = "fond_ecran"
    }
}

struct FondEcran: Codable {
    let description: String?
}

struct LpspSystem: Codable {
    let dock: [String]?
    let batterie: String?
}

struct LpspAppEntry: Codable {
    let payload: LpspPayload?
}

struct LpspPayload: Codable {
    // Extension progressive par app
}
