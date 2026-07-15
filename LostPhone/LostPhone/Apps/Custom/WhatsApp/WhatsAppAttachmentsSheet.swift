import SwiftUI

struct WhatsAppAttachmentsSheet: View {
    @Environment(\.dismiss) private var dismiss

    private let options: [(String, String)] = [
        ("Photos", "photo.on.rectangle"),
        ("Caméra", "camera"),
        ("Localisation", "location"),
        ("Contact", "person.crop.circle"),
        ("Document", "doc"),
        ("Sondage", "chart.bar"),
        ("Événement", "calendar"),
    ]

    var body: some View {
        NavigationStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 88))], spacing: 20) {
                ForEach(options, id: \.0) { option in
                    VStack(spacing: 8) {
                        Image(systemName: option.1)
                            .font(.title2)
                            .frame(width: 56, height: 56)
                            .background(WhatsAppTheme.header)
                            .clipShape(Circle())
                        Text(option.0)
                            .font(.caption)
                    }
                    .foregroundStyle(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(WhatsAppTheme.background)
            .navigationTitle("Pièces jointes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fermer") { dismiss() }
                        .foregroundStyle(WhatsAppTheme.accent)
                }
            }
        }
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WhatsAppAttachmentsSheet()
}
