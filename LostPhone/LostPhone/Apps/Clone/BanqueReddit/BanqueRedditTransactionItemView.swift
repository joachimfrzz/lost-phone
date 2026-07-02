import SwiftUI

// Vendored depuis YT-BankingApp/View/TransactionItemView.swift — montants LPSP.

struct BanqueRedditTransactionItemView: View {
    let operation: LpspBankOperation

    private var style: (icon: String, color: Color) {
        BanqueRedditTheme.categoryStyle(for: operation.category)
    }

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: style.icon)
                .foregroundStyle(.white)
                .padding(5)
                .background(style.color)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            Text(operation.category.isEmpty ? "Opération" : operation.category)
                .font(.title3.weight(.bold))
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text(LpspThirdPartyFormat.money(operation.amount))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(operation.amount >= 0 ? .green : .primary)
        }
        .padding(25)
        .frame(width: 140)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.gray.opacity(0.35), lineWidth: 1)
        }
    }
}
