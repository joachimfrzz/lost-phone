import SwiftUI
import SwiftData

// Entrée Lost Phone — UI identique au repo azamsharp/RemindersClone (vendored tel quel).
// Source : https://github.com/azamsharp/RemindersClone

struct RappelsRedditAppView: View {
    var body: some View {
        NavigationStack {
            MyListsScreen()
        }
        .modelContainer(for: MyList.self)
    }
}

struct LpspRappelsView: View {
    let lists: [LpspReminderList]

    var body: some View {
        RappelsRedditAppView()
    }
}
