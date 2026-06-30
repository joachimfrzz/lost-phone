import SwiftUI

/// Écran d'accueil du jeu Lost Phone — avant d'entrer dans le téléphone du protagoniste.
struct GameHomeView: View {
    @EnvironmentObject private var phone: PhoneViewModel
    let stories: [StoryEntry]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.04, green: 0.05, blue: 0.12),
                    Color(red: 0.08, green: 0.1, blue: 0.18),
                    Color.black,
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer(minLength: 48)

                VStack(spacing: 10) {
                    Image(systemName: "iphone.gen3")
                        .font(.system(size: 52, weight: .thin))
                        .foregroundStyle(.white.opacity(0.9))
                        .symbolEffect(.pulse, options: .repeating.speed(0.35))

                    Text("Lost Phone")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text("Un téléphone trouvé. Une histoire à découvrir.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.65))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                Spacer(minLength: 36)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Choisir une histoire")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.45))
                        .textCase(.uppercase)
                        .padding(.horizontal, 4)

                    if stories.isEmpty {
                        ContentUnavailableView(
                            "Aucune histoire",
                            systemImage: "book.closed",
                            description: Text("Ajoutez un dossier stories/<id>/lpsp.json dans le bundle.")
                        )
                        .foregroundStyle(.white)
                    } else {
                        ForEach(stories) { story in
                            Button {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                Task { await phone.startStory(story.id) }
                            } label: {
                                StoryCard(story: story)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 24)

                Spacer(minLength: 48)

                Text("Explorez le téléphone. Recoupez les indices. Ne modifiez rien.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.35))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 24)
            }
        }
    }
}

private struct StoryCard: View {
    let story: StoryEntry

    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(red: 0.2, green: 0.45, blue: 0.95), Color(red: 0.35, green: 0.2, blue: 0.85)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 52, height: 52)
                .overlay {
                    Image(systemName: "doc.text.fill")
                        .font(.title3)
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(story.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                if let subtitle = story.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.55))
                        .lineLimit(1)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.35))
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.white.opacity(0.08))
                .overlay {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(.white.opacity(0.12), lineWidth: 0.5)
                }
        }
    }
}
