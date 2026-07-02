import SwiftUI

// Point d'entrée Lost Phone — clone GeraudLuku/YT-BankingApp + LPSP J-3.
// Source vendored : https://github.com/GeraudLuku/YT-BankingApp

struct BanqueRedditAppView: View {
    let data: LpspBankData?
    @State private var selectedOp: LpspBankOperation?
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            cardStack(data)
                            transferRow(data)
                            transactionsCarousel(data.operations)
                            BanqueRedditOperationsList(operations: data.operations) { op in
                                selectedOp = op
                            }
                        }
                    }
                    .background(Color(uiColor: .systemGroupedBackground))
                } else {
                    ContentUnavailableView("Banque", systemImage: "building.columns.fill")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    if let data {
                        Text("Bonjour")
                            .font(.system(size: 28, weight: .light))
                        Text(data.holderName.components(separatedBy: " ").first ?? data.holderName)
                            .font(.system(size: 28, weight: .bold))
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Image(systemName: "bell.badge")
                        .foregroundStyle(.red, .primary)
                    if let data {
                        BanqueRedditAvatarView(
                            initials: String(data.holderName.prefix(2)).uppercased(),
                            size: 44
                        )
                    }
                }
            }
            .sheet(item: $selectedOp) { op in
                BanqueRedditOperationSheet(operation: op)
            }
        }
    }

    @ViewBuilder
    private func cardStack(_ data: LpspBankData) -> some View {
        VStack {
            if let account = data.accounts.first {
                BanqueRedditBankCardView(
                    account: account,
                    bankLabel: bankLabel(from: data),
                    cardPartial: data.cardPartial
                )
                .zIndex(1)
            }
            BanqueRedditShareCardView(initials: contactInitials(from: data))
                .offset(y: -70)
        }
        .padding(.top, 8)
        .padding(.bottom, -40)
    }

    @ViewBuilder
    private func transferRow(_ data: LpspBankData) -> some View {
        Text("Montant")
            .font(.title3.weight(.bold))
            .padding(.horizontal, 30)
            .padding(.bottom, 5)

        HStack {
            if let account = data.accounts.first {
                Text(LpspThirdPartyFormat.money(abs(account.balance), currency: account.currency))
                    .font(.system(size: 25, weight: .bold))
                    .foregroundStyle(account.balance < 0 ? .red : .primary)
            }
            Spacer()
            Image(systemName: "arrow.forward")
                .foregroundStyle(.black)
                .padding(.vertical)
                .padding(.horizontal, 40)
                .background(BanqueRedditTheme.green)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .padding(.horizontal, 30)
        .opacity(readOnly ? 0.85 : 1)
        .allowsHitTesting(false)

        Divider()
            .padding(.horizontal, 30)
            .padding(.bottom)
    }

    @ViewBuilder
    private func transactionsCarousel(_ operations: [LpspBankOperation]) -> some View {
        HStack {
            Text("Transactions")
                .font(.title3.weight(.bold))
            Spacer()
            Text("Tout voir")
                .font(.footnote)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 30)

        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(Array(operations.prefix(8))) { op in
                    Button { selectedOp = op } label: {
                        BanqueRedditTransactionItemView(operation: op)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 8)
        }
    }

    private func bankLabel(from data: LpspBankData) -> String {
        if data.branch.contains("LCL") { return "LCL" }
        let parts = data.branch.split(separator: " ")
        if let first = parts.first, first.count <= 12 {
            return String(first)
        }
        return LpspAppCatalog.displayName("Banque")
    }

    private func contactInitials(from data: LpspBankData) -> [String] {
        var set: [String] = []
        let holder = data.holderName.split(separator: " ").prefix(2).map { String($0.prefix(1)).uppercased() }.joined()
        if !holder.isEmpty { set.append(holder) }
        for op in data.operations.prefix(4) {
            let token = op.label.split(separator: " ").first.map { String($0.prefix(2)).uppercased() } ?? "??"
            if !set.contains(token) { set.append(token) }
        }
        while set.count < 5 {
            set.append(["AB", "CD", "EF", "GH", "IJ"][set.count])
        }
        return set
    }
}

/// Route LPSP — même nom qu'avant pour le router.
struct LpspBanqueView: View {
    let data: LpspBankData?

    var body: some View {
        BanqueRedditAppView(data: data)
    }
}
