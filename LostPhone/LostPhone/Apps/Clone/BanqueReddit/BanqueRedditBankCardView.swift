import SwiftUI

// Vendored depuis YT-BankingApp/View/BankCardView.swift — données LPSP.

struct BanqueRedditBankCardView: View {
    let account: LpspBankAccount
    let bankLabel: String
    let cardPartial: String

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 32))
                            .foregroundStyle(.black.opacity(0.75))

                        Spacer()

                        HStack {
                            Text(account.type)
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                            Image(systemName: "eye")
                                .font(.system(size: 13))
                        }

                        Text(LpspThirdPartyFormat.money(account.balance, currency: account.currency))
                            .padding(.top, 1)
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(account.balance < 0 ? .red : .primary)

                        if !account.partialNumber.isEmpty {
                            Text(account.partialNumber)
                                .font(.caption.monospaced())
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .trailing) {
                        Label {
                            Text(bankLabel)
                                .fontWeight(.bold)
                        } icon: {
                            Image(systemName: "building.columns.fill")
                        }
                        Spacer()
                        Text("VISA")
                            .font(.headline.weight(.black))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                        if !cardPartial.isEmpty {
                            Text("•••• \(cardPartial.suffix(4))")
                                .font(.caption2.monospaced())
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(BanqueRedditTheme.green)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .padding(.horizontal)
    }
}
