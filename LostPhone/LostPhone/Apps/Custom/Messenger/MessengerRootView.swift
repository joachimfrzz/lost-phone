import SwiftUI

/// Point d'entrée Lost Phone — Messenger Custom (brief Studio P0).
struct LpspCustomMessengerRootView: View {
    var body: some View {
        MessengerRootView()
    }
}

struct MessengerRootView: View {
    var body: some View {
        MessengerChatListView()
    }
}

#Preview {
    LpspCustomMessengerRootView()
}
