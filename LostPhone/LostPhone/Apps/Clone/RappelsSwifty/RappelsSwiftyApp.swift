import SwiftUI

// Entrée Lost Phone — UI vendored amanbind007/Swifty-Reminder-App-iOS
struct RappelsSwiftyAppView: View {
    var body: some View {
        SwiftyRappelsHomeView()
            .environment(\.managedObjectContext, SwiftyRappelsCoreDataProvider.shared.persistentContainer.viewContext)
    }
}

struct LpspRappelsView: View {
    let lists: [LpspReminderList]

    var body: some View {
        RappelsSwiftyAppView()
    }
}
