import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/revolut
// Meliwat/awesome-ios-design-md/finance/revolut/DESIGN-swiftui.md
struct LpspAwesomeBanqueView: View {
    var bankData: LpspBankData?

    var body: some View {
        let storyData = bankData
        LpspBanqueShowroomRoot(
            store: LpspBanqueStore(
                profile: storyData.map { LpspBanqueStore.profile(from: $0) } ?? LpspBanqueShowroomData.profile,
                accounts: storyData.map { LpspBanqueStore.accounts(from: $0) } ?? LpspBanqueShowroomData.accounts,
                transactions: storyData.map { LpspBanqueStore.transactions(from: $0) } ?? LpspBanqueShowroomData.transactions,
                cardSuffix: storyData?.cardPartial.isEmpty == false ? storyData!.cardPartial : LpspBanqueShowroomData.cardSuffix
            ),
            isStoryMode: storyData != nil
        )
    }
}

// MARK: - Tokens & composants

private enum LpspBanqueFonts {
    static let balance     = Font.system(size: 36, weight: .bold)
    static let section     = Font.system(size: 22, weight: .semibold)
    static let rowTitle    = Font.system(size: 16, weight: .semibold)
    static let body        = Font.system(size: 15, weight: .regular)
    static let meta        = Font.system(size: 13, weight: .regular)
    static let tab         = Font.system(size: 10, weight: .regular)
    static let button      = Font.system(size: 16, weight: .semibold)
}

private enum LpspBanqueTokens {
    static let canvas      = Color(red: 0.039, green: 0.039, blue: 0.059)
    static let surface1    = Color(red: 0.086, green: 0.086, blue: 0.122)
    static let surface2    = Color(red: 0.118, green: 0.118, blue: 0.165)
    static let surface3    = Color(red: 0.157, green: 0.157, blue: 0.227)
    static let divider     = Color(red: 0.165, green: 0.165, blue: 0.220)
    static let textSecondary = Color(red: 0.604, green: 0.604, blue: 0.667)
    static let gradStart   = Color(red: 0.357, green: 0.420, blue: 1.000)
    static let gradEnd     = Color(red: 0.612, green: 0.420, blue: 1.000)
    static let brand       = Color(red: 0.420, green: 0.357, blue: 1.000)
    static let income      = Color(red: 0.122, green: 0.820, blue: 0.482)
    static let spend       = Color(red: 1.000, green: 0.353, blue: 0.416)
}

private enum LpspBanqueGradients {
    static let brand = LinearGradient(
        colors: [LpspBanqueTokens.gradStart, LpspBanqueTokens.gradEnd],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

fileprivate struct LpspBanquePressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.85 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

fileprivate struct LpspBanqueQuickAction: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Circle()
                    .fill(LpspBanqueGradients.brand)
                    .frame(width: 52, height: 52)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                    )
                Text(title)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(LpspBanquePressableStyle())
    }
}

fileprivate struct LpspBanqueCurrencyTile: View {
    let account: LpspBanqueShowroomAccount

    var body: some View {
        HStack(spacing: 12) {
            Text(account.flag)
                .font(.system(size: 20))
                .frame(width: 28, height: 28)
                .background(Circle().fill(LpspBanqueTokens.surface2))
            VStack(alignment: .leading, spacing: 2) {
                Text(account.code)
                    .font(LpspBanqueFonts.rowTitle)
                    .foregroundStyle(.white)
                Text(account.name)
                    .font(LpspBanqueFonts.meta)
                    .foregroundStyle(LpspBanqueTokens.textSecondary)
            }
            Spacer()
            Text(account.balanceLabel)
                .font(.system(size: 20, weight: .bold))
                .monospacedDigit()
                .foregroundStyle(.white)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspBanqueTokens.surface1)
                .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(LpspBanqueTokens.divider, lineWidth: 1))
        )
    }
}

fileprivate struct LpspBanqueTransactionRow: View {
    let transaction: LpspBanqueShowroomTransaction

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(transaction.incoming ? LpspBanqueTokens.income.opacity(0.18) : LpspBanqueTokens.surface2)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: transaction.icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(transaction.incoming ? LpspBanqueTokens.income : .white)
                )
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.merchant)
                    .font(LpspBanqueFonts.rowTitle)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Text(transaction.meta)
                    .font(LpspBanqueFonts.meta)
                    .foregroundStyle(LpspBanqueTokens.textSecondary)
                    .lineLimit(1)
            }
            Spacer()
            Text(transaction.amountLabel)
                .font(LpspBanqueFonts.rowTitle)
                .monospacedDigit()
                .foregroundStyle(transaction.incoming ? LpspBanqueTokens.income : .white)
        }
        .padding(.horizontal, 16)
        .frame(height: 64)
    }
}

fileprivate struct LpspBanqueMetalCard: View {
    let suffix: String
    @State private var flipped = false
    @State private var sheen: CGFloat = -1

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.18), Color(white: 0.07)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [.clear, Color.white.opacity(0.18), .clear],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .offset(x: sheen * 260)
                .mask(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading) {
                HStack {
                    Text("Banque")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                    Spacer()
                    Image(systemName: "wave.3.right")
                        .foregroundStyle(.white.opacity(0.8))
                }
                Spacer()
                Text(flipped ? "CVV  ·  042" : "••••  \(suffix)")
                    .font(.system(size: 18, weight: .medium))
                    .monospacedDigit()
                    .foregroundStyle(.white)
                Text("MAYA RIVERA")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.75))
                    .padding(.top, 4)
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .aspectRatio(1.586, contentMode: .fit)
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .shadow(color: .black.opacity(0.5), radius: 24, y: 8)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.45)) { flipped.toggle() }
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: flipped)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2).delay(0.2)) { sheen = 1 }
        }
    }
}

fileprivate struct LpspBanqueSpendDonut: View {
    let total: String
    let progress: Double
    @State private var animated = 0.0

    var body: some View {
        ZStack {
            Circle().stroke(LpspBanqueTokens.surface3, lineWidth: 14)
            Circle()
                .trim(from: 0, to: animated)
                .stroke(
                    AngularGradient(colors: [LpspBanqueTokens.gradStart, LpspBanqueTokens.gradEnd], center: .center),
                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            VStack(spacing: 2) {
                Text(total)
                    .font(LpspBanqueFonts.section)
                    .monospacedDigit()
                    .foregroundStyle(.white)
                Text("ce mois-ci")
                    .font(LpspBanqueFonts.meta)
                    .foregroundStyle(LpspBanqueTokens.textSecondary)
            }
        }
        .frame(width: 180, height: 180)
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 20).fill(LpspBanqueTokens.surface1))
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) { animated = progress }
        }
    }
}

// MARK: - Données & état

fileprivate struct LpspBanqueShowroomProfile {
    let name: String
    let initials: String
    let accent: [Color]
}

fileprivate struct LpspBanqueShowroomAccount: Identifiable, Hashable {
    let id: String
    let flag: String
    let code: String
    let name: String
    let balanceLabel: String
}

fileprivate struct LpspBanqueShowroomTransaction: Identifiable, Hashable {
    let id: String
    let merchant: String
    let meta: String
    let amountLabel: String
    let incoming: Bool
    let icon: String
    let category: String
    let detail: String
}

private enum LpspBanqueSheet: Identifiable {
    case send, exchange, addMoney, transaction(LpspBanqueShowroomTransaction)

    var id: String {
        switch self {
        case .send: "send"
        case .exchange: "exchange"
        case .addMoney: "addMoney"
        case .transaction(let tx): "tx-\(tx.id)"
        }
    }
}

@MainActor
fileprivate final class LpspBanqueStore: ObservableObject {
    @Published var selectedTab: LpspBanqueTab = .home
    @Published var hideBalance = false
    @Published var activeSheet: LpspBanqueSheet?
    @Published var cardFrozen = false

    let profile: LpspBanqueShowroomProfile
    let accounts: [LpspBanqueShowroomAccount]
    let transactions: [LpspBanqueShowroomTransaction]
    let cardSuffix: String
    let totalBalance: String
    let monthlySpend: String
    let spendProgress: Double

    init(
        profile: LpspBanqueShowroomProfile,
        accounts: [LpspBanqueShowroomAccount],
        transactions: [LpspBanqueShowroomTransaction],
        cardSuffix: String,
        totalBalance: String = LpspBanqueShowroomData.totalBalance,
        monthlySpend: String = LpspBanqueShowroomData.monthlySpend,
        spendProgress: Double = LpspBanqueShowroomData.spendProgress
    ) {
        self.profile = profile
        self.accounts = accounts
        self.transactions = transactions
        self.cardSuffix = cardSuffix
        self.totalBalance = totalBalance
        self.monthlySpend = monthlySpend
        self.spendProgress = spendProgress
    }

    static func profile(from data: LpspBankData) -> LpspBanqueShowroomProfile {
        LpspBanqueShowroomProfile(
            name: data.holderName.isEmpty ? LpspBanqueShowroomData.profile.name : data.holderName,
            initials: String((data.holderName.isEmpty ? LpspBanqueShowroomData.profile.name : data.holderName).prefix(1)),
            accent: [Color.orange, Color.pink]
        )
    }

    static func accounts(from data: LpspBankData) -> [LpspBanqueShowroomAccount] {
        data.accounts.enumerated().map { index, account in
            LpspBanqueShowroomAccount(
                id: account.id,
                flag: account.currency == "EUR" ? "🇪🇺" : "💶",
                code: account.currency,
                name: account.type,
                balanceLabel: formatCurrency(account.balance, currency: account.currency)
            )
        }
    }

    static func transactions(from data: LpspBankData) -> [LpspBanqueShowroomTransaction] {
        data.operations.map { op in
            LpspBanqueShowroomTransaction(
                id: op.id,
                merchant: op.label,
                meta: LpspAdapters.formatShortDate(op.date, fallback: op.dateRaw),
                amountLabel: formatSigned(op.amount, currency: "EUR"),
                incoming: op.amount > 0,
                icon: icon(for: op.category),
                category: op.category,
                detail: op.label
            )
        }
    }

    private static func formatCurrency(_ value: Double, currency: String) -> String {
        let symbol = currency == "EUR" ? "€" : currency == "USD" ? "$" : "£"
        return "\(symbol)\(String(format: "%.2f", abs(value)))"
    }

    private static func formatSigned(_ value: Double, currency: String) -> String {
        let prefix = value >= 0 ? "+" : "−"
        return "\(prefix)\(formatCurrency(abs(value), currency: currency))"
    }

    private static func icon(for category: String) -> String {
        let low = category.lowercased()
        if low.contains("transport") { return "car.fill" }
        if low.contains("restaurant") || low.contains("food") { return "fork.knife" }
        if low.contains("shopping") { return "bag.fill" }
        if low.contains("virement") || low.contains("transfer") { return "arrow.left.arrow.right" }
        return "creditcard.fill"
    }
}

private enum LpspBanqueShowroomData {
    static let profile = LpspBanqueShowroomProfile(
        name: "Maya Rivera",
        initials: "M",
        accent: [Color.orange, Color.pink]
    )
    static let totalBalance = "€4 218,37"
    static let monthlySpend = "€1 284,50"
    static let spendProgress = 0.62
    static let cardSuffix = "4242"

    static let accounts: [LpspBanqueShowroomAccount] = [
        .init(id: "eur", flag: "🇪🇺", code: "EUR", name: "Compte courant", balanceLabel: "€3 842,15"),
        .init(id: "livret", flag: "🇪🇺", code: "EUR", name: "Livret A", balanceLabel: "€376,22"),
        .init(id: "usd", flag: "🇺🇸", code: "USD", name: "Voyage", balanceLabel: "$412,00"),
    ]

    static let transactions: [LpspBanqueShowroomTransaction] = [
        .init(id: "t1", merchant: "Musée du Louvre", meta: "Aujourd'hui · Shopping", amountLabel: "−€18,50", incoming: false, icon: "building.columns.fill", category: "Shopping", detail: "Boutique Pyramide"),
        .init(id: "t2", merchant: "Uber", meta: "Hier · Transport", amountLabel: "−€12,40", incoming: false, icon: "car.fill", category: "Transport", detail: "Course Bastille → Louvre"),
        .init(id: "t3", merchant: "Design Guild", meta: "12 juin · Salaire", amountLabel: "+€2 450,00", incoming: true, icon: "arrow.down.circle.fill", category: "Virement", detail: "Paie mensuelle"),
        .init(id: "t4", merchant: "Boot Café", meta: "11 juin · Restaurant", amountLabel: "−€6,80", incoming: false, icon: "cup.and.saucer.fill", category: "Restaurant", detail: "Flat white"),
        .init(id: "t5", merchant: "Spotify", meta: "10 juin · Abonnement", amountLabel: "−€10,99", incoming: false, icon: "music.note", category: "Loisirs", detail: "Premium"),
        .init(id: "t6", merchant: "Jordan P.", meta: "8 juin · Virement", amountLabel: "−€45,00", incoming: false, icon: "paperplane.fill", category: "Virement", detail: "Remboursement tickets"),
    ]
}

// MARK: - Écrans showroom

private enum LpspBanqueTab: CaseIterable {
    case home, invest, crypto, lifestyle, cards

    var label: String {
        switch self {
        case .home: "Accueil"
        case .invest: "Invest"
        case .crypto: "Crypto"
        case .lifestyle: "Lifestyle"
        case .cards: "Cartes"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .invest: "chart.line.uptrend.xyaxis"
        case .crypto: "bitcoinsign.circle.fill"
        case .lifestyle: "sparkles"
        case .cards: "creditcard.fill"
        }
    }
}

private struct LpspBanqueShowroomRoot: View {
    @ObservedObject var store: LpspBanqueStore
    var isStoryMode = false

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspBanqueHomeTabScreen(store: store, isStoryMode: isStoryMode)
                case .invest:
                    LpspBanqueInvestTabScreen(store: store)
                case .crypto:
                    LpspBanqueCryptoTabScreen(store: store)
                case .lifestyle:
                    LpspBanqueLifestyleTabScreen(store: store)
                case .cards:
                    LpspBanqueCardsTabScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspBanqueTabBar(selectedTab: $store.selectedTab)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .sheet(item: $store.activeSheet) { sheet in
            switch sheet {
            case .send:
                LpspBanqueSendSheet()
            case .exchange:
                LpspBanqueExchangeSheet(accounts: store.accounts)
            case .addMoney:
                LpspBanqueAddMoneySheet()
            case .transaction(let tx):
                LpspBanqueTransactionDetailSheet(transaction: tx)
            }
        }
    }
}

private struct LpspBanqueTabBar: View {
    @Binding var selectedTab: LpspBanqueTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspBanqueTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: selectedTab == tab ? .semibold : .regular))
                            .foregroundStyle(selectedTab == tab ? LpspBanqueTokens.brand : LpspBanqueTokens.textSecondary)
                        Text(tab.label)
                            .font(LpspBanqueFonts.tab)
                            .foregroundStyle(selectedTab == tab ? .white : LpspBanqueTokens.textSecondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(LpspBanquePressableStyle())
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspBanqueTokens.surface1)
    }
}

private struct LpspBanqueHomeTabScreen: View {
    @ObservedObject var store: LpspBanqueStore
    var isStoryMode = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                header
                balanceBlock
                quickActions
                promoBanner
                accountsSection
                transactionsSection
            }
            .padding(.bottom, 24)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
    }

    private var header: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(LinearGradient(colors: store.profile.accent, startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 48, height: 48)
                .overlay(Text(store.profile.initials).font(.headline.bold()).foregroundStyle(.white))
            VStack(alignment: .leading, spacing: 2) {
                Text("Bonjour,")
                    .font(LpspBanqueFonts.meta)
                    .foregroundStyle(LpspBanqueTokens.textSecondary)
                Text(store.profile.name)
                    .font(LpspBanqueFonts.rowTitle)
                    .foregroundStyle(.white)
            }
            Spacer()
            Button { store.hideBalance.toggle() } label: {
                Image(systemName: store.hideBalance ? "eye.slash" : "eye")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
            }
            .buttonStyle(LpspBanquePressableStyle())
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var balanceBlock: some View {
        VStack(spacing: 4) {
            Text("Solde total")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(LpspBanqueTokens.textSecondary)
            Text(store.totalBalance)
                .font(LpspBanqueFonts.balance)
                .foregroundStyle(.white)
                .blur(radius: store.hideBalance ? 12 : 0)
        }
        .frame(maxWidth: .infinity)
    }

    private var quickActions: some View {
        HStack(spacing: 0) {
            LpspBanqueQuickAction(icon: "plus", title: "Ajouter") {
                store.activeSheet = .addMoney
            }
            LpspBanqueQuickAction(icon: "arrow.left.arrow.right", title: "Change") {
                store.activeSheet = .exchange
            }
            LpspBanqueQuickAction(icon: "paperplane.fill", title: "Envoyer") {
                store.activeSheet = .send
            }
            LpspBanqueQuickAction(icon: "ellipsis", title: "Plus") {
                store.selectedTab = .lifestyle
            }
        }
        .padding(.horizontal, 8)
    }

    private var promoBanner: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(LpspBanqueGradients.brand)
            .frame(height: 110)
            .overlay(alignment: .leading) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Vaults")
                        .font(LpspBanqueFonts.section)
                        .foregroundStyle(.white)
                    Text("Épargnez pour votre prochain voyage à Paris.")
                        .font(LpspBanqueFonts.meta)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding(18)
            }
            .padding(.horizontal, 16)
    }

    private var accountsSection: some View {
        VStack(spacing: 8) {
            ForEach(store.accounts) { account in
                LpspBanqueCurrencyTile(account: account)
            }
        }
        .padding(.horizontal, 16)
    }

    private var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Activité récente")
                .font(LpspBanqueFonts.section)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ForEach(store.transactions) { tx in
                Button {
                    store.activeSheet = .transaction(tx)
                } label: {
                    LpspBanqueTransactionRow(transaction: tx)
                }
                .buttonStyle(LpspBanquePressableStyle())
            }
        }
    }
}

private struct LpspBanqueInvestTabScreen: View {
    @ObservedObject var store: LpspBanqueStore

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Portefeuille")
                    .font(LpspBanqueFonts.section)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                LpspBanqueSpendDonut(total: store.monthlySpend, progress: store.spendProgress)

                VStack(alignment: .leading, spacing: 12) {
                    investRow("Actions US", "+4,2%", "€1 120,00")
                    investRow("ETF Europe", "+1,8%", "€640,00")
                    investRow("Tech Growth", "−0,6%", "€280,00")
                }
            }
            .padding(16)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
    }

    private func investRow(_ title: String, _ change: String, _ value: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(LpspBanqueFonts.rowTitle).foregroundStyle(.white)
                Text(change)
                    .font(LpspBanqueFonts.meta)
                    .foregroundStyle(change.hasPrefix("+") ? LpspBanqueTokens.income : LpspBanqueTokens.spend)
            }
            Spacer()
            Text(value).font(LpspBanqueFonts.rowTitle).foregroundStyle(.white)
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 16).fill(LpspBanqueTokens.surface1))
    }
}

private struct LpspBanqueCryptoTabScreen: View {
    @ObservedObject var store: LpspBanqueStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Crypto")
                    .font(LpspBanqueFonts.section)
                    .foregroundStyle(.white)
                cryptoRow("Bitcoin", "BTC", "€842,10", "+2,4%")
                cryptoRow("Ethereum", "ETH", "€218,55", "+1,1%")
                cryptoRow("Solana", "SOL", "€64,20", "−0,8%")
            }
            .padding(16)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
    }

    private func cryptoRow(_ name: String, _ code: String, _ value: String, _ change: String) -> some View {
        HStack {
            Circle().fill(LpspBanqueTokens.surface2).frame(width: 40, height: 40)
                .overlay(Text(code.prefix(1)).font(.caption.bold()).foregroundStyle(.white))
            VStack(alignment: .leading, spacing: 2) {
                Text(name).font(LpspBanqueFonts.rowTitle).foregroundStyle(.white)
                Text(change).font(LpspBanqueFonts.meta).foregroundStyle(change.hasPrefix("+") ? LpspBanqueTokens.income : LpspBanqueTokens.spend)
            }
            Spacer()
            Text(value).font(LpspBanqueFonts.rowTitle).foregroundStyle(.white)
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 16).fill(LpspBanqueTokens.surface1))
    }
}

private struct LpspBanqueLifestyleTabScreen: View {
    @ObservedObject var store: LpspBanqueStore

    private let perks = ["Lounge CDG", "eSIM Voyage", "Assurance téléphone", "Cashback Louvre"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text("Lifestyle")
                    .font(LpspBanqueFonts.section)
                    .foregroundStyle(.white)
                ForEach(perks, id: \.self) { perk in
                    HStack {
                        Image(systemName: "sparkles")
                            .foregroundStyle(LpspBanqueTokens.brand)
                        Text(perk)
                            .font(LpspBanqueFonts.body)
                            .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(LpspBanqueTokens.textSecondary)
                    }
                    .padding(14)
                    .background(RoundedRectangle(cornerRadius: 16).fill(LpspBanqueTokens.surface1))
                }
            }
            .padding(16)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
    }
}

private struct LpspBanqueCardsTabScreen: View {
    @ObservedObject var store: LpspBanqueStore

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                LpspBanqueMetalCard(suffix: store.cardSuffix)
                    .padding(.horizontal, 16)
                    .opacity(store.cardFrozen ? 0.45 : 1)

                HStack(spacing: 12) {
                    cardAction("snowflake", store.cardFrozen ? "Dégeler" : "Geler") {
                        store.cardFrozen.toggle()
                    }
                    cardAction("chart.bar", "Limites") { }
                    cardAction("lock", "PIN") { }
                }
                .padding(.horizontal, 16)

                Text(store.cardFrozen ? "Carte gelée" : "Carte active")
                    .font(LpspBanqueFonts.meta)
                    .foregroundStyle(store.cardFrozen ? LpspBanqueTokens.spend : LpspBanqueTokens.income)
            }
            .padding(.vertical, 16)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
    }

    private func cardAction(_ icon: String, _ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon).font(.title3)
                Text(title).font(LpspBanqueFonts.meta)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(RoundedRectangle(cornerRadius: 14).fill(LpspBanqueTokens.surface1))
        }
        .buttonStyle(LpspBanquePressableStyle())
    }
}

// MARK: - Sheets

private struct LpspBanqueSendSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var amount = "45,00"

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ForEach(["Jordan P.", "Alex Chen", "Design Guild"], id: \.self) { contact in
                    HStack {
                        Circle().fill(LpspBanqueTokens.surface2).frame(width: 40, height: 40)
                            .overlay(Text(String(contact.prefix(1))).foregroundStyle(.white))
                        Text(contact).font(LpspBanqueFonts.rowTitle).foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                TextField("Montant", text: $amount)
                    .font(LpspBanqueFonts.section)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(LpspBanqueTokens.surface1))
                Button("Envoyer €\(amount)") { dismiss() }
                    .font(LpspBanqueFonts.button)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 16).fill(LpspBanqueGradients.brand))
                Spacer()
            }
            .padding(16)
            .navigationTitle("Envoyer")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
    }
}

private struct LpspBanqueExchangeSheet: View {
    let accounts: [LpspBanqueShowroomAccount]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Convertir des devises")
                    .font(LpspBanqueFonts.section)
                    .foregroundStyle(.white)
                ForEach(accounts) { account in
                    LpspBanqueCurrencyTile(account: account)
                }
                Button("Convertir €100 → $108") { dismiss() }
                    .font(LpspBanqueFonts.button)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 16).fill(LpspBanqueGradients.brand))
                Spacer()
            }
            .padding(16)
            .navigationTitle("Change")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
        .presentationDetents([.medium, .large])
        .preferredColorScheme(.dark)
    }
}

private struct LpspBanqueAddMoneySheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 14) {
                addOption("Carte bancaire", "creditcard.fill")
                addOption("Virement", "building.columns.fill")
                addOption("Apple Pay", "apple.logo")
                Spacer()
            }
            .padding(16)
            .navigationTitle("Ajouter de l'argent")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
    }

    private func addOption(_ title: String, _ icon: String) -> some View {
        Button { dismiss() } label: {
            HStack(spacing: 12) {
                Image(systemName: icon).font(.title3).foregroundStyle(LpspBanqueTokens.brand)
                Text(title).font(LpspBanqueFonts.rowTitle).foregroundStyle(.white)
                Spacer()
            }
            .padding(14)
            .background(RoundedRectangle(cornerRadius: 14).fill(LpspBanqueTokens.surface1))
        }
        .buttonStyle(LpspBanquePressableStyle())
    }
}

private struct LpspBanqueTransactionDetailSheet: View {
    let transaction: LpspBanqueShowroomTransaction
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Circle()
                        .fill(LpspBanqueTokens.surface2)
                        .frame(width: 56, height: 56)
                        .overlay(Image(systemName: transaction.icon).foregroundStyle(.white))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(transaction.merchant)
                            .font(LpspBanqueFonts.section)
                            .foregroundStyle(.white)
                        Text(transaction.meta)
                            .font(LpspBanqueFonts.meta)
                            .foregroundStyle(LpspBanqueTokens.textSecondary)
                    }
                }
                Text(transaction.amountLabel)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(transaction.incoming ? LpspBanqueTokens.income : .white)
                Text(transaction.detail)
                    .font(LpspBanqueFonts.body)
                    .foregroundStyle(.white)
                Text("Catégorie : \(transaction.category)")
                    .font(LpspBanqueFonts.meta)
                    .foregroundStyle(LpspBanqueTokens.textSecondary)
                Spacer()
            }
            .padding(16)
            .navigationTitle("Détail")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspBanqueTokens.canvas.ignoresSafeArea())
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
    }
}
