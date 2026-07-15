import SwiftUI

struct WhatsAppCallsView: View {
    private let calls = WhatsAppSampleData.calls

    var body: some View {
        NavigationStack {
            List(calls) { call in
                HStack(spacing: 12) {
                    WhatsAppAvatar(title: call.contact.name)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(call.contact.name)
                            .foregroundStyle(.white)
                        HStack(spacing: 6) {
                            Image(systemName: icon(for: call))
                                .foregroundStyle(call.direction == .missed ? .red : WhatsAppTheme.secondaryText)
                            Text(call.dateLabel)
                                .font(.subheadline)
                                .foregroundStyle(WhatsAppTheme.secondaryText)
                        }
                    }
                    Spacer()
                    Image(systemName: call.kind == .video ? "video" : "phone")
                        .foregroundStyle(WhatsAppTheme.accent)
                }
                .listRowBackground(WhatsAppTheme.listBackground)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(WhatsAppTheme.listBackground)
            .navigationTitle("Appels")
            .toolbarBackground(WhatsAppTheme.header, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    private func icon(for call: WhatsAppCall) -> String {
        switch call.direction {
        case .incoming: return "phone.arrow.down.left"
        case .outgoing: return "phone.arrow.up.right"
        case .missed: return "phone.down"
        }
    }
}

#Preview {
    WhatsAppCallsView()
}
