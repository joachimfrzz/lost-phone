import SwiftUI

// Clone app bancaire mobile (style Crédit Agricole / LCL) — read-only LPSP.

struct LpspBanqueView: View {
    let data: LpspBankData?
    @State private var selectedOp: LpspBankOperation?
    @State private var tab = "accounts"

    private let tabs: [TierIOSTabBar.Item] = [
        .init(id: "accounts", icon: "creditcard", label: "Comptes"),
        .init(id: "transfer", icon: "arrow.left.arrow.right", label: "Virements"),
        .init(id: "more", icon: "ellipsis", label: "Plus"),
    ]

    var body: some View {
        TierCloneShell {
            TierIOSTabBar(items: tabs, selected: tab, accent: LpspThirdPartyBrand.banqueGreen)
        } content: {
            NavigationStack {
                Group {
                    if let data {
                        ScrollView {
                            VStack(spacing: 0) {
                                banqueHeader(data)
                                operationsList(data.operations)
                            }
                        }
                        .background(Color(uiColor: .systemGroupedBackground))
                    } else {
                        ContentUnavailableView("Banque", systemImage: "building.columns.fill")
                    }
                }
                .navigationTitle(LpspAppCatalog.displayName("Banque"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(LpspThirdPartyBrand.banqueGreen, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {} label: { Image(systemName: "bell") }
                            .disabled(true)
                    }
                }
                .sheet(item: $selectedOp) { op in
                    BanqueOperationSheet(operation: op)
                }
            }
        }
        .tint(.white)
    }

    @ViewBuilder
    private func banqueHeader(_ data: LpspBankData) -> some View {
        ZStack(alignment: .bottom) {
            LpspThirdPartyBrand.banqueGreen
                .frame(height: 300)

            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Bonjour, \(data.holderName.components(separatedBy: " ").first ?? data.holderName)")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)
                    if !data.branch.isEmpty {
                        Text(data.branch)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                            .lineLimit(2)
                    }
                }

                ForEach(data.accounts) { account in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(account.type)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(LpspThirdPartyFormat.money(account.balance, currency: account.currency))
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(account.balance < 0 ? .red : .primary)
                        Text(account.partialNumber)
                            .font(.caption.monospaced())
                            .foregroundStyle(.secondary)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                }

                if !data.cardPartial.isEmpty {
                    HStack(spacing: 14) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(LinearGradient(colors: [LpspThirdPartyBrand.banqueGreen, .black.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 52, height: 34)
                            .overlay { Image(systemName: "wave.3.right").font(.caption2).foregroundStyle(.white) }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Visa •••• \(data.cardPartial.suffix(4))")
                                .font(.caption.weight(.semibold))
                            Text("Carte active")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(14)
                    .background(.white.opacity(0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
    }

    @ViewBuilder
    private func operationsList(_ ops: [LpspBankOperation]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Opérations")
                .font(.title2.weight(.bold))
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 12)

            ForEach(LpspThirdPartyGrouping.byDay(ops) { $0.date }, id: \.0) { section, items in
                Text(section.uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)

                ForEach(items) { op in
                    Button { selectedOp = op } label: {
                        BanqueOperationRow(operation: op)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.bottom, 24)
    }
}

private struct BanqueOperationRow: View {
    let operation: LpspBankOperation

    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(categoryColor.opacity(0.14))
                .frame(width: 42, height: 42)
                .overlay {
                    Image(systemName: categoryIcon)
                        .font(.body)
                        .foregroundStyle(categoryColor)
                }
            VStack(alignment: .leading, spacing: 3) {
                Text(operation.label)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                Text(operation.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 8)
            Text(LpspThirdPartyFormat.money(operation.amount))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(operation.amount >= 0 ? Color.green : .primary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 11)
        .background(Color(uiColor: .systemBackground))
    }

    private var categoryIcon: String {
        switch operation.category.lowercased() {
        case let c where c.contains("restauration"): return "fork.knife"
        case let c where c.contains("transport"): return "car.fill"
        case let c where c.contains("abonnement"): return "repeat"
        default: return "creditcard.fill"
        }
    }

    private var categoryColor: Color { LpspThirdPartyBrand.banqueGreen }
}

private struct BanqueOperationSheet: View {
    let operation: LpspBankOperation
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(LpspThirdPartyFormat.money(operation.amount))
                        .font(.largeTitle.weight(.bold))
                        .frame(maxWidth: .infinity)
                        .listRowBackground(Color.clear)
                }
                Section {
                    LabeledContent("Libellé", value: operation.label)
                    LabeledContent("Catégorie", value: operation.category)
                    LabeledContent("Date", value: LpspThirdPartyFormat.frenchDateRaw(operation.dateRaw))
                }
            }
            .navigationTitle("Détail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}
