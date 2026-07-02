import SwiftUI

// Entrée Lost Phone — UI identique au repo debuging-life/netflix-clone (vendored tel quel).
// Source : https://github.com/debuging-life/netflix-clone

struct NetflixRedditAppView: View {
    var body: some View {
        NetflixRedditContentView()
    }
}

struct LpspNetflixView: View {
    let data: LpspNetflixData?

    var body: some View {
        NetflixRedditAppView()
    }
}
