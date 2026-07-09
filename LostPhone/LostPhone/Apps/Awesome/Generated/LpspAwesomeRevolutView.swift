import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/revolut
// Meliwat/awesome-ios-design-md/finance/revolut/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeRevolutView: View {
    var body: some View {
        LpspRevolutShowroomRoot(store: LpspRevolutStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspRevolutFonts {
    static let revBalance     = Font.system(size: 40, weight: .regular)
    static let revTitleLarge  = Font.system(size: 28, weight: .regular)
    static let revSection     = Font.system(size: 22, weight: .regular)
    static let revTileBalance = Font.system(size: 22, weight: .regular)
    static let revSubsection  = Font.system(size: 18, weight: .regular)
    static let revAmount      = Font.system(size: 16, weight: .regular)
    static let revMerchant    = Font.system(size: 16, weight: .regular)
    static let revBody        = Font.system(size: 15, weight: .regular)
    static let revButton      = Font.system(size: 16, weight: .regular)
    static let revMeta        = Font.system(size: 13, weight: .regular)
    static let revLabelUpper  = Font.system(size: 11, weight: .regular)
    static let revTab         = Font.system(size: 10, weight: .regular)
    static let revCaption     = Font.system(size: 11, weight: .regular)
    static func rev(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspRevolutTokens {
    // MARK: - Canvas & Surfaces
    static let revCanvas   = Color(red: 0.039, green: 0.039, blue: 0.059) // #0A0A0F
    static let revSurface1 = Color(red: 0.086, green: 0.086, blue: 0.122) // #16161F
    static let revSurface2 = Color(red: 0.118, green: 0.118, blue: 0.165) // #1E1E2A
    static let revSurface3 = Color(red: 0.157, green: 0.157, blue: 0.227) // #28283A
    static let revDivider  = Color(red: 0.165, green: 0.165, blue: 0.220) // #2A2A38
    static let revBorder   = Color(red: 0.200, green: 0.200, blue: 0.290) // #33334A

    // MARK: - Text
    static let revTextPrimary   = Color.white                                  // #FFFFFF
    static let revTextSecondary = Color(red: 0.604, green: 0.604, blue: 0.667) // #9A9AAA
    static let revTextTertiary  = Color(red: 0.416, green: 0.416, blue: 0.494) // #6A6A7E

    // MARK: - Brand
    static let revGradStart = Color(red: 0.357, green: 0.420, blue: 1.000) // #5B6BFF
    static let revGradEnd   = Color(red: 0.612, green: 0.420, blue: 1.000) // #9C6BFF
    static let revBrand     = Color(red: 0.420, green: 0.357, blue: 1.000) // #6B5BFF
    static let revBrandPressed = Color(red: 0.337, green: 0.282, blue: 0.839) // #5648D6
    static let revBrandTint = Color(red: 0.110, green: 0.106, blue: 0.200) // #1C1B33

    // MARK: - Semantic
    static let revIncome = Color(red: 0.122, green: 0.820, blue: 0.482) // #1FD17B
    static let revSpend  = Color(red: 1.000, green: 0.353, blue: 0.416) // #FF5A6A
    static let revWarn   = Color(red: 1.000, green: 0.698, blue: 0.247) // #FFB23F
    static let revCrypto = Color(red: 0.969, green: 0.788, blue: 0.282) // #F7C948
}

private enum LpspRevolutGradients {
    static let revBrand = LinearGradient(
        colors: [LpspRevolutTokens.revGradStart, LpspRevolutTokens.revGradEnd],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}





fileprivate struct LpspRevolutRevPrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspRevolutFonts.revButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(LpspRevolutGradients.revBrand, in: RoundedRectangle(cornerRadius: 16))
                .shadow(color: LpspRevolutTokens.revBrand.opacity(0.30), radius: 14, y: 8)
        }
        .sensoryFeedback(.impact(weight: .light), trigger: UUID())
        .buttonStyle(LpspRevolutRevPressableStyle())
    }
}

fileprivate struct LpspRevolutRevPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.85 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

fileprivate struct LpspRevolutRevSecondaryButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspRevolutFonts.revButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(LpspRevolutTokens.revSurface2, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(LpspRevolutRevPressableStyle())
    }
}

fileprivate struct LpspRevolutCurrencyTile: View {
    let flag: String      // emoji or asset
    let code: String
    let name: String
    let balance: String

    var body: some View {
        HStack(spacing: 12) {
            Text(flag)
                .font(.system(size: 20))
                .frame(width: 28, height: 28)
                .background(Circle().fill(LpspRevolutTokens.revSurface2))
            VStack(alignment: .leading, spacing: 2) {
                Text(code).font(LpspRevolutFonts.revMerchant).foregroundStyle(.white)
                Text(name).font(LpspRevolutFonts.revMeta).foregroundStyle(LpspRevolutTokens.revTextSecondary)
            }
            Spacer()
            Text(balance)
                .font(LpspRevolutFonts.revTileBalance)
                .monospacedDigit()
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspRevolutTokens.revSurface1)
                .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(LpspRevolutTokens.revDivider, lineWidth: 1))
        )
    }
}

fileprivate struct LpspRevolutTransactionRow: View {
    let merchant: String
    let meta: String
    let amount: String
    let incoming: Bool
    let logo: Image

    var body: some View {
        HStack(spacing: 12) {
            logo
                .resizable().aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 2) {
                Text(merchant).font(LpspRevolutFonts.revMerchant).foregroundStyle(.white).lineLimit(1)
                Text(meta).font(LpspRevolutFonts.revMeta).foregroundStyle(LpspRevolutTokens.revTextSecondary).lineLimit(1)
            }
            Spacer()
            Text(amount)
                .font(LpspRevolutFonts.revAmount)
                .monospacedDigit()
                .foregroundStyle(incoming ? LpspRevolutTokens.revIncome : .white)
        }
        .padding(.horizontal, 16)
        .frame(height: 64)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspRevolutSpendDonut: View {
    let total: String
    let progress: Double // 0...1
    @State private var animated: Double = 0

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle().stroke(LpspRevolutTokens.revSurface3, lineWidth: 14)
                Circle()
                    .trim(from: 0, to: animated)
                    .stroke(
                        AngularGradient(colors: [LpspRevolutTokens.revGradStart, LpspRevolutTokens.revGradEnd], center: .center),
                        style: StrokeStyle(lineWidth: 14, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                VStack(spacing: 2) {
                    Text(total).font(LpspRevolutFonts.revSection).monospacedDigit().foregroundStyle(.white)
                    Text("this month").font(LpspRevolutFonts.revMeta).foregroundStyle(LpspRevolutTokens.revTextSecondary)
                }
            }
            .frame(width: 180, height: 180)
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 20).fill(LpspRevolutTokens.revSurface1))
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) { animated = progress }
        }
    }
}

fileprivate struct LpspRevolutMetalCardHero: View {
    @Binding var flipped: Bool
    var frozen = false
    @State private var sheen: CGFloat = -1

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(colors: [Color(white: 0.18), Color(white: 0.07)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(colors: [.clear, Color.white.opacity(0.18), .clear],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .offset(x: sheen * 260)
                .mask(RoundedRectangle(cornerRadius: 16))

            if frozen {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black.opacity(0.45))
                VStack(spacing: 8) {
                    Image(systemName: "snowflake")
                        .font(.system(size: 28, weight: .semibold))
                    Text("Card frozen")
                        .font(LpspRevolutFonts.revMeta)
                }
                .foregroundStyle(.white.opacity(0.9))
            }

            VStack(alignment: .leading) {
                Text("Revolut").font(LpspRevolutFonts.revSubsection).foregroundStyle(.white.opacity(0.9))
                Spacer()
                HStack {
                    Text(flipped ? "CVV 042" : "•••• 4821")
                        .font(LpspRevolutFonts.revAmount).monospacedDigit().foregroundStyle(.white)
                    Spacer()
                    if !flipped {
                        Image(systemName: "wave.3.right")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.75))
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .opacity(frozen ? 0.35 : 1)
        }
        .aspectRatio(1.586, contentMode: .fit)
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .shadow(color: .black.opacity(0.5), radius: 24, y: 8)
        .onTapGesture {
            guard !frozen else { return }
            withAnimation(.easeInOut(duration: 0.45)) { flipped.toggle() }
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: flipped)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2).delay(0.2)) { sheen = 1 }
        }
    }
}

fileprivate extension View {
    /// Apply the brand gradient as a foreground (e.g., active icon tint).
    func revGradientForeground() -> some View {
        self.overlay(LpspRevolutGradients.revBrand).mask(self)
    }
}

// Glow modifier for active / primary elements
fileprivate struct LpspRevolutRevGlow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: LpspRevolutTokens.revBrand.opacity(0.30), radius: 14, y: 8)
    }
}


fileprivate struct LpspRevolutBalanceReveal: ViewModifier {
    let hidden: Bool
    func body(content: Content) -> some View {
        content.blur(radius: hidden ? 12 : 0)
            .animation(.easeInOut(duration: 0.25), value: hidden)
    }
}

// Segmented thumb — matchedGeometryEffect on a gradient capsule, 0.22s ease

// MARK: - Showroom data & store

private enum LpspRevolutShowroomTab: String, CaseIterable, Identifiable {
    case home, invest, crypto, lifestyle, cards

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .invest: "Invest"
        case .crypto: "Crypto"
        case .lifestyle: "Lifestyle"
        case .cards: "Cards"
        }
    }

    var systemImage: String {
        switch self {
        case .home: "house.fill"
        case .invest: "chart.line.uptrend.xyaxis"
        case .crypto: "bitcoinsign.circle.fill"
        case .lifestyle: "sparkles"
        case .cards: "creditcard.fill"
        }
    }
}

private enum LpspRevolutQuickAction: String, Identifiable {
    case add, exchange, send, more

    var id: String { rawValue }

    var title: String {
        switch self {
        case .add: "Add money"
        case .exchange: "Exchange"
        case .send: "Send"
        case .more: "More"
        }
    }

    var label: String {
        switch self {
        case .add: "Add"
        case .exchange: "Exchange"
        case .send: "Send"
        case .more: "More"
        }
    }

    var systemImage: String {
        switch self {
        case .add: "plus"
        case .exchange: "arrow.left.arrow.right"
        case .send: "paperplane.fill"
        case .more: "ellipsis"
        }
    }

    var isPrimary: Bool { self == .add }
}

private struct LpspRevolutCurrencyAccount: Identifiable, Equatable {
    let id: String
    let flag: String
    let code: String
    let name: String
    let balance: String
}

private struct LpspRevolutTransaction: Identifiable, Equatable {
    let id: String
    let merchant: String
    let meta: String
    let amount: String
    let incoming: Bool
    let icon: String
}

private struct LpspRevolutCryptoHolding: Identifiable {
    let id: String
    let symbol: String
    let name: String
    let value: String
    let change: String
    let positive: Bool
}

private enum LpspRevolutShowroomData {
    static let userName = "Alex Mercer"
    static let totalBalance = "£12,480.65"
    static let spendTotal = "£2,840"
    static let spendProgress = 0.65

    static let accounts: [LpspRevolutCurrencyAccount] = [
        .init(id: "GBP", flag: "🇬🇧", code: "GBP", name: "British Pound", balance: "£8,240.10"),
        .init(id: "EUR", flag: "🇪🇺", code: "EUR", name: "Euro", balance: "€3,180.55"),
        .init(id: "USD", flag: "🇺🇸", code: "USD", name: "US Dollar", balance: "$1,060.00"),
    ]

    static let transactions: [LpspRevolutTransaction] = [
        .init(id: "tx1", merchant: "Starbucks", meta: "Today · Food & Drink", amount: "-£4.20", incoming: false, icon: "cup.and.saucer.fill"),
        .init(id: "tx2", merchant: "Salary", meta: "Yesterday · Incoming", amount: "+£2,400.00", incoming: true, icon: "arrow.down.circle.fill"),
        .init(id: "tx3", merchant: "TfL", meta: "Mon · Transport", amount: "-£6.40", incoming: false, icon: "tram.fill"),
    ]

    static let cryptoHoldings: [LpspRevolutCryptoHolding] = [
        .init(id: "btc", symbol: "BTC", name: "Bitcoin", value: "£4,820.00", change: "+2.4%", positive: true),
        .init(id: "eth", symbol: "ETH", name: "Ethereum", value: "£1,240.50", change: "-0.8%", positive: false),
    ]

    static let lifestylePerks = [
        ("Lounge access", "2 visits left this month"),
        ("Cashback", "£18.40 earned in June"),
        ("Stays", "15% off boutique hotels"),
    ]
}

@MainActor
fileprivate final class LpspRevolutStore: ObservableObject {
    @Published var selectedTab: LpspRevolutShowroomTab = .home
    @Published var balanceHidden = false
    @Published var selectedAccountId = "GBP"
    @Published var cardFlipped = false
    @Published var cardFrozen = false
    @Published var activeQuickAction: LpspRevolutQuickAction?
    @Published var accounts = LpspRevolutShowroomData.accounts
    @Published var transactions = LpspRevolutShowroomData.transactions
    @Published var addAmount = "£100"

    func toggleBalanceHidden() {
        balanceHidden.toggle()
    }

    func selectAccount(_ id: String) {
        selectedAccountId = id
    }

    func toggleCardFrozen() {
        cardFrozen.toggle()
        if cardFrozen { cardFlipped = false }
    }

    func openQuickAction(_ action: LpspRevolutQuickAction) {
        activeQuickAction = action
    }

    func dismissQuickAction() {
        activeQuickAction = nil
    }

    func addMoney() {
        let tx = LpspRevolutTransaction(
            id: "topup-\(transactions.count + 1)",
            merchant: "Top up",
            meta: "Just now · Added",
            amount: addAmount,
            incoming: true,
            icon: "plus.circle.fill"
        )
        transactions.insert(tx, at: 0)
        activeQuickAction = nil
    }

    func sendPayment() {
        let tx = LpspRevolutTransaction(
            id: "send-\(transactions.count + 1)",
            merchant: "Jamie Cole",
            meta: "Just now · Sent",
            amount: "-£25.00",
            incoming: false,
            icon: "paperplane.fill"
        )
        transactions.insert(tx, at: 0)
        activeQuickAction = nil
    }

    func exchangeCurrency() {
        accounts = accounts.map { account in
            guard account.id == "GBP" else { return account }
            return LpspRevolutCurrencyAccount(
                id: account.id,
                flag: account.flag,
                code: account.code,
                name: account.name,
                balance: "£8,190.10"
            )
        }
        accounts = accounts.map { account in
            guard account.id == "EUR" else { return account }
            return LpspRevolutCurrencyAccount(
                id: account.id,
                flag: account.flag,
                code: account.code,
                name: account.name,
                balance: "€3,230.55"
            )
        }
        selectedAccountId = "EUR"
        activeQuickAction = nil
    }
}

// MARK: - Écrans showroom

private struct LpspRevolutShowroomRoot: View {
    @ObservedObject var store: LpspRevolutStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspRevolutShowroomTab.allCases) { tab in
                LpspRevolutShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .tint(LpspRevolutTokens.revBrand)
        .preferredColorScheme(.dark)
        .sheet(item: $store.activeQuickAction) { action in
            LpspRevolutQuickActionSheet(store: store, action: action)
        }
    }
}

private struct LpspRevolutShowroomTabScreen: View {
    @ObservedObject var store: LpspRevolutStore
    let tab: LpspRevolutShowroomTab

    var body: some View {
        Group {
            switch tab {
            case .home:
                LpspRevolutHomeTabScreen(store: store)
            case .invest:
                LpspRevolutInvestTabScreen(store: store)
            case .crypto:
                LpspRevolutCryptoTabScreen()
            case .lifestyle:
                LpspRevolutLifestyleTabScreen()
            case .cards:
                LpspRevolutCardsTabScreen(store: store)
            }
        }
    }
}

private struct LpspRevolutHomeTabScreen: View {
    @ObservedObject var store: LpspRevolutStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LpspRevolutTopBar(userName: LpspRevolutShowroomData.userName)

                Button {
                    store.toggleBalanceHidden()
                } label: {
                    VStack(spacing: 4) {
                        Text("Total balance")
                            .font(LpspRevolutFonts.revLabelUpper.weight(.bold))
                            .foregroundStyle(LpspRevolutTokens.revTextSecondary)
                        Text(LpspRevolutShowroomData.totalBalance)
                            .font(LpspRevolutFonts.revBalance.weight(.bold))
                            .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                            .modifier(LpspRevolutBalanceReveal(hidden: store.balanceHidden))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                }
                .buttonStyle(.plain)

                LpspRevolutQuickActionRow { action in
                    store.openQuickAction(action)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 16)

                LpspRevolutMetalCardHero(flipped: $store.cardFlipped, frozen: store.cardFrozen)
                    .padding(.horizontal, 16)

                VStack(spacing: 8) {
                    ForEach(store.accounts) { account in
                        Button {
                            store.selectAccount(account.id)
                        } label: {
                            LpspRevolutCurrencyTile(
                                flag: account.flag,
                                code: account.code,
                                name: account.name,
                                balance: account.balance
                            )
                            .overlay {
                                if store.selectedAccountId == account.id {
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(LpspRevolutGradients.revBrand, lineWidth: 2)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
        }
        .background(LpspRevolutTokens.revCanvas.ignoresSafeArea())
    }
}

private struct LpspRevolutTopBar: View {
    let userName: String

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 48, height: 48)

            Text(userName)
                .font(LpspRevolutFonts.revBody.weight(.semibold))
                .foregroundStyle(LpspRevolutTokens.revTextPrimary)

            Spacer()

            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                .frame(width: 36, height: 36)

            Image(systemName: "bell")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                .frame(width: 36, height: 36)
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
}

private struct LpspRevolutQuickActionRow: View {
    let onAction: (LpspRevolutQuickAction) -> Void

    private let actions: [LpspRevolutQuickAction] = [.add, .exchange, .send, .more]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(actions) { action in
                Button {
                    onAction(action)
                } label: {
                    VStack(spacing: 6) {
                        Group {
                            if action.isPrimary {
                                Circle()
                                    .fill(LpspRevolutGradients.revBrand)
                            } else {
                                Circle()
                                    .fill(LpspRevolutTokens.revSurface2)
                            }
                        }
                        .frame(width: 52, height: 52)
                        .overlay {
                            Image(systemName: action.systemImage)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                        Text(action.label)
                            .font(LpspRevolutFonts.revCaption)
                            .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

private struct LpspRevolutQuickActionSheet: View {
    @ObservedObject var store: LpspRevolutStore
    let action: LpspRevolutQuickAction
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                switch action {
                case .add:
                    Text("Add money to your account")
                        .font(LpspRevolutFonts.revBody)
                        .foregroundStyle(LpspRevolutTokens.revTextSecondary)
                    Text(store.addAmount)
                        .font(LpspRevolutFonts.revTitleLarge.weight(.bold))
                        .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                    LpspRevolutRevPrimaryButton(title: "Confirm top up") {
                        store.addMoney()
                        dismiss()
                    }
                    .padding(.horizontal, 16)
                case .exchange:
                    Text("Convert £50.00 to EUR")
                        .font(LpspRevolutFonts.revBody)
                        .foregroundStyle(LpspRevolutTokens.revTextSecondary)
                    LpspRevolutRevPrimaryButton(title: "Exchange now") {
                        store.exchangeCurrency()
                        dismiss()
                    }
                    .padding(.horizontal, 16)
                case .send:
                    Text("Send to Jamie Cole")
                        .font(LpspRevolutFonts.revBody)
                        .foregroundStyle(LpspRevolutTokens.revTextSecondary)
                    LpspRevolutRevPrimaryButton(title: "Send £25.00") {
                        store.sendPayment()
                        dismiss()
                    }
                    .padding(.horizontal, 16)
                case .more:
                    VStack(spacing: 12) {
                        LpspRevolutRevSecondaryButton(title: "Request money") { dismiss() }
                        LpspRevolutRevSecondaryButton(title: "Split bill") { dismiss() }
                        LpspRevolutRevSecondaryButton(title: "View statements") { dismiss() }
                    }
                    .padding(.horizontal, 16)
                }
                Spacer()
            }
            .padding(.top, 24)
            .background(LpspRevolutTokens.revCanvas.ignoresSafeArea())
            .navigationTitle(action.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        store.dismissQuickAction()
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
    }
}

private struct LpspRevolutInvestTabScreen: View {
    @ObservedObject var store: LpspRevolutStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    LpspRevolutSpendDonut(
                        total: LpspRevolutShowroomData.spendTotal,
                        progress: LpspRevolutShowroomData.spendProgress
                    )

                    Text("Recent activity")
                        .font(LpspRevolutFonts.revSection)
                        .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                        .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        ForEach(store.transactions) { tx in
                            LpspRevolutTransactionRow(
                                merchant: tx.merchant,
                                meta: tx.meta,
                                amount: tx.amount,
                                incoming: tx.incoming,
                                logo: Image(systemName: tx.icon)
                            )
                        }
                    }
                }
                .padding(.vertical)
            }
            .background(LpspRevolutTokens.revCanvas.ignoresSafeArea())
            .navigationTitle("Invest")
        }
    }
}

private struct LpspRevolutCryptoTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(LpspRevolutShowroomData.cryptoHoldings) { holding in
                        HStack(spacing: 12) {
                            Circle()
                                .fill(LpspRevolutTokens.revBrandTint)
                                .frame(width: 44, height: 44)
                                .overlay {
                                    Text(holding.symbol.prefix(1))
                                        .font(LpspRevolutFonts.revMerchant.weight(.bold))
                                        .foregroundStyle(LpspRevolutTokens.revCrypto)
                                }
                            VStack(alignment: .leading, spacing: 2) {
                                Text(holding.name)
                                    .font(LpspRevolutFonts.revMerchant)
                                    .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                                Text(holding.symbol)
                                    .font(LpspRevolutFonts.revMeta)
                                    .foregroundStyle(LpspRevolutTokens.revTextSecondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 2) {
                                Text(holding.value)
                                    .font(LpspRevolutFonts.revAmount)
                                    .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                                Text(holding.change)
                                    .font(LpspRevolutFonts.revMeta)
                                    .foregroundStyle(holding.positive ? LpspRevolutTokens.revIncome : LpspRevolutTokens.revSpend)
                            }
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LpspRevolutTokens.revSurface1)
                        )
                    }
                }
                .padding(16)
            }
            .background(LpspRevolutTokens.revCanvas.ignoresSafeArea())
            .navigationTitle("Crypto")
        }
    }
}

private struct LpspRevolutLifestyleTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(LpspRevolutShowroomData.lifestylePerks, id: \.0) { title, subtitle in
                        HStack(spacing: 12) {
                            Circle()
                                .fill(LpspRevolutGradients.revBrand)
                                .frame(width: 44, height: 44)
                                .overlay {
                                    Image(systemName: "sparkles")
                                        .foregroundStyle(.white)
                                }
                            VStack(alignment: .leading, spacing: 2) {
                                Text(title)
                                    .font(LpspRevolutFonts.revMerchant)
                                    .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                                Text(subtitle)
                                    .font(LpspRevolutFonts.revMeta)
                                    .foregroundStyle(LpspRevolutTokens.revTextSecondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(LpspRevolutTokens.revTextTertiary)
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LpspRevolutTokens.revSurface1)
                        )
                    }
                }
                .padding(16)
            }
            .background(LpspRevolutTokens.revCanvas.ignoresSafeArea())
            .navigationTitle("Lifestyle")
        }
    }
}

private struct LpspRevolutCardsTabScreen: View {
    @ObservedObject var store: LpspRevolutStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    LpspRevolutMetalCardHero(flipped: $store.cardFlipped, frozen: store.cardFrozen)
                        .padding(.horizontal, 16)

                    Toggle(isOn: Binding(
                        get: { store.cardFrozen },
                        set: { _ in store.toggleCardFrozen() }
                    )) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Freeze card")
                                .font(LpspRevolutFonts.revMerchant)
                                .foregroundStyle(LpspRevolutTokens.revTextPrimary)
                            Text("Temporarily disable payments")
                                .font(LpspRevolutFonts.revMeta)
                                .foregroundStyle(LpspRevolutTokens.revTextSecondary)
                        }
                    }
                    .tint(LpspRevolutTokens.revBrand)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LpspRevolutTokens.revSurface1)
                    )
                    .padding(.horizontal, 16)

                    Text("Tap the card to reveal CVV")
                        .font(LpspRevolutFonts.revMeta)
                        .foregroundStyle(LpspRevolutTokens.revTextSecondary)
                }
                .padding(.vertical, 24)
            }
            .background(LpspRevolutTokens.revCanvas.ignoresSafeArea())
            .navigationTitle("Cards")
        }
    }
}

