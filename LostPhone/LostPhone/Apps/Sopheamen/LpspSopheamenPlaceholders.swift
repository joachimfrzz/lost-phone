import SwiftUI

// MARK: - Grok (clone Flutter non intégré — UI chat simulée)

struct GrokContentRoot: View {
    @State private var prompt = ""
    @State private var messages: [(role: String, text: String)] = [
        ("grok", "Hey — I'm Grok. Ask me anything about the case.")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(messages.enumerated()), id: \.offset) { _, msg in
                            HStack {
                                if msg.role == "user" { Spacer() }
                                Text(msg.text)
                                    .font(.subheadline)
                                    .foregroundStyle(msg.role == "user" ? .white : .primary)
                                    .padding(12)
                                    .background(msg.role == "user" ? Color.black : Color(uiColor: .secondarySystemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                if msg.role == "grok" { Spacer() }
                            }
                        }
                    }
                    .padding()
                }
                HStack(spacing: 10) {
                    TextField("Message Grok…", text: $prompt)
                        .textFieldStyle(.roundedBorder)
                    Button("Send") { send() }
                        .buttonStyle(.borderedProminent)
                        .tint(.black)
                }
                .padding()
                .background(Color(uiColor: .systemBackground))
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Grok")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.light)
        }
    }

    private func send() {
        let text = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        messages.append(("user", text))
        prompt = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            messages.append(("grok", "Interesting. Based on what you shared: \"\(text)\" — I'd dig into messages and photos next."))
        }
    }
}

// MARK: - Tinder (clone Flutter non intégré — cartes simulées)

struct TinderContentRoot: View {
    @State private var index = 0
    private let profiles = [
        ("Léa", "28", "Art & coffee"),
        ("Marc", "31", "Runner, dog person"),
        ("Sofia", "26", "Travel & music")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if index < profiles.count {
                    let p = profiles[index]
                    VStack(alignment: .leading, spacing: 8) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(colors: [.pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(height: 380)
                            .overlay(alignment: .bottomLeading) {
                                VStack(alignment: .leading) {
                                    Text("\(p.0), \(p.1)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    Text(p.2)
                                        .foregroundStyle(.white.opacity(0.9))
                                }
                                .padding()
                            }
                    }
                    .padding(.horizontal)
                } else {
                    Text("Plus de profils pour l'instant")
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 32) {
                    Button { if index > 0 { index -= 1 } } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundStyle(.red)
                            .frame(width: 56, height: 56)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    Button { if index < profiles.count { index += 1 } } label: {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                            .foregroundStyle(.green)
                            .frame(width: 56, height: 56)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                }
                Spacer()
            }
            .padding(.top)
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Tinder")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.light)
        }
    }
}
