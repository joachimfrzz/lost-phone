import SwiftUI

// MARK: - Tokens design système iOS

enum IOSSystemStyle {
    static let moduleCornerRadius: CGFloat = 24
    static let moduleFill = Color.white.opacity(0.16)
    static let moduleFillActive = Color.white.opacity(0.22)
    static let controlCircleSize: CGFloat = 48
    static let sliderWidth: CGFloat = 48
    static let sliderHeight: CGFloat = 178
    static let notificationCornerRadius: CGFloat = 18
}

// MARK: - Centre de contrôle (iOS 17)

struct ControlCenterOverlay: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var dragOffset: CGFloat = 0
    @State private var brightness: Double = 0.68
    @State private var volume: Double = 0.45
    @State private var airplaneMode = false
    @State private var cellularOn = true
    @State private var wifiOn = true
    @State private var bluetoothOn = true
    @State private var rotationLock = false
    @State private var focusOn = false
    @State private var silentMode = false
    @State private var flashlightOn = false

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.01)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            VStack(spacing: 0) {
                StatusBarView()
                    .padding(.top, 4)

                HStack(alignment: .top, spacing: 14) {
                    leftColumn
                    rightSliders
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)

                Spacer(minLength: 0)
            }
            .padding(.top, 4)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background { iosBlurBackground(darkness: 0.52) }
            .offset(y: dragOffset)
            .gesture(dismissGesture)
        }
    }

    private var leftColumn: some View {
        VStack(spacing: 12) {
            // Module connectivité — 4 icônes sans libellé (comme iOS)
            HStack(spacing: 0) {
                ccToggle(icon: "airplane", isOn: $airplaneMode, active: .orange)
                ccToggle(icon: "antenna.radiowaves.left.and.right", isOn: $cellularOn, active: .green)
                ccToggle(icon: "wifi", isOn: $wifiOn, active: .blue)
                ccToggle(icon: "bluetooth", isOn: $bluetoothOn, active: .blue)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .background(IOSSystemStyle.moduleFill, in: RoundedRectangle(cornerRadius: IOSSystemStyle.moduleCornerRadius, style: .continuous))

            // Lecture en cours
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.95, green: 0.35, blue: 0.45), Color(red: 0.55, green: 0.25, blue: 0.85)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 44, height: 44)
                    .overlay {
                        Image(systemName: "music.note")
                            .font(.body)
                            .foregroundStyle(.white)
                    }

                VStack(alignment: .leading, spacing: 2) {
                    Text(Fr.notPlaying)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    Text("Musique")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.55))
                }

                Spacer()

                HStack(spacing: 20) {
                    ccMediaButton("backward.fill")
                    ccMediaButton("play.fill", size: 18)
                    ccMediaButton("forward.fill")
                }
            }
            .padding(14)
            .background(IOSSystemStyle.moduleFill, in: RoundedRectangle(cornerRadius: IOSSystemStyle.moduleCornerRadius, style: .continuous))

            // Rangée de toggles ronds — icônes seules
            HStack(spacing: 0) {
                ccRoundIcon("lock.rotation", isOn: rotationLock, active: .red) { rotationLock.toggle() }
                ccRoundIcon("bell.slash.fill", isOn: silentMode, active: .red) { silentMode.toggle() }
                ccRoundIcon("moon.fill", isOn: focusOn, active: .indigo) { focusOn.toggle() }
                ccRoundIcon("flashlight.on.fill", isOn: flashlightOn, active: .white) { flashlightOn.toggle() }
            }

            // Grille 2×2 — icônes seules
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ccSquareIcon("timer")
                ccSquareIcon("calculator")
                ccSquareIcon("camera.fill")
                ccSquareIcon("qrcode.viewfinder")
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var rightSliders: some View {
        VStack(spacing: 16) {
            IOSSVerticalSlider(value: $brightness, topIcon: "sun.max.fill", bottomIcon: "sun.min.fill")
            IOSSVerticalSlider(value: $volume, topIcon: "speaker.wave.3.fill", bottomIcon: "speaker.fill")
        }
        .frame(width: IOSSystemStyle.sliderWidth)
    }

    @ViewBuilder
    private func ccToggle(icon: String, isOn: Binding<Bool>, active: Color) -> some View {
        Button {
            isOn.wrappedValue.toggle()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(isOn.wrappedValue ? .white : .white.opacity(0.85))
                .frame(maxWidth: .infinity)
                .frame(height: IOSSystemStyle.controlCircleSize)
                .background(isOn.wrappedValue ? active : Color.white.opacity(0.12), in: Circle())
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 4)
    }

    @ViewBuilder
    private func ccRoundIcon(_ icon: String, isOn: Bool, active: Color, action: @escaping () -> Void) -> some View {
        Button {
            action()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(isOn ? .white : .white.opacity(0.9))
                .frame(width: 52, height: 52)
                .background(isOn ? active.opacity(0.95) : IOSSystemStyle.moduleFill, in: Circle())
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func ccSquareIcon(_ icon: String) -> some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 64)
                .background(IOSSystemStyle.moduleFill, in: RoundedRectangle(cornerRadius: IOSSystemStyle.moduleCornerRadius, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private func ccMediaButton(_ icon: String, size: CGFloat = 15) -> some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: icon)
                .font(.system(size: size, weight: .semibold))
                .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
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

private struct IOSSVerticalSlider: View {
    @Binding var value: Double
    let topIcon: String
    let bottomIcon: String

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(Color.white.opacity(0.18))
                Capsule()
                    .fill(Color.white)
                    .frame(height: max(28, geo.size.height * value))
            }
            .overlay(alignment: .top) {
                Image(systemName: topIcon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.top, 12)
            }
            .overlay(alignment: .bottom) {
                Image(systemName: bottomIcon)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.black.opacity(0.45))
                    .padding(.bottom, 12)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let y = max(0, min(gesture.location.y, geo.size.height))
                        value = 1 - (y / geo.size.height)
                    }
            )
        }
        .frame(width: IOSSystemStyle.sliderWidth, height: IOSSystemStyle.sliderHeight)
    }
}

@ViewBuilder
func iosBlurBackground(darkness: Double) -> some View {
    ZStack {
        WallpaperView()
            .blur(radius: 50)
            .brightness(-0.08)
            .ignoresSafeArea()
        Rectangle()
            .fill(.ultraThinMaterial)
            .background(Color.black.opacity(darkness))
            .ignoresSafeArea()
    }
}
