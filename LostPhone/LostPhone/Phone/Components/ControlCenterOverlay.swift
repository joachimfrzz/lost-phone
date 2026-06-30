import SwiftUI

struct ControlCenterOverlay: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var dragOffset: CGFloat = 0
    @State private var brightness: Double = 0.75
    @State private var volume: Double = 0.5
    @State private var wifiOn = true
    @State private var bluetoothOn = true
    @State private var airplaneMode = false

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Capsule()
                        .fill(.white.opacity(0.35))
                        .frame(width: 36, height: 5)
                    Spacer()
                }
                .padding(.top, 12)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ControlModule(title: "Connectivité") {
                        HStack(spacing: 12) {
                            ControlToggle(icon: "airplane", label: "Avion", isOn: $airplaneMode, tint: .orange)
                            ControlToggle(icon: "wifi", label: "Wi‑Fi", isOn: $wifiOn, tint: .blue)
                            ControlToggle(icon: "bluetooth", label: "BT", isOn: $bluetoothOn, tint: .blue)
                        }
                    }

                    ControlModule(title: "Lecture") {
                        HStack(spacing: 12) {
                            ControlButton(icon: "backward.fill")
                            ControlButton(icon: "play.fill", large: true)
                            ControlButton(icon: "forward.fill")
                        }
                        .frame(maxWidth: .infinity)
                    }

                    ControlModule(title: "Luminosité") {
                        HStack(spacing: 10) {
                            Image(systemName: "sun.min.fill")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Slider(value: $brightness, in: 0...1)
                                .tint(.white)
                            Image(systemName: "sun.max.fill")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    ControlModule(title: "Volume") {
                        HStack(spacing: 10) {
                            Image(systemName: "speaker.fill")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Slider(value: $volume, in: 0...1)
                                .tint(.white)
                            Image(systemName: "speaker.wave.3.fill")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    ControlQuickTile(icon: "flashlight.on.fill", label: "Lampe")
                    ControlQuickTile(icon: "timer", label: "Minuteur")
                    ControlQuickTile(icon: "calculator", label: "Calculatrice")
                    ControlQuickTile(icon: "camera.fill", label: "Appareil photo")
                }
                .padding(.horizontal, 16)

                Spacer(minLength: 0)
            }
            .padding(.top, 48)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .background(Color.black.opacity(0.55))
                    .ignoresSafeArea()
            }
            .offset(y: dragOffset)
            .gesture(dismissGesture)
        }
    }

    private var dismissGesture: some Gesture {
        DragGesture(minimumDistance: 8)
            .onChanged { value in
                dragOffset = min(0, value.translation.height)
            }
            .onEnded { value in
                if value.translation.height < -60 {
                    dismiss()
                } else {
                    withAnimation(.spring(duration: 0.32)) { dragOffset = 0 }
                }
            }
    }

    private func dismiss() {
        withAnimation(.spring(duration: 0.35)) {
            phone.closeOverlay()
        }
    }
}

private struct ControlModule<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
            content
        }
        .padding(14)
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
        .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}

private struct ControlToggle: View {
    let icon: String
    let label: String
    @Binding var isOn: Bool
    let tint: Color

    var body: some View {
        Button {
            isOn.toggle()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.title3)
                Text(label)
                    .font(.caption2)
            }
            .foregroundStyle(isOn ? .white : .secondary)
            .frame(width: 56, height: 56)
            .background(isOn ? tint : .white.opacity(0.08), in: Circle())
        }
        .buttonStyle(.plain)
    }
}

private struct ControlButton: View {
    let icon: String
    var large = false

    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: icon)
                .font(large ? .title2 : .body)
                .foregroundStyle(.white)
                .frame(width: large ? 52 : 40, height: large ? 52 : 40)
                .background(.white.opacity(0.15), in: Circle())
        }
        .buttonStyle(.plain)
    }
}

private struct ControlQuickTile: View {
    let icon: String
    let label: String

    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                Text(label)
                    .font(.caption2)
                    .lineLimit(1)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 72)
            .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
