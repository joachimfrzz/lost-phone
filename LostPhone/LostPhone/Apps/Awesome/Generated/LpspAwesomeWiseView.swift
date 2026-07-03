import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/finance/wise/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/wise
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeWiseView: View {
    var body: some View {
        LpspWiseShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
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
}

private enum LpspWiseFonts {
    static func wise(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
}

private struct LpspWiseWisePrimaryButton: View {
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

private struct LpspWiseWiseForestButton: View {
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

private struct LpspWiseWisePressableStyle: ButtonStyle {
    var pressedFill: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .brightness(configuration.isPressed ? -0.03 : 0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

private struct LpspWiseForestAccountHero: View {
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

private struct LpspWiseCurrencyRow: View {
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

private struct LpspWiseFeeBreakdownCard: View {
    struct LpspWiseLine: Identifiable { let id = UUID(); let label: String; let value: String; var emphasized = false }
    let lines: [LpspWiseLine]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(lines.enumerated()), id: \.element.id) { idx, line in
                HStack {
                    Text(line.label)
                        .font(line.emphasized ? LpspWiseTokens.wiseTitle : LpspWiseTokens.wiseBody)
                        .foregroundStyle(line.emphasized ? LpspWiseTokens.wiseForest : LpspWiseTokens.wiseTextSecondary)
                    Spacer()
                    Text(line.value)
                        .font(line.emphasized ? LpspWiseTokens.wiseSubsection : LpspWiseTokens.wiseAmount)
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

private struct LpspWiseSendStepper: View {
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

// Use SwiftUI's contentTransition(.numericText()) and animate the value change:
private struct LpspWiseRollingBalance: View {
    let value: Double
    var body: some View {
        Text(value, format: .currency(code: "GBP"))
            .font(LpspWiseFonts.wiseBalance)
            .monospacedDigit()
            .contentTransition(.numericText(value: value))
            .animation(.easeOut(duration: 0.5), value: value)
    }
}

private struct LpspWiseRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = UIColor(LpspWiseTokens.wiseDivider)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            CardView().tabItem { Label("Card", systemImage: "creditcard.fill") }
            RecipientsView().tabItem { Label("Recipients", systemImage: "person.2.fill") }
            PaymentsView().tabItem { Label("Payments", systemImage: "arrow.left.arrow.right") }
            AccountView().tabItem { Label("Account", systemImage: "person.crop.circle.fill") }
        }
        .tint(LpspWiseTokens.wiseForest) // active = forest; pair with a bright-green active marker if desired
    }
}

// Number roll-up — contentTransition(.numericText()) + .animation(.easeOut(0.5))

// CTA press — LpspWiseWisePressableStyle: scale 0.98 + brightness -0.03, 150ms

// Stepper advance: animate the circle fill + rail with .easeInOut(0.2) on `current` change

// Rate ticker pulse
private struct LpspWiseLiveDot: View {
    @State private var on = false
    var body: some View {
        Circle().fill(LpspWiseTokens.wiseSuccess).frame(width: 6, height: 6)
            .opacity(on ? 1 : 0.3)
            .onAppear { withAnimation(.easeInOut(duration: 1).repeatForever()) { on = true } }
    }
}

// Fee card reveal: stagger lines with .transition(.opacity) and per-row delay

// MARK: - Écrans showroom

private struct LpspWiseShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspWiseFinanceHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspWiseFinanceCardsTabScreen()
                .tabItem { Label("Card", systemImage: "creditcard.fill") }
                .tag(1)
            LpspWiseFinanceHomeTabScreen()
                .tabItem { Label("Recipients", systemImage: "person.2.fill") }
                .tag(2)
            LpspWiseFinanceHomeTabScreen()
                .tabItem { Label("Payments", systemImage: "arrow.left.arrow.right") }
                .tag(3)
            LpspWiseFinanceHomeTabScreen()
                .tabItem { Label("Account", systemImage: "person.crop.circle.fill") }
                .tag(4)
        }
        .tint(LpspWiseTokens.wiseTextPrimary)
        
    }
}


private struct LpspWiseGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspWiseTokens.wiseTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspWiseTokens.wiseTextPrimary))
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


private struct LpspWiseFinanceHomeTabScreen: View {
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
                        .fill(LinearGradient(colors: [LpspWiseTokens.wiseTextPrimary, LpspWiseTokens.wiseTextPrimary.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 180)
                        .overlay(alignment: .bottomLeading) {
                            Text("•••• 4829").font(.title2.bold()).foregroundStyle(.white).padding(20)
                        }
                        .padding(.horizontal)
                    Text("Transactions").font(.headline).padding(.horizontal)
                    ForEach(LpspWiseDemoTx.items) { tx in
                        HStack {
                            Circle().fill(LpspWiseTokens.wiseTextPrimary.opacity(0.15)).frame(width: 40, height: 40)
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
            .background(LpspWiseTokens.wiseCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
        }
    }
}

private struct LpspWiseFinanceCardsTabScreen: View {
    var body: some View {
        NavigationStack {
            Text("Gérez vos cartes").padding().navigationTitle("Cartes")
        }
    }
}

private struct LpspWiseDemoTx: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let amount: String
    static let items: [LpspWiseDemoTx] = [
        .init(title: "Carrefour", date: "Aujourd'hui", amount: "-42,30 €"),
        .init(title: "Virement reçu", date: "Hier", amount: "+150,00 €"),
    ]
}


