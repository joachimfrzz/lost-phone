import SwiftUI

// Wallet — spec Meliwat/awesome-ios-design-md/finance/apple-wallet (fruvs sans sources Swift)
struct WalletCloneAppView: View {
    @State private var expandedIndex: Int? = nil
    @Namespace private var cardNS

    var body: some View {
        ZStack {
            Color.walletCanvas.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Text("Wallet")
                        .font(.walletTitle)
                        .foregroundStyle(.walletTextPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 24)

                    cardStack
                        .padding(.horizontal, 16)

                    transactionsSection
                        .padding(.top, 32)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    private var cardStack: some View {
        ZStack(alignment: .top) {
            ForEach(0..<3, id: \.self) { idx in
                cardView(index: idx)
                    .offset(y: expandedIndex == nil ? CGFloat(idx) * 80 : (expandedIndex == idx ? 0 : CGFloat(idx) * 12 + 240))
                    .zIndex(expandedIndex == idx ? 10 : Double(3 - idx))
                    .onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            expandedIndex = expandedIndex == idx ? nil : idx
                        }
                    }
            }
        }
        .frame(height: expandedIndex == nil ? 320 : 520)
    }

    @ViewBuilder
    private func cardView(index: Int) -> some View {
        switch index {
        case 0:
            AppleCardFace(cardholder: "LOST PHONE", dailyCashBalance: "$12.40")
        case 1:
            CreditCardFace(
                issuer: "Chase",
                last4: "4521",
                cardholder: "LOST PHONE",
                networkLogo: "creditcard.fill",
                background: LinearGradient(
                    colors: [.walletChaseBlue, .walletChaseBlue.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        default:
            CreditCardFace(
                issuer: "Amex",
                last4: "1004",
                cardholder: "LOST PHONE",
                networkLogo: "creditcard.fill",
                background: LinearGradient(
                    colors: [.walletAmexSilver, .walletTitaniumLo],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
    }

    private var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("LATEST TRANSACTIONS")
                .font(.walletSectionHdr)
                .foregroundStyle(.walletTextSecondary)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)

            TransactionRow(merchant: "Apple Store", date: "Today", amount: "-$129.00", dailyCash: "+$1.29")
            TransactionRow(merchant: "Uber", date: "Yesterday", amount: "-$18.40", dailyCash: nil)
            TransactionRow(merchant: "Daily Cash", date: "Jun 28", amount: "+$2.15", dailyCash: nil)
        }
    }
}

struct LpspWalletView: View {
    var body: some View {
        WalletCloneAppView()
    }
}

// MARK: - Tokens (apple-wallet DESIGN-swiftui.md)

private extension Color {
    static let walletCanvas = Color(red: 0.00, green: 0.00, blue: 0.00)
    static let walletSurface1 = Color(red: 0.110, green: 0.110, blue: 0.118)
    static let walletTextPrimary = Color.white
    static let walletTextSecondary = Color(red: 0.627, green: 0.627, blue: 0.647)
    static let walletTitaniumHi = Color(red: 0.910, green: 0.910, blue: 0.922)
    static let walletTitaniumMid = Color(red: 0.659, green: 0.659, blue: 0.678)
    static let walletTitaniumLo = Color(red: 0.239, green: 0.239, blue: 0.247)
    static let walletChipGold = Color(red: 0.780, green: 0.675, blue: 0.451)
    static let walletDailyCash = Color(red: 1.00, green: 0.231, blue: 0.188)
    static let walletChaseBlue = Color(red: 0.102, green: 0.176, blue: 0.310)
    static let walletAmexSilver = Color(red: 0.655, green: 0.690, blue: 0.718)
    static let walletHairline = Color(red: 0.149, green: 0.149, blue: 0.161)
}

private extension Font {
    static let walletTitle = Font.system(size: 34, weight: .bold)
    static let walletSectionHdr = Font.system(size: 13, weight: .semibold)
    static let walletBody = Font.system(size: 17, weight: .regular)
    static let walletBodyMedium = Font.system(size: 17, weight: .medium).monospacedDigit()
    static let walletFootnote = Font.system(size: 13, weight: .regular)
    static let walletCaption = Font.system(size: 11, weight: .regular)
    static let walletCardHolder = Font.system(size: 13, weight: .medium)
}

private struct AppleCardFace: View {
    let cardholder: String
    let dailyCashBalance: String

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.walletTitaniumHi, .walletTitaniumMid, .walletTitaniumLo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.walletChipGold)
                        .frame(width: 26, height: 20)
                    Spacer()
                    Image(systemName: "applelogo")
                        .font(.system(size: 24))
                        .foregroundStyle(.white)
                }
                Spacer()
                HStack(alignment: .bottom) {
                    Text(cardholder.uppercased())
                        .font(.walletCardHolder)
                        .foregroundStyle(Color(red: 0.10, green: 0.10, blue: 0.10))
                    Spacer()
                    Text(dailyCashBalance)
                        .font(.walletBodyMedium)
                        .foregroundStyle(.walletDailyCash)
                }
            }
            .padding(16)
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.5), radius: 12, y: 8)
    }
}

private struct CreditCardFace: View {
    let issuer: String
    let last4: String
    let cardholder: String
    let networkLogo: String
    let background: LinearGradient

    var body: some View {
        ZStack {
            background
            VStack(alignment: .leading) {
                HStack {
                    Text(issuer)
                        .font(.walletBody)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: networkLogo)
                        .foregroundStyle(.white)
                }
                Spacer()
                Text("•••• \(last4)")
                    .font(.system(size: 17, weight: .medium, design: .monospaced))
                    .foregroundStyle(.white)
                Text(cardholder.uppercased())
                    .font(.walletCardHolder)
                    .foregroundStyle(.white.opacity(0.85))
            }
            .padding(16)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.4), radius: 10, y: 6)
    }
}

private struct TransactionRow: View {
    let merchant: String
    let date: String
    let amount: String
    let dailyCash: String?

    var body: some View {
        HStack {
            Circle()
                .fill(Color.walletSurface1)
                .frame(width: 32, height: 32)
                .overlay(Image(systemName: "cart.fill").foregroundStyle(.white).font(.system(size: 14)))
            VStack(alignment: .leading, spacing: 2) {
                Text(merchant).font(.walletBody).foregroundStyle(.white)
                Text(date).font(.walletFootnote).foregroundStyle(.walletTextSecondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(amount).font(.walletBodyMedium).foregroundStyle(.white)
                if let dc = dailyCash {
                    Text("Daily Cash \(dc)")
                        .font(.walletCaption)
                        .foregroundStyle(.walletDailyCash)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.walletSurface1)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.walletHairline).frame(height: 0.5).padding(.leading, 16)
        }
    }
}
