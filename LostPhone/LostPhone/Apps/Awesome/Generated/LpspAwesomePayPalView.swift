import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/finance/paypal/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/paypal
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomePayPalView: View {
    var body: some View {
        LpspPayPalShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspPayPalFonts {
    static let ppBalanceHero    = Font.system(size: 36, weight: .regular)
    static let ppSendAmountHero = Font.system(size: 56, weight: .regular)
    static let ppScreenTitle    = Font.system(size: 24, weight: .regular)
    static let ppSectionHeader  = Font.system(size: 18, weight: .regular)
    static let ppCardTitle      = Font.system(size: 16, weight: .regular)
    static let ppActivityAmount = Font.system(size: 16, weight: .regular)
    static let ppBody           = Font.system(size: 16, weight: .regular)
    static let ppBodySmall      = Font.system(size: 14, weight: .regular)
    static let ppActivityTitle  = Font.system(size: 15, weight: .regular)
    static let ppActivitySub    = Font.system(size: 13, weight: .regular)
    static let ppMeta           = Font.system(size: 13, weight: .regular)
    static let ppLink           = Font.system(size: 15, weight: .regular)
    static let ppTab            = Font.system(size: 11, weight: .regular)
    static let ppChip           = Font.system(size: 13, weight: .regular)
    static let ppButton         = Font.system(size: 17, weight: .regular)
    static let ppButtonSmall    = Font.system(size: 15, weight: .regular)
    static func pp(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspPayPalTokens {
    // MARK: - Brand
    static let payPalBlue        = Color(red: 0.00, green: 0.188, blue: 0.529)  // #003087
    static let payPalSky         = Color(red: 0.00, green: 0.439, blue: 0.729)  // #0070BA
    static let payPalCobalt      = Color(red: 0.00, green: 0.110, blue: 0.392)  // #001C64
    static let payPalBlueDark    = Color(red: 0.231, green: 0.510, blue: 0.965) // #3B82F6 (dark-mode shifted)

    // MARK: - Canvas & Surfaces (light)
    static let ppCanvas       = Color(red: 1.00, green: 1.00, blue: 1.00)    // #FFFFFF
    static let ppSurfaceGray  = Color(red: 0.961, green: 0.969, blue: 0.980) // #F5F7FA
    static let ppSurfaceGray2 = Color(red: 0.933, green: 0.945, blue: 0.957) // #EEF1F4
    static let ppDivider      = Color(red: 0.898, green: 0.910, blue: 0.929) // #E5E8ED

    // MARK: - Text (light)
    static let ppTextPrimary   = Color(red: 0.00, green: 0.078, blue: 0.208)  // #001435
    static let ppTextSecondary = Color(red: 0.173, green: 0.180, blue: 0.184) // #2C2E2F
    static let ppTextMuted     = Color(red: 0.408, green: 0.443, blue: 0.451) // #687173
    static let ppTextTertiary  = Color(red: 0.616, green: 0.639, blue: 0.651) // #9DA3A6

    // MARK: - Semantic
    static let ppSuccess       = Color(red: 0.110, green: 0.545, blue: 0.263) // #1C8B43
    static let ppSuccessBg     = Color(red: 0.894, green: 0.961, blue: 0.918) // #E4F5EA
    static let ppError         = Color(red: 0.824, green: 0.00, blue: 0.129)  // #D20021
    static let ppErrorBg       = Color(red: 0.988, green: 0.898, blue: 0.910) // #FCE5E8
    static let ppWarning       = Color(red: 1.00, green: 0.722, blue: 0.110)  // #FFB81C
    static let ppWarningBg     = Color(red: 1.00, green: 0.965, blue: 0.878)  // #FFF6E0

    // MARK: - Activity Icon Colors
    static let ppIconSent      = Color.payPalBlue       // #003087
    static let ppIconReceived  = Color.ppSuccess        // #1C8B43
    static let ppIconCard      = Color.payPalSky        // #0070BA
    static let ppIconReward    = Color.ppWarning        // #FFB81C

    // MARK: - Dark mode
    static let ppDarkCanvas    = Color(red: 0.039, green: 0.055, blue: 0.102) // #0A0E1A
    static let ppDarkSurface1  = Color(red: 0.078, green: 0.102, blue: 0.165) // #141A2A
    static let ppDarkSurface2  = Color(red: 0.122, green: 0.153, blue: 0.251) // #1F2740
    static let ppDarkDivider   = Color(red: 0.165, green: 0.192, blue: 0.259) // #2A3142
    static let ppDarkTextPri   = Color.white
    static let ppDarkTextSec   = Color(red: 0.659, green: 0.682, blue: 0.769) // #A8AEC4
}



// Fallback if PayPal Sans isn't bundled — SF Pro:


private struct LpspPayPalBalanceCard: View {
    let balance: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PayPal balance")
                .font(LpspPayPalFonts.ppActivitySub)
                .foregroundStyle(Color.ppTextMuted)

            Text(balance, format: .currency(code: "USD"))
                .font(LpspPayPalFonts.ppBalanceHero)
                .foregroundStyle(Color.ppTextPrimary)
                .monospacedDigit()
                .contentTransition(.numericText())
                .animation(.snappy, value: balance)

            HStack(spacing: 12) {
                Button(action: {}) {
                    Text("Add Money")
                        .font(LpspPayPalFonts.ppButton).foregroundStyle(.white)
                        .frame(maxWidth: .infinity).frame(height: 44)
                        .background(Capsule().fill(Color.payPalBlue))
                }
                Button(action: {}) {
                    Text("Transfer")
                        .font(LpspPayPalFonts.ppButtonSmall).foregroundStyle(Color.payPalBlue)
                        .frame(maxWidth: .infinity).frame(height: 44)
                        .overlay(Capsule().strokeBorder(Color.payPalBlue, lineWidth: 1.5))
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.ppCanvas)
                .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
        )
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.ppDivider, lineWidth: 1))
        .padding(.horizontal, 16)
    }
}

private struct LpspPayPalActivityRow: View {
    let name: String
    let subtitle: String
    let amount: Double
    let direction: LpspPayPalDirection
    let icon: LpspPayPalActivityIcon

    enum LpspPayPalDirection { case sent, received }
    enum LpspPayPalActivityIcon { case sent, received, card, reward }

    private var iconColor: Color {
        switch icon {
        case .sent:     return .ppIconSent
        case .received: return .ppIconReceived
        case .card:     return .ppIconCard
        case .reward:   return .ppIconReward
        }
    }
    private var iconSystemName: String {
        switch icon {
        case .sent:     return "arrow.up.right"
        case .received: return "arrow.down.left"
        case .card:     return "creditcard.fill"
        case .reward:   return "gift.fill"
        }
    }
    private var amountColor: Color { direction == .received ? .ppSuccess : .ppTextPrimary }
    private var sign: String { direction == .received ? "+" : "" }

    var body: some View {
        HStack(spacing: 12) {
            // Icon circle
            Circle()
                .fill(iconColor)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: iconSystemName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(LpspPayPalFonts.ppActivityTitle)
                    .foregroundStyle(Color.ppTextPrimary)
                Text(subtitle)
                    .font(LpspPayPalFonts.ppActivitySub)
                    .foregroundStyle(Color.ppTextMuted)
            }

            Spacer()

            Text("\(sign)\(amount, format: .currency(code: "USD"))")
                .font(LpspPayPalFonts.ppActivityAmount)
                .foregroundStyle(amountColor)
                .monospacedDigit()
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 68)
        .background(Color.ppCanvas)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.ppDivider).frame(height: 0.5)
        }
    }
}

private struct LpspPayPalPayPalPrimaryButton: View {
    let label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspPayPalFonts.ppButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Capsule().fill(Color.payPalBlue))
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: UUID())
    }
}

private struct LpspPayPalPayPalSecondaryButton: View {
    let label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspPayPalFonts.ppButtonSmall)
                .foregroundStyle(Color.payPalBlue)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .overlay(Capsule().strokeBorder(Color.payPalBlue, lineWidth: 1.5))
        }
    }
}

private struct LpspPayPalSendMoneyScreen: View {
    @State private var amount: String = "0"

    private var sendLabel: String {
        let value = Double(amount) ?? 0
        return "Send \(value.formatted(.currency(code: "USD")))"
    }

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            VStack(spacing: 8) {
                Text("USD")
                    .font(LpspPayPalFonts.ppMeta)
                    .foregroundStyle(Color.ppTextMuted)
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text("$")
                        .font(.custom("PayPalSansBig-Bold", size: 40))
                        .foregroundStyle(Color.ppTextMuted)
                    Text(amount)
                        .font(LpspPayPalFonts.ppSendAmountHero)
                        .foregroundStyle(Color.ppTextPrimary)
                        .monospacedDigit()
                }
            }

            Spacer()

            // Numeric keypad (use NumericKeypad from the Cash App example or iOS-native via TextField)

            LpspPayPalPayPalPrimaryButton(label: sendLabel) { /* send */ }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .background(Color.ppCanvas)
    }
}

private struct LpspPayPalPayPalWordmark: View {
    var size: CGFloat = 32

    var body: some View {
        ZStack {
            Text("P")
                .font(.custom("PayPalSansBig-Bold", size: size))
                .italic()
                .foregroundStyle(Color.payPalSky)
                .offset(x: -size * 0.18)
            Text("P")
                .font(.custom("PayPalSansBig-Bold", size: size))
                .italic()
                .foregroundStyle(Color.payPalBlue)
                .offset(x: size * 0.10)
        }
        .frame(width: size * 1.4, height: size * 1.2)
    }
}

private struct LpspPayPalActivityFilterChip: View {
    let label: String
    let isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspPayPalFonts.ppChip)
                .foregroundStyle(isSelected ? .white : Color.ppTextMuted)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule().fill(isSelected ? Color.payPalBlue : Color.ppSurfaceGray2)
                )
        }
    }
}

private struct LpspPayPalStatusPill: View {
    enum LpspPayPalStatus { case completed, pending, failed, refunded }
    let status: LpspPayPalStatus

    private var bg: Color {
        switch status {
        case .completed: return .ppSuccessBg
        case .pending:   return .ppWarningBg
        case .failed:    return .ppErrorBg
        case .refunded:  return .ppSurfaceGray2
        }
    }
    private var fg: Color {
        switch status {
        case .completed: return .ppSuccess
        case .pending:   return Color(red: 0.628, green: 0.420, blue: 0.0) // #A06B00
        case .failed:    return .ppError
        case .refunded:  return .ppTextMuted
        }
    }
    private var label: String {
        switch status {
        case .completed: return "Completed"
        case .pending:   return "Pending"
        case .failed:    return "Failed"
        case .refunded:  return "Refunded"
        }
    }

    var body: some View {
        Text(label)
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(fg)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(RoundedRectangle(cornerRadius: 4).fill(bg))
    }
}

private struct LpspPayPalPayPalRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = UIColor(red: 0.898, green: 0.910, blue: 0.929, alpha: 1)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            HomeView()     .tabItem { Label("Home",     systemImage: "house") }
            SendView()     .tabItem { Label("Send",     systemImage: "paperplane") }
            WalletView()   .tabItem { Label("Wallet",   systemImage: "wallet.pass") }
            ActivityView() .tabItem { Label("Activity", systemImage: "clock") }
            FinancesView() .tabItem { Label("Finances", systemImage: "chart.line.uptrend.xyaxis") }
        }
        .tint(Color.payPalBlue)
    }
}

// MARK: - Écrans showroom

private struct LpspPayPalShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspPayPalFinanceHomeTabScreen()
                .tabItem { Label("Activity", systemImage: "clock") }
                .tag(0)
            LpspPayPalFinanceHomeTabScreen()
                .tabItem { Label("Finances", systemImage: "chart.line.uptrend.xyaxis") }
                .tag(1)
        }
        .tint(LpspPayPalTokens.ppTextPrimary)
        
    }
}


private struct LpspPayPalGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspPayPalTokens.ppTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspPayPalTokens.ppTextPrimary))
                    VStack(alignment: .leading) {
                        Text("\(title) \(i + 1)").font(.system(size: 17, weight: .semibold))
                        Text("Contenu démo").font(.system(size: 14)).foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}


private struct LpspPayPalFinanceHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Solde total").font(.subheadline).foregroundStyle(.secondary)
                        Text("2 847,50 €").font(.system(size: 36, weight: .bold))
                    }
                    .padding(.horizontal)
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(colors: [LpspPayPalTokens.ppTextPrimary, LpspPayPalTokens.ppTextPrimary.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 180)
                        .overlay(alignment: .bottomLeading) {
                            Text("•••• 4829").font(.title2.bold()).foregroundStyle(.white).padding(20)
                        }
                        .padding(.horizontal)
                    Text("Transactions").font(.headline).padding(.horizontal)
                    ForEach(LpspPayPalDemoTx.items) { tx in
                        HStack {
                            Circle().fill(LpspPayPalTokens.ppTextPrimary.opacity(0.15)).frame(width: 40, height: 40)
                            VStack(alignment: .leading) { Text(tx.title); Text(tx.date).font(.caption).foregroundStyle(.secondary) }
                            Spacer()
                            Text(tx.amount).font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(tx.amount.hasPrefix("-") ? Color.primary : Color.green)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(LpspPayPalTokens.ppCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
        }
    }
}

private struct LpspPayPalFinanceCardsTabScreen: View {
    var body: some View {
        NavigationStack {
            Text("Gérez vos cartes").padding().navigationTitle("Cartes")
        }
    }
}

private struct LpspPayPalDemoTx: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let amount: String
    static let items: [LpspPayPalDemoTx] = [
        .init(title: "Carrefour", date: "Aujourd'hui", amount: "-42,30 €"),
        .init(title: "Virement reçu", date: "Hier", amount: "+150,00 €"),
    ]
}


