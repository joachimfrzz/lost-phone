import SwiftUI

// Vendored depuis RemindersClone/Views/ReminderCellView.swift — sans SwiftData.

struct RappelsRedditCellView: View {
    let item: LpspReminderItem
    var accent: Color = RappelsRedditTheme.accent
    var onSelect: (() -> Void)?

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: item.completed ? "circle.inset.filled" : "circle")
                .font(.title2)
                .foregroundStyle(item.completed ? Color(uiColor: .systemGray3) : accent)
                .padding(.trailing, 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .strikethrough(item.completed)
                    .foregroundStyle(item.completed ? .secondary : .primary)

                if !item.notes.isEmpty {
                    Text(item.notes)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                if !item.dueRaw.isEmpty {
                    HStack(spacing: 6) {
                        Text(RappelsRedditLPSP.formatDue(item.dueRaw))
                        let time = RappelsRedditLPSP.formatTime(item.dueRaw)
                        if !time.isEmpty {
                            Text(time)
                        }
                    }
                    .font(.caption)
                    .foregroundStyle(item.priority == "haute" ? .red : .secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onSelect?()
        }
        .padding(.vertical, 2)
    }
}

struct RappelsRedditListCellView: View {
    let list: LpspReminderList

    var body: some View {
        HStack(spacing: 14) {
            if list.emoji.count <= 2 {
                Text(list.emoji)
                    .font(.title2)
                    .frame(width: 32)
            } else {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(RappelsRedditTheme.listColor(named: list.colorName))
                    .frame(width: 32)
            }

            Text(list.name)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(list.items.filter { !$0.completed }.count)")
                .foregroundStyle(.secondary)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }
}
