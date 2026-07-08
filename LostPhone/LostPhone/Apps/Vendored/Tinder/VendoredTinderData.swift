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

struct VendoredTinderProfile: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let age: String
    let likes: [String]
    let active: Bool
}

enum VendoredTinderData {
    static let explore: [VendoredTinderProfile] = [
        .init(imageName: "img_1", name: "Ayo", age: "20", likes: ["Dancing", "Cooking", "Art"], active: true),
        .init(imageName: "img_2", name: "Rondeau", age: "18", likes: ["Instagram", "Cooking"], active: true),
        .init(imageName: "img_3", name: "Valerie", age: "22", likes: ["Instagram", "Netflix", "Comedy"], active: true),
        .init(imageName: "img_4", name: "Mary", age: "22", likes: ["Travel", "Fashion", "Reading"], active: false),
        .init(imageName: "img_5", name: "Angie", age: "18", likes: ["Model", "Fashion", "Working Out"], active: true),
        .init(imageName: "img_6", name: "Anne", age: "19", likes: ["Shopping", "Travel", "Cat lover"], active: false),
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
}

struct VendoredTinderBundledPhoto: View {
    let imageName: String

    var body: some View {
        Group {
            if let ui = loadImage() {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray.opacity(0.25)
            }
        }
    }

    private func loadImage() -> UIImage? {
        if let path = Bundle.main.path(forResource: imageName, ofType: "jpeg", inDirectory: "girls"),
           let ui = UIImage(contentsOfFile: path) {
            return ui
        }
        return nil
    }
}
