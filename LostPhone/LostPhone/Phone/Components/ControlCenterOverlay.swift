import SwiftUI

struct ControlCenterOverlay: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var dragOffset: CGFloat = 0
    @State private var brightness: Double = 0.72
    @State private var volume: Double = 0.48
    @State private var wifiOn = true
    @State private var cellularOn = true
    @State private var bluetoothOn = true
    @State private var airplaneMode = false
    @State private var rotationLock = false
    @State private var focusOn = false

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.15)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            VStack(spacing: 0) {
                Capsule()
                    .fill(.white.opacity(0.35))
                    .frame(width: 36, height: 5)
                    .padding(.top, 10)
                    .padding(.bottom, 14)

                HStack(alignment: .top, spacing: 14) {
                    leftModules
                    verticalSliders
                }
                .padding(.horizontal, 18)

                Spacer(minLength: 0)
            }
            .padding(.top, 44)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background { controlBackground }
            .offset(y: dragOffset)
            .gesture(dismissGesture)
        }
    }

    private var leftModules: some View {
        VStack(spacing: 12) {
            connectivityModule

            nowPlayingModule

            HStack(spacing: 12) {
                ControlCircleToggle(icon: "lock.rotation", label: "Verrouillage", isOn: $rotationLock, tint: .red)
                ControlCircleToggle(icon: "moon.fill", label: "Concentration", isOn: $focusOn, tint: .indigo)
                ControlCircleToggle(icon: "repeat", label: "Miroir", isOn: .constant(false), tint: .blue)
                ControlCircleToggle(icon: "flashlight.on.fill", label: "Lampe", isOn: .constant(false), tint: .gray)
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ControlQuickTile(icon: "timer", label: "Minuteur")
                ControlQuickTile(icon: "calculator", label: "Calculatrice")
                ControlQuickTile(icon: "camera.fill", label: "Appareil photo")
                ControlQuickTile(icon: "qrcode.viewfinder", label: "Code QR")
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var connectivityModule: some View {
        HStack(spacing: 0) {
            connectivityToggle(icon: "airplane", label: "Avion", isOn: $airplaneMode, tint: .orange)
            connectivityToggle(icon: "antenna.radiowaves.left.and.right", label: "Cellulaire", isOn: $cellularOn, tint: .green)
            connectivityToggle(icon: "wifi", label: "Wi‑Fi", isOn: $wifiOn, tint: .blue)
            connectivityToggle(icon: "bluetooth", label: "Bluetooth", isOn: $bluetoothOn, tint: .blue)
        }
        .padding(12)
        .background(.white.opacity(0.14), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private func connectivityToggle(icon: String, label: String, isOn: Binding<Bool>, tint: Color) -> some View {
        Button {
            isOn.wrappedValue.toggle()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: 52, height: 52)
                    .background(isOn.wrappedValue ? tint : .white.opacity(0.1), in: Circle())
                Text(label)
                    .font(.caption2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .foregroundStyle(isOn.wrappedValue ? .white : .white.opacity(0.65))
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }

    private var nowPlayingModule: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.pink.opacity(0.8), .purple.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 48, height: 48)
                .overlay {
                    Image(systemName: "music.note")
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 2) {
                Text("En lecture")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Aucune lecture")
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
                Text("Musique")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(spacing: 18) {
                ControlButton(icon: "backward.fill")
                ControlButton(icon: "play.fill", large: true)
                ControlButton(icon: "forward.fill")
            }
        }
        .padding(14)
        .background(.white.opacity(0.14), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private var verticalSliders: some View {
        VStack(spacing: 16) {
            VerticalControlSlider(
                value: $brightness,
                iconTop: "sun.max.fill",
                iconBottom: "sun.min.fill"
            )
            VerticalControlSlider(
                value: $volume,
                iconTop: "speaker.wave.3.fill",
                iconBottom: "speaker.fill"
            )
        }
        .frame(width: 54)
    }

    @ViewBuilder
    private var controlBackground: some View {
        ZStack {
            WallpaperView()
                .blur(radius: 40)
                .brightness(-0.2)
                .ignoresSafeArea()
            Rectangle()
                .fill(.ultraThinMaterial)
                .background(Color.black.opacity(0.48))
                .ignoresSafeArea()
        }
    }

    private var dismissGesture: some Gesture {
        DragGesture(minimumDistance: 8)
            .onChanged { value in
                dragOffset = min(0, value.translation.height)
            }
            .onEnded { value in
                if value.translation.height < -72 {
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

private struct VerticalControlSlider: View {
    @Binding var value: Double
    let iconTop: String
    let iconBottom: String

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(.white.opacity(0.14))
                Capsule()
                    .fill(.white.opacity(0.92))
                    .frame(height: max(24, geo.size.height * value))
            }
            .overlay(alignment: .top) {
                Image(systemName: iconTop)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.85))
                    .padding(.top, 10)
            }
            .overlay(alignment: .bottom) {
                Image(systemName: iconBottom)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.55))
                    .padding(.bottom, 10)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let y = max(0, min(gesture.location.y, geo.size.height))
                        value = 1 - (y / geo.size.height)
                    }
            )
        }
        .frame(width: 54, height: 160)
    }
}

private struct ControlCircleToggle: View {
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
                    .font(.body)
                    .frame(width: 44, height: 44)
                    .background(isOn ? tint : .white.opacity(0.12), in: Circle())
                Text(label)
                    .font(.system(size: 10))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
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
                .font(large ? .title3 : .footnote)
                .foregroundStyle(.white)
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
                    .font(.title3)
                Text(label)
                    .font(.caption2)
                    .lineLimit(1)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 68)
            .background(.white.opacity(0.14), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
