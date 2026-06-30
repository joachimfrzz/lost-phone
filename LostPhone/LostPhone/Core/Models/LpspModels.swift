import Foundation

struct LpspPackage: Codable {
    let lpspVersion: String
    let manifest: LpspManifest
    let playerConfig: LpspPlayerConfig
    let content: LpspContent
    let scenario: LpspScenario?

    enum CodingKeys: String, CodingKey {
        case lpspVersion = "lpsp_version"
        case manifest
        case playerConfig = "player_config"
        case content
        case scenario
    }
}

struct LpspManifest: Codable {
    let projectId: String?
    let title: String
    let appsPresentes: [String]

    enum CodingKeys: String, CodingKey {
        case projectId = "project_id"
        case title
        case appsPresentes = "apps_presentes"
    }
}

struct LpspPlayerConfig: Codable {
    let verrouillage: VerrouillageConfig?
}

struct VerrouillageConfig: Codable {
    let type: String?
    let code: String?
    let indiceDeductible: String?

    enum CodingKeys: String, CodingKey {
        case type, code
        case indiceDeductible = "indice_deductible"
    }
}

struct LpspContent: Codable {
    let envelope: LpspEnvelope
    let system: LpspSystem?
    let apps: [String: AnyCodable]
}

struct LpspEnvelope: Codable {
    let heureVerrou: String?
    let dateVerrou: String?
    let fondEcran: FondEcran?
    let notificationsInitiales: [LpspNotification]?

    enum CodingKeys: String, CodingKey {
        case heureVerrou = "heure_verrou"
        case dateVerrou = "date_verrou"
        case fondEcran = "fond_ecran"
        case notificationsInitiales = "notifications_initiales"
    }
}

struct FondEcran: Codable {
    let description: String?
    let source: String?
}

struct LpspSystem: Codable {
    let dock: [String]?
    let batterie: String?
    let wifiEnregistres: [WifiEntry]?
    let proprietaire: DeviceOwnerConfig?

    enum CodingKeys: String, CodingKey {
        case dock, batterie
        case wifiEnregistres = "wifi_enregistrees"
        case proprietaire
    }
}

struct DeviceOwnerConfig: Codable {
    let nom: String?
    let initiales: String?
}

struct WifiEntry: Codable {
    let nom: String?
    let lieu: String?
}

struct LpspNotification: Codable, Identifiable {
    var id: String { "\(app)-\(titre)-\(heure)" }
    let app: String
    let titre: String
    let texte: String
    let heure: String
    let lu: Bool?
}

struct LpspScenario: Codable {
    let evenements: [ScenarioEvent]?
}

struct ScenarioEvent: Codable, Identifiable {
    let id: String
    let type: String
    let app: String
    let condition: String
    let contenu: [String: AnyCodable]?
}

struct RuntimeNotification: Identifiable, Equatable {
    let id: String
    let app: String
    let titre: String
    let texte: String
    let heure: String
    var lu: Bool
}

enum PhonePhase: Equatable {
    case menu
    case loading
    case error(String)
    case lock
    case pin
    case home
    case app(String)
}

enum SystemOverlay: Equatable {
    case none
    case notifications
    case controlCenter
}

enum LpspNormalize {
    static func parseLock(_ config: VerrouillageConfig?) -> (requiresPin: Bool, code: String) {
        guard let config else { return (false, "") }
        let type = config.type?.lowercased() ?? ""
        if type.contains("déverrouill") || type.contains("deverrouill") || type == "none" {
            return (false, "")
        }
        let code = config.code ?? ""
        return (!code.isEmpty, code)
    }

    static func appPayload(from apps: [String: AnyCodable], name: String) -> AnyCodable? {
        guard let raw = apps[name] else { return nil }
        guard let obj = raw.objectValue else { return raw }
        if obj["contenu"] != nil && (obj["app"] != nil || obj["profondeur"] != nil) {
            return obj["contenu"]
        }
        return raw
    }
}
