import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/wise
// Meliwat/awesome-ios-design-md/finance/wise/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeWiseView: View {
    var body: some View {
        LpspWiseShowroomRoot(store: LpspWiseStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspWiseFonts {
    static let wiseBalance     = Font.system(size: 40, weight: .regular)
    static let wiseTitleLarge  = Font.system(size: 32, weight: .regular)
    static let wiseSection     = Font.system(size: 22, weight: .regular)
    static let wiseCurrency    = Font.system(size: 22, weight: .regular)
    static let wiseSubsection  = Font.system(size: 18, weight: .regular)
    static let wiseAmount      = Font.system(size: 16, weight: .regular)
    static let wiseTitle       = Font.system(size: 16, weight: .regular)
    static let wiseBody        = Font.system(size: 15, weight: .regular)
    static let wiseButton      = Font.system(size: 16, weight: .regular)
    static let wiseMeta        = Font.system(size: 13, weight: .regular)
    static let wiseLabelUpper  = Font.system(size: 11, weight: .regular)
    static let wiseTab         = Font.system(size: 11, weight: .regular)
    static let wiseCaption     = Font.system(size: 11, weight: .regular)
    static func wise(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
}

private enum LpspWiseTokens {
    // MARK: - Canvas & Surfaces
    static let wiseCanvas       = Color.white                                  // #FFFFFF
    static let wiseSurface      = Color(red: 0.969, green: 0.969, blue: 0.969) // #F7F7F7
    static let wiseSurfaceSunken = Color(red: 0.937, green: 0.937, blue: 0.937) // #EFEFEF
    static let wiseDivider      = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
    static let wiseBorder       = Color(red: 0.824, green: 0.824, blue: 0.824) // #D2D2D2

    // MARK: - Text
    static let wiseTextPrimary   = Color(red: 0.055, green: 0.059, blue: 0.047) // #0E0F0C
    static let wiseTextSecondary = Color(red: 0.420, green: 0.435, blue: 0.400) // #6B6F66
    static let wiseTextTertiary  = Color(red: 0.604, green: 0.616, blue: 0.584) // #9A9D95

    // MARK: - Brand
    static let wiseBright        = Color(red: 0.624, green: 0.910, blue: 0.439) // #9FE870
    static let wiseBrightPressed = Color(red: 0.541, green: 0.831, blue: 0.361) // #8AD45C
    static let wiseBrightTint    = Color(red: 0.918, green: 0.976, blue: 0.863) // #EAF9DC
    static let wiseForest        = Color(red: 0.086, green: 0.200, blue: 0.000) // #163300
    static let wiseForestHover   = Color(red: 0.055, green: 0.133, blue: 0.000) // #0E2200

    // MARK: - Semantic
    static let wiseSuccess = Color(red: 0.184, green: 0.561, blue: 0.306) // #2F8F4E
    static let wisePending = Color(red: 0.710, green: 0.471, blue: 0.118) // #B5781E
    static let wiseError   = Color(red: 0.831, green: 0.200, blue: 0.169) // #D4332B
}





fileprivate struct LpspWiseWisePrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspWiseFonts.wiseButton)
                .foregroundStyle(LpspWiseTokens.wiseForest) // forest on bright green, never white
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(LpspWiseTokens.wiseBright, in: RoundedRectangle(cornerRadius: 16))
        }
        .sensoryFeedback(.impact(weight: .light), trigger: UUID())
        .buttonStyle(LpspWiseWisePressableStyle(pressedFill: LpspWiseTokens.wiseBrightPressed))
    }
}

fileprivate struct LpspWiseWiseForestButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspWiseFonts.wiseButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(LpspWiseTokens.wiseForest, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(LpspWiseWisePressableStyle(pressedFill: LpspWiseTokens.wiseForestHover))
    }
}

fileprivate struct LpspWiseWisePressableStyle: ButtonStyle {
    var pressedFill: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .brightness(configuration.isPressed ? -0.03 : 0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

fileprivate struct LpspWiseForestAccountHero: View {
    let total: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TOTAL BALANCE")
                .font(LpspWiseFonts.wiseLabelUpper)
                .foregroundStyle(LpspWiseTokens.wiseBright)
            Text(total)
                .font(LpspWiseFonts.wiseBalance)
                .monospacedDigit()
                .foregroundStyle(.white)
                .contentTransition(.numericText())   // rolls digits into place
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .bold))
                Text("Add money").font(LpspWiseFonts.wiseTitle)
            }
            .foregroundStyle(LpspWiseTokens.wiseBright)
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(RoundedRectangle(cornerRadius: 20).fill(LpspWiseTokens.wiseForestHover))
        .shadow(color: LpspWiseTokens.wiseForestHover.opacity(0.25), radius: 16, y: 12)
    }
}

fileprivate struct LpspWiseCurrencyRow: View {
    let flag: String
    let code: String
    let name: String
    let balance: String

    var body: some View {
        HStack(spacing: 12) {
            Text(flag)
                .font(.system(size: 22))
                .frame(width: 32, height: 32)
                .background(Circle().fill(LpspWiseTokens.wiseSurface))
            VStack(alignment: .leading, spacing: 2) {
                Text(code).font(LpspWiseFonts.wiseTitle).foregroundStyle(LpspWiseTokens.wiseTextPrimary)
                Text(name).font(LpspWiseFonts.wiseMeta).foregroundStyle(LpspWiseTokens.wiseTextSecondary)
            }
            Spacer()
            Text(balance)
                .font(LpspWiseFonts.wiseCurrency)
                .monospacedDigit()
                .foregroundStyle(LpspWiseTokens.wiseTextPrimary)
        }
        .padding(.horizontal, 16)
        .frame(height: 64)
        .contentShape(Rectangle())
        .overlay(Divider().background(LpspWiseTokens.wiseDivider), alignment: .bottom)
    }
}

fileprivate struct LpspWiseFeeBreakdownCard: View {
    struct LpspWiseLine: Identifiable { let id = UUID(); let label: String; let value: String; var emphasized = false }
    let lines: [LpspWiseLine]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(lines.enumerated()), id: \.element.id) { idx, line in
                HStack {
                    Text(line.label)
                        .font(line.emphasized ? LpspWiseFonts.wiseTitle : LpspWiseFonts.wiseBody)
                        .foregroundStyle(line.emphasized ? LpspWiseTokens.wiseForest : LpspWiseTokens.wiseTextSecondary)
                    Spacer()
                    Text(line.value)
                        .font(line.emphasized ? LpspWiseFonts.wiseSubsection : LpspWiseFonts.wiseAmount)
                        .monospacedDigit()
                        .foregroundStyle(line.emphasized ? LpspWiseTokens.wiseForest : LpspWiseTokens.wiseTextPrimary)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, line.emphasized ? 12 : 0)
                .background(
                    line.emphasized
                        ? RoundedRectangle(cornerRadius: 10).fill(LpspWiseTokens.wiseBrightTint)
                        : nil
                )
                if idx < lines.count - 1 && !line.emphasized {
                    Divider().background(LpspWiseTokens.wiseDivider)
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspWiseTokens.wiseCanvas)
                .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(LpspWiseTokens.wiseDivider, lineWidth: 1))
        )
    }
}

fileprivate struct LpspWiseSendStepper: View {
    let steps: [String]      // ["Recipient","Amount","Review","Pay"]
    let current: Int

    var body: some View {
        HStack(spacing: 0) {
            ForEach(steps.indices, id: \.self) { i in
                HStack(spacing: 0) {
                    ZStack {
                        Circle()
                            .fill(i < current ? LpspWiseTokens.wiseBright : (i == current ? LpspWiseTokens.wiseForest : LpspWiseTokens.wiseDivider))
                            .frame(width: 28, height: 28)
                        if i < current {
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(LpspWiseTokens.wiseForest)
                        } else {
                            Text("\(i + 1)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(i == current ? .white : LpspWiseTokens.wiseTextSecondary)
                        }
                    }
                    if i < steps.count - 1 {
                        Rectangle()
                            .fill(i < current ? LpspWiseTokens.wiseForest : LpspWiseTokens.wiseDivider)
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

fileprivate struct LpspWiseRollingBalance: View {
    let value: Double
    var body: some View {
        Text(value, format: .currency(code: "GBP"))
            .font(LpspWiseFonts.wiseBalance)
            .monospacedDigit()
            .contentTransition(.numericText(value: value))
            .animation(.easeOut(duration: 0.5), value: value)
    }
}


fileprivate struct LpspWiseLiveDot: View {
    @State private var on = false
    var body: some View {
        Circle().fill(LpspWiseTokens.wiseSuccess).frame(width: 6, height: 6)
            .opacity(on ? 1 : 0.3)
            .onAppear { withAnimation(.easeInOut(duration: 1).repeatForever()) { on = true } }
    }
}

// Fee card reveal: stagger lines with .transition(.opacity) and per-row delay

// MARK: - Showroom data & store

private enum LpspWiseShowroomTab: String, CaseIterable, Identifiable {
    case home, card, recipients, payments, account

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .card: "Card"
        case .recipients: "Recipients"
        case .payments: "Payments"
        case .account: "Account"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .card: "creditcard.fill"
        case .recipients: "person.2.fill"
        case .payments: "arrow.left.arrow.right"
        case .account: "person.crop.circle.fill"
        }
    }
}

private enum LpspWiseQuickAction: String, Identifiable {
    case send, add, request, convert

    var id: String { rawValue }

    var title: String {
        switch self {
        case .send: "Send"
        case .add: "Add"
        case .request: "Request"
        case .convert: "Convert"
        }
    }

    var icon: String {
        switch self {
        case .send: "paperplane.fill"
        case .add: "plus"
        case .request: "arrow.down"
        case .convert: "arrow.left.arrow.right"
        }
    }
}

private struct LpspWiseCurrencyAccount: Identifiable, Equatable {
    let id: String
    let flag: String
    let code: String
    let name: String
    var balance: String
}

private struct LpspWisePayment: Identifiable, Equatable {
    let id: String
    let title: String
    let meta: String
    let amount: String
    let incoming: Bool
}

private enum LpspWiseShowroomData {
    static let userInitials = "AM"
    static let totalBalance = "£12,480.65"

    static let accounts: [LpspWiseCurrencyAccount] = [
        LpspWiseCurrencyAccount(id: "GBP", flag: "🇬🇧", code: "GBP", name: "British Pound", balance: "£8,240.10"),
        LpspWiseCurrencyAccount(id: "EUR", flag: "🇪🇺", code: "EUR", name: "Euro", balance: "€3,180.55"),
        LpspWiseCurrencyAccount(id: "USD", flag: "🇺🇸", code: "USD", name: "US Dollar", balance: "$1,060.00"),
    ]

    static let recipients = ["Jamie Cole", "Mara Singh", "Alex Mercer"]

    static let payments: [LpspWisePayment] = [
        LpspWisePayment(id: "1", title: "Jamie Cole", meta: "Sent · Yesterday", amount: "-£120.00", incoming: false),
        LpspWisePayment(id: "2", title: "Salary", meta: "Received · Monday", amount: "+£2,400.00", incoming: true),
        LpspWisePayment(id: "3", title: "EUR conversion", meta: "Converted · Sunday", amount: "-£200.00", incoming: false),
    ]
}

@MainActor
fileprivate final class LpspWiseStore: ObservableObject {
    @Published var selectedTab: LpspWiseShowroomTab = .home
    @Published var accounts: [LpspWiseCurrencyAccount] = LpspWiseShowroomData.accounts
    @Published var payments: [LpspWisePayment] = LpspWiseShowroomData.payments
    @Published var selectedAccountId = "GBP"
    @Published var activeQuickAction: LpspWiseQuickAction?
    @Published var sendAmount = "£250"

    func selectAccount(_ id: String) {
        selectedAccountId = id
    }

    func openQuickAction(_ action: LpspWiseQuickAction) {
        activeQuickAction = action
    }

    func dismissQuickAction() {
        activeQuickAction = nil
    }

    func addMoney() {
        let payment = LpspWisePayment(
            id: "add-\(payments.count + 1)",
            title: "Added money",
            meta: "Just now · GBP",
            amount: "+£100.00",
            incoming: true
        )
        payments.insert(payment, at: 0)
        accounts = accounts.map { account in
            guard account.id == "GBP" else { return account }
            var copy = account
            copy.balance = "£8,340.10"
            return copy
        }
        activeQuickAction = nil
    }

    func sendMoney() {
        let payment = LpspWisePayment(
            id: "send-\(payments.count + 1)",
            title: "Jamie Cole",
            meta: "Just now · Sent",
            amount: "-\(sendAmount)",
            incoming: false
        )
        payments.insert(payment, at: 0)
        activeQuickAction = nil
    }

    func requestMoney() {
        let payment = LpspWisePayment(
            id: "req-\(payments.count + 1)",
            title: "Request sent",
            meta: "Pending · Mara Singh",
            amount: "+£50.00",
            incoming: true
        )
        payments.insert(payment, at: 0)
        activeQuickAction = nil
    }

    func convertCurrency() {
        accounts = accounts.map { account in
            switch account.id {
            case "GBP":
                var copy = account
                copy.balance = "£8,040.10"
                return copy
            case "EUR":
                var copy = account
                copy.balance = "€3,380.55"
                return copy
            default:
                return account
            }
        }
        selectedAccountId = "EUR"
        activeQuickAction = nil
    }
}

// MARK: - Écrans showroom

private struct LpspWiseShowroomRoot: View {
    @ObservedObject var store: LpspWiseStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspWiseHomeTabScreen(store: store)
                case .card:
                    LpspWiseCardTabScreen()
                case .recipients:
                    LpspWiseRecipientsTabScreen()
                case .payments:
                    LpspWisePaymentsTabScreen(store: store)
                case .account:
                    LpspWiseAccountTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspWiseLabeledTabBar(store: store)
        }
        .background(LpspWiseTokens.wiseCanvas.ignoresSafeArea())
        .sheet(item: $store.activeQuickAction) { action in
            LpspWiseQuickActionSheet(store: store, action: action)
        }
    }
}

private struct LpspWiseLabeledTabBar: View {
    @ObservedObject var store: LpspWiseStore

    var body: some View {
        HStack {
            ForEach(LpspWiseShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspWiseFonts.wiseTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspWiseTokens.wiseForest
                            : LpspWiseTokens.wiseTextTertiary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspWiseTokens.wiseCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspWiseTokens.wiseDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspWiseHomeTabScreen: View {
    @ObservedObject var store: LpspWiseStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LpspWiseSpectrTopBar()

                Button {
                    store.openQuickAction(.add)
                } label: {
                    LpspWiseForestAccountHero(total: LpspWiseShowroomData.totalBalance)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.top, 8)

                LpspWiseQuickActionRow { action in
                    store.openQuickAction(action)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 16)

                Text("Your accounts")
                    .font(LpspWiseFonts.wiseMeta.weight(.semibold))
                    .foregroundStyle(LpspWiseTokens.wiseTextSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)

                VStack(spacing: 0) {
                    ForEach(store.accounts) { account in
                        Button {
                            store.selectAccount(account.id)
                        } label: {
                            LpspWiseCurrencyRow(
                                flag: account.flag,
                                code: account.code,
                                name: account.name,
                                balance: account.balance
                            )
                            .background(
                                store.selectedAccountId == account.id
                                    ? LpspWiseTokens.wiseBrightTint.opacity(0.35)
                                    : Color.clear
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspWiseSpectrTopBar: View {
    var body: some View {
        HStack(spacing: 12) {
            Text(LpspWiseShowroomData.userInitials)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(LpspWiseTokens.wiseForest)
                .frame(width: 36, height: 36)
                .background(Circle().fill(LpspWiseTokens.wiseBrightTint))

            Text("Home")
                .font(LpspWiseFonts.wiseTitle.weight(.semibold))
                .foregroundStyle(LpspWiseTokens.wiseTextPrimary)

            Spacer()

            Image(systemName: "bell")
                .font(.system(size: 20))
                .foregroundStyle(LpspWiseTokens.wiseTextPrimary)

            Image(systemName: "gearshape")
                .font(.system(size: 20))
                .foregroundStyle(LpspWiseTokens.wiseTextPrimary)
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
}

private struct LpspWiseQuickActionRow: View {
    let onAction: (LpspWiseQuickAction) -> Void

    var body: some View {
        HStack(spacing: 0) {
            ForEach([LpspWiseQuickAction.send, .add, .request, .convert]) { action in
                Button {
                    onAction(action)
                } label: {
                    VStack(spacing: 6) {
                        ZStack {
                            Circle()
                                .fill(
                                    action == .send
                                        ? LpspWiseTokens.wiseBright
                                        : LpspWiseTokens.wiseSurface
                                )
                                .frame(width: 52, height: 52)
                            Image(systemName: action.icon)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(LpspWiseTokens.wiseForest)
                        }
                        Text(action.title)
                            .font(LpspWiseFonts.wiseCaption)
                            .foregroundStyle(LpspWiseTokens.wiseTextPrimary)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

private struct LpspWiseQuickActionSheet: View {
    @ObservedObject var store: LpspWiseStore
    let action: LpspWiseQuickAction
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(action.title)
                    .font(LpspWiseFonts.wiseSection.weight(.bold))
                    .foregroundStyle(LpspWiseTokens.wiseTextPrimary)

                switch action {
                case .send:
                    TextField("Amount", text: $store.sendAmount)
                        .font(LpspWiseFonts.wiseCurrency)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LpspWiseTokens.wiseSurface)
                        )
                    LpspWiseWisePrimaryButton(title: "Send money") {
                        store.sendMoney()
                        dismiss()
                    }
                case .add:
                    Text("Add GBP to your balance instantly.")
                        .font(LpspWiseFonts.wiseBody)
                        .foregroundStyle(LpspWiseTokens.wiseTextSecondary)
                    LpspWiseWisePrimaryButton(title: "Add £100") {
                        store.addMoney()
                        dismiss()
                    }
                case .request:
                    Text("Request money from Mara Singh")
                        .font(LpspWiseFonts.wiseBody)
                        .foregroundStyle(LpspWiseTokens.wiseTextSecondary)
                    LpspWiseWisePrimaryButton(title: "Send request") {
                        store.requestMoney()
                        dismiss()
                    }
                case .convert:
                    LpspWiseFeeBreakdownCard(lines: [
                        .init(label: "You send", value: "£200.00"),
                        .init(label: "Fee", value: "£0.42"),
                        .init(label: "They get", value: "€230.15", emphasized: true),
                    ])
                    LpspWiseWisePrimaryButton(title: "Convert") {
                        store.convertCurrency()
                        dismiss()
                    }
                }

                Spacer()
            }
            .padding(16)
            .background(LpspWiseTokens.wiseCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        store.dismissQuickAction()
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

private struct LpspWiseCardTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LpspWiseTokens.wiseForest)
                    .frame(height: 200)
                    .overlay(alignment: .bottomLeading) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Wise Debit")
                                .font(LpspWiseFonts.wiseTitle.weight(.semibold))
                                .foregroundStyle(.white)
                            Text("•••• 4829")
                                .font(LpspWiseFonts.wiseMeta)
                                .foregroundStyle(LpspWiseTokens.wiseBright)
                        }
                        .padding(20)
                    }
                    .padding(.horizontal, 16)

                Text("Spend abroad with the real exchange rate")
                    .font(LpspWiseFonts.wiseBody)
                    .foregroundStyle(LpspWiseTokens.wiseTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            .padding(.vertical, 24)
        }
    }
}

private struct LpspWiseRecipientsTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspWiseShowroomData.recipients, id: \.self) { name in
                HStack(spacing: 12) {
                    Circle()
                        .fill(LpspWiseTokens.wiseBrightTint)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Text(String(name.prefix(1)))
                                .font(LpspWiseFonts.wiseTitle.weight(.semibold))
                                .foregroundStyle(LpspWiseTokens.wiseForest)
                        }
                    Text(name)
                        .font(LpspWiseFonts.wiseTitle)
                        .foregroundStyle(LpspWiseTokens.wiseTextPrimary)
                }
                .listRowBackground(LpspWiseTokens.wiseCanvas)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

private struct LpspWisePaymentsTabScreen: View {
    @ObservedObject var store: LpspWiseStore

    var body: some View {
        List {
            ForEach(store.payments) { payment in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(payment.title)
                            .font(LpspWiseFonts.wiseTitle.weight(.semibold))
                            .foregroundStyle(LpspWiseTokens.wiseTextPrimary)
                        Text(payment.meta)
                            .font(LpspWiseFonts.wiseMeta)
                            .foregroundStyle(LpspWiseTokens.wiseTextSecondary)
                    }
                    Spacer()
                    Text(payment.amount)
                        .font(LpspWiseFonts.wiseAmount.weight(.semibold))
                        .foregroundStyle(payment.incoming ? LpspWiseTokens.wiseSuccess : LpspWiseTokens.wiseTextPrimary)
                }
                .listRowBackground(LpspWiseTokens.wiseCanvas)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

private struct LpspWiseAccountTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(LpspWiseShowroomData.userInitials)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(LpspWiseTokens.wiseForest)
                    .frame(width: 88, height: 88)
                    .background(Circle().fill(LpspWiseTokens.wiseBrightTint))

                Text("Alex Mercer")
                    .font(LpspWiseFonts.wiseSection.weight(.bold))
                    .foregroundStyle(LpspWiseTokens.wiseTextPrimary)

                Text("Personal account · Verified")
                    .font(LpspWiseFonts.wiseMeta)
                    .foregroundStyle(LpspWiseTokens.wiseTextSecondary)

                LpspWiseWiseForestButton(title: "Account details") {}
                    .padding(.horizontal, 32)
            }
            .padding(.vertical, 32)
        }
    }
}


