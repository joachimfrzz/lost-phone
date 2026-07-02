import SwiftUI

// Entrée Lost Phone — UI identique au repo NDCSwift/InstagramRecreation2 (vendored tel quel).
// Source : https://github.com/NDCSwift/InstagramRecreation2

struct InstagramRedditAppView: View {
    var body: some View {
        InstagramRedditContentView()
    }
}

struct LpspInstagramView: View {
    let profile: LpspInstagramProfile?

    var body: some View {
        InstagramRedditAppView()
    }
}
