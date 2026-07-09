import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/paypal
// Meliwat/awesome-ios-design-md/finance/paypal/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomePayPalView: View {
    var body: some View {
        LpspPayPalShowroomRoot(store: LpspPayPalStore())
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
    static let ppIconSent      = LpspPayPalTokens.payPalBlue       // #003087
    static let ppIconReceived  = LpspPayPalTokens.ppSuccess        // #1C8B43
    static let ppIconCard      = LpspPayPalTokens.payPalSky        // #0070BA
    static let ppIconReward    = LpspPayPalTokens.ppWarning        // #FFB81C

    // MARK: - Dark mode
    static let ppDarkCanvas    = Color(red: 0.039, green: 0.055, blue: 0.102) // #0A0E1A
    static let ppDarkSurface1  = Color(red: 0.078, green: 0.102, blue: 0.165) // #141A2A
    static let ppDarkSurface2  = Color(red: 0.122, green: 0.153, blue: 0.251) // #1F2740
    static let ppDarkDivider   = Color(red: 0.165, green: 0.192, blue: 0.259) // #2A3142
    static let ppDarkTextPri   = Color.white
    static let ppDarkTextSec   = Color(red: 0.659, green: 0.682, blue: 0.769) // #A8AEC4
}



// Fallback if PayPal Sans isn't bundled — SF Pro:


fileprivate struct LpspPayPalBalanceCard: View {
    let balance: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PayPal balance")
                .font(LpspPayPalFonts.ppActivitySub)
                .foregroundStyle(LpspPayPalTokens.ppTextMuted)

            Text(balance, format: .currency(code: "USD"))
                .font(LpspPayPalFonts.ppBalanceHero)
                .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
                .monospacedDigit()
                .contentTransition(.numericText())
                .animation(.snappy, value: balance)

            HStack(spacing: 12) {
                Button(action: {}) {
                    Text("Add Money")
                        .font(LpspPayPalFonts.ppButton).foregroundStyle(.white)
                        .frame(maxWidth: .infinity).frame(height: 44)
                        .background(Capsule().fill(LpspPayPalTokens.payPalBlue))
                }
                Button(action: {}) {
                    Text("Transfer")
                        .font(LpspPayPalFonts.ppButtonSmall).foregroundStyle(LpspPayPalTokens.payPalBlue)
                        .frame(maxWidth: .infinity).frame(height: 44)
                        .overlay(Capsule().stroke(LpspPayPalTokens.payPalBlue, lineWidth: 1.5))
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspPayPalTokens.ppCanvas)
                .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
        )
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(LpspPayPalTokens.ppDivider, lineWidth: 1))
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspPayPalActivityRow: View {
    let name: String
    let subtitle: String
    let amount: Double
    let direction: LpspPayPalDirection
    let icon: LpspPayPalActivityIcon

    enum LpspPayPalDirection { case sent, received }
    enum LpspPayPalActivityIcon { case sent, received, card, reward }

    private var iconColor: Color {
        switch icon {
        case .sent:     return LpspPayPalTokens.ppIconSent
        case .received: return LpspPayPalTokens.ppIconReceived
        case .card:     return LpspPayPalTokens.ppIconCard
        case .reward:   return LpspPayPalTokens.ppIconReward
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
    private var amountColor: Color { direction == .received ? LpspPayPalTokens.ppSuccess : LpspPayPalTokens.ppTextPrimary }
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
                    .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
                Text(subtitle)
                    .font(LpspPayPalFonts.ppActivitySub)
                    .foregroundStyle(LpspPayPalTokens.ppTextMuted)
            }

            Spacer()

            Text("\(sign)\(amount, format: .currency(code: "USD"))")
                .font(LpspPayPalFonts.ppActivityAmount)
                .foregroundStyle(amountColor)
                .monospacedDigit()
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 68)
        .background(LpspPayPalTokens.ppCanvas)
        .overlay(alignment: .bottom) {
            Rectangle().fill(LpspPayPalTokens.ppDivider).frame(height: 0.5)
        }
    }
}

fileprivate struct LpspPayPalPayPalPrimaryButton: View {
    let label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspPayPalFonts.ppButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Capsule().fill(LpspPayPalTokens.payPalBlue))
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: UUID())
    }
}

fileprivate struct LpspPayPalPayPalSecondaryButton: View {
    let label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspPayPalFonts.ppButtonSmall)
                .foregroundStyle(LpspPayPalTokens.payPalBlue)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .overlay(Capsule().stroke(LpspPayPalTokens.payPalBlue, lineWidth: 1.5))
        }
    }
}

fileprivate struct LpspPayPalSendMoneyScreen: View {
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
                    .foregroundStyle(LpspPayPalTokens.ppTextMuted)
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text("$")
                        .font(.custom("PayPalSansBig-Bold", size: 40))
                        .foregroundStyle(LpspPayPalTokens.ppTextMuted)
                    Text(amount)
                        .font(LpspPayPalFonts.ppSendAmountHero)
                        .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
                        .monospacedDigit()
                }
            }

            Spacer()

            // Numeric keypad (use NumericKeypad from the Cash App example or iOS-native via TextField)

            LpspPayPalPayPalPrimaryButton(label: sendLabel) { /* send */ }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .background(LpspPayPalTokens.ppCanvas)
    }
}

fileprivate struct LpspPayPalPayPalWordmark: View {
    var size: CGFloat = 32

    var body: some View {
        ZStack {
            Text("P")
                .font(.custom("PayPalSansBig-Bold", size: size))
                .italic()
                .foregroundStyle(LpspPayPalTokens.payPalSky)
                .offset(x: -size * 0.18)
            Text("P")
                .font(.custom("PayPalSansBig-Bold", size: size))
                .italic()
                .foregroundStyle(LpspPayPalTokens.payPalBlue)
                .offset(x: size * 0.10)
        }
        .frame(width: size * 1.4, height: size * 1.2)
    }
}

fileprivate struct LpspPayPalActivityFilterChip: View {
    let label: String
    let isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspPayPalFonts.ppChip)
                .foregroundStyle(isSelected ? .white : LpspPayPalTokens.ppTextMuted)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule().fill(isSelected ? LpspPayPalTokens.payPalBlue : LpspPayPalTokens.ppSurfaceGray2)
                )
        }
    }
}

fileprivate struct LpspPayPalStatusPill: View {
    enum LpspPayPalStatus { case completed, pending, failed, refunded }
    let status: LpspPayPalStatus

    private var bg: Color {
        switch status {
        case .completed: return LpspPayPalTokens.ppSuccessBg
        case .pending:   return LpspPayPalTokens.ppWarningBg
        case .failed:    return LpspPayPalTokens.ppErrorBg
        case .refunded:  return LpspPayPalTokens.ppSurfaceGray2
        }
    }
    private var fg: Color {
        switch status {
        case .completed: return LpspPayPalTokens.ppSuccess
        case .pending:   return Color(red: 0.628, green: 0.420, blue: 0.0) // #A06B00
        case .failed:    return LpspPayPalTokens.ppError
        case .refunded:  return LpspPayPalTokens.ppTextMuted
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



// MARK: - Showroom data & store

private enum LpspPayPalShowroomTab: String, CaseIterable, Identifiable {
    case home, send, wallet, activity, finances

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .send: "Send"
        case .wallet: "Wallet"
        case .activity: "Activity"
        case .finances: "Finances"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .send: "paperplane.fill"
        case .wallet: "wallet.pass.fill"
        case .activity: "clock.fill"
        case .finances: "chart.line.uptrend.xyaxis"
        }
    }
}

private enum LpspPayPalActivityFilter: String, CaseIterable, Identifiable {
    case all, sent, received, pending

    var id: String { rawValue }

    var label: String {
        switch self {
        case .all: "All"
        case .sent: "Sent"
        case .received: "Received"
        case .pending: "Pending"
        }
    }
}

private struct LpspPayPalActivity: Identifiable, Equatable {
    let id: String
    let name: String
    let subtitle: String
    let amount: Double
    let direction: LpspPayPalActivityRow.LpspPayPalDirection
    let icon: LpspPayPalActivityRow.LpspPayPalActivityIcon
    let filter: LpspPayPalActivityFilter
}

private enum LpspPayPalShowroomData {
    static let activities: [LpspPayPalActivity] = [
        LpspPayPalActivity(
            id: "sarah",
            name: "Sarah Kim",
            subtitle: "Today, 2:18 PM · Completed",
            amount: 42.00,
            direction: .received,
            icon: .received,
            filter: .received
        ),
        LpspPayPalActivity(
            id: "marcus",
            name: "Marcus Lin",
            subtitle: "Yesterday · Completed",
            amount: 18.50,
            direction: .sent,
            icon: .sent,
            filter: .sent
        ),
        LpspPayPalActivity(
            id: "wholefoods",
            name: "Whole Foods Market",
            subtitle: "Dec 1 · Visa debit ·· 4242",
            amount: 67.84,
            direction: .sent,
            icon: .card,
            filter: .sent
        ),
        LpspPayPalActivity(
            id: "cashback",
            name: "Cashback Reward",
            subtitle: "Nov 28 · From PayPal",
            amount: 3.42,
            direction: .received,
            icon: .reward,
            filter: .received
        ),
        LpspPayPalActivity(
            id: "pending",
            name: "Alex Mercer",
            subtitle: "Pending · Requested today",
            amount: 25.00,
            direction: .received,
            icon: .received,
            filter: .pending
        ),
    ]
}

@MainActor
fileprivate final class LpspPayPalStore: ObservableObject {
    @Published var selectedTab: LpspPayPalShowroomTab = .home
    @Published var balance: Double = 1247.92
    @Published var activityFilter: LpspPayPalActivityFilter = .all
    @Published var activities: [LpspPayPalActivity] = LpspPayPalShowroomData.activities
    @Published var sendAmount = "25"
    @Published var showTransferSheet = false

    var filteredActivities: [LpspPayPalActivity] {
        switch activityFilter {
        case .all:
            return activities.filter { $0.filter != .pending || activityFilter == .pending }
        case .sent, .received, .pending:
            return activities.filter { $0.filter == activityFilter }
        }
    }

    func setFilter(_ filter: LpspPayPalActivityFilter) {
        activityFilter = filter
    }

    func addMoney() {
        balance += 100
        activities.insert(
            LpspPayPalActivity(
                id: "add-\(activities.count)",
                name: "Added money",
                subtitle: "Just now · Completed",
                amount: 100,
                direction: .received,
                icon: .received,
                filter: .received
            ),
            at: 0
        )
    }

    func transferMoney() {
        balance -= 50
        activities.insert(
            LpspPayPalActivity(
                id: "transfer-\(activities.count)",
                name: "Bank transfer",
                subtitle: "Just now · Completed",
                amount: 50,
                direction: .sent,
                icon: .sent,
                filter: .sent
            ),
            at: 0
        )
        showTransferSheet = false
    }

    func sendMoney() {
        let value = Double(sendAmount) ?? 0
        guard value > 0 else { return }
        balance -= value
        activities.insert(
            LpspPayPalActivity(
                id: "send-\(activities.count)",
                name: "Marcus Lin",
                subtitle: "Just now · Completed",
                amount: value,
                direction: .sent,
                icon: .sent,
                filter: .sent
            ),
            at: 0
        )
        sendAmount = "25"
        selectedTab = .home
    }
}

// MARK: - Écrans showroom

private struct LpspPayPalShowroomRoot: View {
    @ObservedObject var store: LpspPayPalStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspPayPalHomeTabScreen(store: store)
                case .send:
                    LpspPayPalSendTabScreen(store: store)
                case .wallet:
                    LpspPayPalWalletTabScreen(store: store)
                case .activity:
                    LpspPayPalActivityTabScreen(store: store)
                case .finances:
                    LpspPayPalFinancesTabScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspPayPalLabeledTabBar(store: store)
        }
        .background(LpspPayPalTokens.ppCanvas.ignoresSafeArea())
        .sheet(isPresented: $store.showTransferSheet) {
            LpspPayPalTransferSheet(store: store)
        }
    }
}

private struct LpspPayPalLabeledTabBar: View {
    @ObservedObject var store: LpspPayPalStore

    var body: some View {
        HStack {
            ForEach(LpspPayPalShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspPayPalFonts.ppTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspPayPalTokens.payPalBlue
                            : LpspPayPalTokens.ppTextMuted
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspPayPalTokens.ppCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspPayPalTokens.ppDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspPayPalSpectrTopBar: View {
    var body: some View {
        HStack {
            LpspPayPalPayPalWordmark(size: 28)

            Spacer()

            HStack(spacing: 20) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
                Image(systemName: "bell")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
    }
}

private struct LpspPayPalShowroomBalanceCard: View {
    @ObservedObject var store: LpspPayPalStore

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PayPal balance")
                .font(LpspPayPalFonts.ppActivitySub)
                .foregroundStyle(LpspPayPalTokens.ppTextMuted)

            Text(store.balance, format: .currency(code: "USD"))
                .font(LpspPayPalFonts.ppBalanceHero.weight(.bold))
                .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
                .monospacedDigit()
                .contentTransition(.numericText())
                .animation(.snappy, value: store.balance)

            HStack(spacing: 12) {
                Button(action: { store.addMoney() }) {
                    Text("Add Money")
                        .font(LpspPayPalFonts.ppButton)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Capsule().fill(LpspPayPalTokens.payPalBlue))
                }
                .buttonStyle(.plain)

                Button(action: { store.showTransferSheet = true }) {
                    Text("Transfer")
                        .font(LpspPayPalFonts.ppButtonSmall.weight(.semibold))
                        .foregroundStyle(LpspPayPalTokens.payPalBlue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .overlay(
                            Capsule()
                                .stroke(LpspPayPalTokens.payPalBlue, lineWidth: 1.5)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspPayPalTokens.ppCanvas)
                .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(LpspPayPalTokens.ppDivider, lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
}

private struct LpspPayPalActivityFilterRow: View {
    @ObservedObject var store: LpspPayPalStore

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(LpspPayPalActivityFilter.allCases) { filter in
                    LpspPayPalActivityFilterChip(
                        label: filter.label,
                        isSelected: store.activityFilter == filter
                    ) {
                        store.setFilter(filter)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 12)
    }
}

private struct LpspPayPalActivityList: View {
    let activities: [LpspPayPalActivity]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(activities) { activity in
                LpspPayPalActivityRow(
                    name: activity.name,
                    subtitle: activity.subtitle,
                    amount: activity.amount,
                    direction: activity.direction,
                    icon: activity.icon
                )
            }
        }
    }
}

private struct LpspPayPalHomeTabScreen: View {
    @ObservedObject var store: LpspPayPalStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LpspPayPalSpectrTopBar()
                LpspPayPalShowroomBalanceCard(store: store)
                LpspPayPalActivityFilterRow(store: store)
                LpspPayPalActivityList(activities: store.filteredActivities)
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspPayPalSendTabScreen: View {
    @ObservedObject var store: LpspPayPalStore

    var body: some View {
        VStack(spacing: 24) {
            LpspPayPalSpectrTopBar()

            Spacer()

            VStack(spacing: 8) {
                Text("USD")
                    .font(LpspPayPalFonts.ppMeta)
                    .foregroundStyle(LpspPayPalTokens.ppTextMuted)
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text("$")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(LpspPayPalTokens.ppTextMuted)
                    TextField("0", text: $store.sendAmount)
                        .font(LpspPayPalFonts.ppSendAmountHero.weight(.bold))
                        .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.leading)
                }
            }

            Spacer()

            LpspPayPalPayPalPrimaryButton(label: sendLabel) {
                store.sendMoney()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }

    private var sendLabel: String {
        let value = Double(store.sendAmount) ?? 0
        return "Send \(value.formatted(.currency(code: "USD")))"
    }
}

private struct LpspPayPalWalletTabScreen: View {
    @ObservedObject var store: LpspPayPalStore

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                LpspPayPalSpectrTopBar()

                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [LpspPayPalTokens.payPalBlue, LpspPayPalTokens.payPalSky],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)
                    .overlay(alignment: .bottomLeading) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("PayPal Debit")
                                .font(LpspPayPalFonts.ppCardTitle.weight(.semibold))
                                .foregroundStyle(.white)
                            Text("•••• 4242")
                                .font(LpspPayPalFonts.ppMeta)
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        .padding(20)
                    }
                    .padding(.horizontal, 16)

                LpspPayPalShowroomBalanceCard(store: store)
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspPayPalActivityTabScreen: View {
    @ObservedObject var store: LpspPayPalStore

    var body: some View {
        VStack(spacing: 0) {
            LpspPayPalSpectrTopBar()
            LpspPayPalActivityFilterRow(store: store)

            ScrollView {
                LpspPayPalActivityList(activities: store.filteredActivities)
            }
        }
    }
}

private struct LpspPayPalFinancesTabScreen: View {
    @ObservedObject var store: LpspPayPalStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                LpspPayPalSpectrTopBar()

                Text("Monthly summary")
                    .font(LpspPayPalFonts.ppSectionHeader.weight(.semibold))
                    .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
                    .padding(.horizontal, 16)

                RoundedRectangle(cornerRadius: 16)
                    .fill(LpspPayPalTokens.ppSurfaceGray)
                    .frame(height: 160)
                    .overlay {
                        VStack(spacing: 8) {
                            Text("Spending")
                                .font(LpspPayPalFonts.ppMeta)
                                .foregroundStyle(LpspPayPalTokens.ppTextMuted)
                            Text("$286.34")
                                .font(LpspPayPalFonts.ppBalanceHero.weight(.bold))
                                .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
                        }
                    }
                    .padding(.horizontal, 16)

                Text("Recent activity")
                    .font(LpspPayPalFonts.ppSectionHeader.weight(.semibold))
                    .foregroundStyle(LpspPayPalTokens.ppTextPrimary)
                    .padding(.horizontal, 16)

                LpspPayPalActivityList(activities: Array(store.activities.prefix(3)))
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspPayPalTransferSheet: View {
    @ObservedObject var store: LpspPayPalStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Transfer to bank")
                    .font(LpspPayPalFonts.ppSectionHeader.weight(.semibold))
                    .foregroundStyle(LpspPayPalTokens.ppTextPrimary)

                Text("Move $50.00 to your linked checking account.")
                    .font(LpspPayPalFonts.ppBody)
                    .foregroundStyle(LpspPayPalTokens.ppTextMuted)

                LpspPayPalPayPalPrimaryButton(label: "Transfer $50.00") {
                    store.transferMoney()
                    dismiss()
                }

                Spacer()
            }
            .padding(16)
            .background(LpspPayPalTokens.ppCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}


