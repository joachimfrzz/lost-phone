import SwiftUI

enum VendoredTinderTheme {
    static let primary = Color(hex: "#FD5C61")
    static let primaryGradient = LinearGradient(
        colors: [Color(hex: "#FC3973"), Color(hex: "#FD5F60")],
        startPoint: .leading,
        endPoint: .trailing
    )
    static let goldGradient = LinearGradient(
        colors: [Color(hex: "#EEC365"), Color(hex: "#DE9024")],
        startPoint: .leading,
        endPoint: .trailing
    )
    static let likeGreen = Color.green
}

struct VendoredTinderProfile: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
    let name: String
    let age: String
    let likes: [String]
    let active: Bool
    var previewMessage: String = ""
    var previewTime: String = ""
}

struct VendoredTinderChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isMine: Bool
}

enum VendoredTinderData {
    static let explore: [VendoredTinderProfile] = [
        .init(imageName: "img_1", name: "Ayo", age: "20", likes: ["Dancing", "Cooking", "Art"], active: true, previewMessage: "How are you doing?", previewTime: "1:00 pm"),
        .init(imageName: "img_2", name: "Rondeau", age: "18", likes: ["Instagram", "Cooking"], active: true, previewMessage: "Long time no see!!", previewTime: "12:00 am"),
        .init(imageName: "img_3", name: "Valerie", age: "22", likes: ["Instagram", "Netflix", "Comedy"], active: true, previewMessage: "Glad to know you in person!", previewTime: "3:30 pm"),
        .init(imageName: "img_4", name: "Mary", age: "22", likes: ["Travel", "Fashion", "Reading"], active: false, previewMessage: "I'm doing fine and how about you?", previewTime: "9:00 am"),
        .init(imageName: "img_5", name: "Angie", age: "18", likes: ["Model", "Fashion", "Working Out"], active: true, previewMessage: "What is your real name?", previewTime: "11:25 am"),
        .init(imageName: "img_6", name: "Anne", age: "19", likes: ["Shopping", "Travel", "Cat lover"], active: false, previewMessage: "I'm happy to be your friend", previewTime: "2:15 pm"),
        .init(imageName: "img_7", name: "Fineas", age: "20", likes: ["Model", "Nature", "Instagram"], active: true),
        .init(imageName: "img_8", name: "Atikh", age: "18", likes: ["Cooking", "Art", "Working Out"], active: true),
        .init(imageName: "img_9", name: "Campbell", age: "18", likes: ["Swimming", "Working Out"], active: false),
        .init(imageName: "img_10", name: "Maya", age: "19", likes: ["Swag", "Dancing"], active: false),
    ]

    static let likesGrid: [VendoredTinderProfile] = [
        .init(imageName: "img_11", name: "", age: "", likes: [], active: true),
        .init(imageName: "img_12", name: "", age: "", likes: [], active: false),
        .init(imageName: "img_13", name: "", age: "", likes: [], active: false),
        .init(imageName: "img_14", name: "", age: "", likes: [], active: true),
        .init(imageName: "img_15", name: "", age: "", likes: [], active: true),
        .init(imageName: "img_16", name: "", age: "", likes: [], active: true),
    ]

    static let account = VendoredTinderProfile(
        imageName: "img_1", name: "Sophia", age: "27", likes: [], active: true
    )

    static func thread(for profile: VendoredTinderProfile) -> [VendoredTinderChatMessage] {
        [
            .init(text: "Hey \(profile.name)! 👋", isMine: true),
            .init(text: profile.previewMessage.isEmpty ? "Nice to match with you!" : profile.previewMessage, isMine: false),
            .init(text: "Want to grab coffee this week?", isMine: true),
        ]
    }
}

struct VendoredTinderBundledPhoto: View {
    let imageName: String

    var body: some View {
        Group {
            if let ui = VendoredTinderImageLoader.uiImage(named: imageName) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray.opacity(0.25)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white.opacity(0.5))
                    }
            }
        }
    }
}

enum VendoredTinderImageLoader {
    static func uiImage(named imageName: String) -> UIImage? {
        let candidates = [
            ("jpeg", "girls"),
            ("jpeg", nil as String?),
            ("jpg", "girls"),
            ("jpg", nil as String?),
        ]
        for (ext, dir) in candidates {
            if let dir {
                if let path = Bundle.main.path(forResource: imageName, ofType: ext, inDirectory: dir),
                   let ui = UIImage(contentsOfFile: path) {
                    return ui
                }
            } else if let path = Bundle.main.path(forResource: imageName, ofType: ext),
                      let ui = UIImage(contentsOfFile: path) {
                return ui
            }
        }
        return UIImage(named: imageName)
    }
}
