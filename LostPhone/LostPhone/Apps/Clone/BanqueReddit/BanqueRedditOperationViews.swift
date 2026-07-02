import SwiftUI

struct BanqueRedditOperationsList: View {
    let operations: [LpspBankOperation]
    let onSelect: (LpspBankOperation) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Opérations")
                .font(.title2.weight(.bold))
                .padding(.horizontal, 30)
                .padding(.top, 24)
                .padding(.bottom, 12)

            ForEach(LpspThirdPartyGrouping.byDay(operations) { $0.date }, id: \.0) { section, items in
                Text(section.uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 8)

                ForEach(items) { op in
                    Button { onSelect(op) } label: {
                        BanqueRedditOperationRow(operation: op)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.bottom, 24)
    }
}

struct BanqueRedditOperationRow: View {
    let operation: LpspBankOperation

    private var style: (icon: String, color: Color) {
        BanqueRedditTheme.categoryStyle(for: operation.category)
    }

    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(style.color.opacity(0.14))
                .frame(width: 42, height: 42)
                .overlay {
                    Image(systemName: style.icon)
                        .font(.body)
                        .foregroundStyle(style.color)
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
        .padding(.horizontal, 30)
        .padding(.vertical, 11)
        .background(Color(uiColor: .systemBackground))
    }
}

struct BanqueRedditOperationSheet: View {
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
