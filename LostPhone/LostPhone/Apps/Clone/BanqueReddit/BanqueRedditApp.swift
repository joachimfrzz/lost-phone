import SwiftUI

// Entrée Lost Phone — UI identique au repo GeraudLuku/YT-BankingApp (vendored tel quel).
// Source : https://github.com/GeraudLuku/YT-BankingApp

struct BanqueRedditAppView: View {
    var body: some View {
        BanqueRedditContentView()
    }
}

struct LpspBanqueView: View {
    let data: LpspBankData?

    var body: some View {
        BanqueRedditAppView()
    }
}
