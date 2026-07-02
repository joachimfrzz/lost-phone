import SwiftUI

// Entrée Lost Phone — UI identique au repo aisultanios/MyPlaylists (vendored tel quel).
// Source : https://github.com/aisultanios/MyPlaylists

struct MyPlaylistsRedditAppView: View {
    var body: some View {
        TabBar()
    }
}

struct LpspAppleMusicView: View {
    let data: LpspAppleMusicData?

    var body: some View {
        MyPlaylistsRedditAppView()
    }
}
