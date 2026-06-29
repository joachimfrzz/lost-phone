import SwiftUI

@main
struct LostPhoneApp: App {
    var body: some Scene {
        WindowGroup {
            PhoneRootView()
                .preferredColorScheme(.dark)
        }
    }
}
