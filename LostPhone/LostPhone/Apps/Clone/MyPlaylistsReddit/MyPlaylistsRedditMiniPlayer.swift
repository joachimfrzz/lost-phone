import SwiftUI

struct MyPlaylistsRedditMiniPlayer: View {
    @ObservedObject var player: MyPlaylistsRedditPlayer
    let queue: [LpspAppleMusicTrack]
    var namespace: Namespace.ID
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        if let track = player.currentTrack, !player.showFullPlayer {
            collapsedBar(track: track)
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }

        if player.showFullPlayer, let track = player.currentTrack {
            fullPlayer(track: track)
                .transition(.move(edge: .bottom))
                .zIndex(2)
        }
    }

    private func collapsedBar(track: LpspAppleMusicTrack) -> some View {
        HStack(spacing: 14) {
            artwork(for: track, size: 50)
                .matchedGeometryEffect(id: "artwork", in: namespace)

            Text(track.title)
                .font(.system(size: 17))
                .lineLimit(1)
                .matchedGeometryEffect(id: "title", in: namespace)

            Spacer(minLength: 0)

            HStack(spacing: 6) {
                if queue.first?.id != track.id {
                    controlButton("backward.fill", size: 22) {
                        player.previous(in: queue)
                    }
                }

                controlButton(player.isPlaying ? "pause.fill" : "play.fill", size: 24) {
                    player.togglePlayPause()
                }

                controlButton("forward.fill", size: 22) {
                    player.next(in: queue)
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .overlay(alignment: .top) {
            Rectangle().fill(Color(uiColor: .separator)).frame(height: 0.33)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                player.showFullPlayer = true
            }
        }
    }

    private func fullPlayer(track: LpspAppleMusicTrack) -> some View {
        ZStack {
            LinearGradient(
                colors: [.pink.opacity(0.45), .black.opacity(0.92)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {
                Capsule()
                    .fill(.white.opacity(0.35))
                    .frame(width: 36, height: 5)
                    .padding(.top, 8)

                artwork(for: track, size: 280)
                    .matchedGeometryEffect(id: "artwork", in: namespace)
                    .shadow(color: .black.opacity(0.35), radius: 18, y: 12)

                VStack(alignment: .leading, spacing: 6) {
                    Text(track.title)
                        .font(.system(size: 21, weight: .medium))
                        .foregroundStyle(.white)
                        .matchedGeometryEffect(id: "title", in: namespace)
                    Text(track.artist)
                        .font(.system(size: 19))
                        .foregroundStyle(.white.opacity(0.55))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)

                progressBar
                    .padding(.horizontal, 32)

                HStack(spacing: 48) {
                    if queue.first?.id != track.id {
                        controlButton("backward.fill", size: 30, light: true) {
                            player.previous(in: queue)
                        }
                    } else {
                        Color.clear.frame(width: 30, height: 30)
                    }

                    controlButton(player.isPlaying ? "pause.fill" : "play.fill", size: 44, light: true) {
                        player.togglePlayPause()
                    }

                    controlButton("forward.fill", size: 30, light: true) {
                        player.next(in: queue)
                    }
                }

                Spacer()
            }
        }
        .gesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    if value.translation.height > 80 {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.86)) {
                            player.showFullPlayer = false
                        }
                    }
                }
        )
    }

    private var progressBar: some View {
        VStack(spacing: 8) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(.white.opacity(0.25)).frame(height: 4)
                    Capsule()
                        .fill(.white.opacity(0.85))
                        .frame(width: geo.size.width * player.progress, height: 4)
                }
            }
            .frame(height: 8)

            HStack {
                Text("0:42")
                Spacer()
                Text("-2:58")
            }
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(.white.opacity(0.5))
        }
    }

    @ViewBuilder
    private func artwork(for track: LpspAppleMusicTrack, size: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: size > 100 ? 10 : 6.5, style: .continuous)
            .fill(MyPlaylistsRedditTheme.artworkGradient)
            .frame(width: size, height: size)
            .overlay {
                Image(systemName: "music.note")
                    .font(.system(size: size * 0.22, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.85))
            }
            .accessibilityLabel("\(track.title), \(track.artist)")
    }

    private func controlButton(
        _ symbol: String,
        size: CGFloat,
        light: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: size, weight: .semibold))
                .foregroundStyle(light ? .white : .primary)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
        .disabled(readOnly)
    }
}
