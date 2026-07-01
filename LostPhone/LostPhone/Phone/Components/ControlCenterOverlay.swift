import SwiftUI

// MARK: - Centre de contrôle (iOS 17 pixel-accurate)

struct ControlCenterOverlay: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var dragOffset: CGFloat = 0
    @State private var brightness: Double = 0.68
    @State private var volume: Double = 0.45
    @State private var airplaneMode = false
    @State private var cellularOn = true
    @State private var wifiOn = true
    @State private var hotspotOn = false
    @State private var rotationLock = false
    @State private var silentMode = false
    @State private var focusOn = false
    @State private var flashlightOn = false

    var body: some View {
        GeometryReader { geo in
            let scale = geo.size.width / IOSMetrics.screenWidth
            let pad = IOSMetrics.ccHorizontalPadding * scale

            ZStack(alignment: .top) {
                Color.black.opacity(0.01)
                    .ignoresSafeArea()
                    .onTapGesture { dismiss() }

                VStack(spacing: 0) {
                    IOSOverlayStatusBar(scale: scale)
                        .padding(.top, IOSMetrics.statusBarTopPadding * scale)

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: IOSMetrics.ccGridSpacing * scale) {
                            topRow(scale: scale)
                            nowPlayingModule(scale: scale)
                            quickTogglesRow(scale: scale)
                            focusAndExtrasRow(scale: scale)
                        }
                        .padding(.horizontal, pad)
                        .padding(.top, 10 * scale)
                        .padding(.bottom, 48 * scale)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background { iosBlurBackground(darkness: 0.52) }
                .offset(y: dragOffset)
                .gesture(dismissGesture)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Centre de contrôle")
    }

    // MARK: - Row 1: Connectivité + sliders

    private func topRow(scale: CGFloat) -> some View {
        let mod = IOSMetrics.ccModuleSize * scale
        let gap = IOSMetrics.ccGridSpacing * scale
        let inner = IOSMetrics.ccConnectivityInner * scale
        let icon = IOSMetrics.ccConnectivityIcon * scale
        let sliderW = IOSMetrics.ccSliderWidth * scale
        let sliderH = IOSMetrics.ccSliderHeight * scale

        return HStack(alignment: .top, spacing: gap) {
            ccModule(width: mod, height: mod, scale: scale) {
                VStack(spacing: gap) {
                    HStack(spacing: gap) {
                        connectivityCell(
                            icon: "airplane",
                            color: IOSColors.systemOrange,
                            active: airplaneMode,
                            size: inner,
                            iconSize: icon,
                            scale: scale
                        ) { airplaneMode.toggle() }

                        connectivityCell(
                            icon: "antenna.radiowaves.left.and.right",
                            color: IOSColors.systemGreen,
                            active: cellularOn,
                            size: inner,
                            iconSize: icon,
                            scale: scale
                        ) { cellularOn.toggle() }
                    }
                    HStack(spacing: gap) {
                        connectivityCell(
                            icon: "wifi",
                            color: IOSColors.systemBlue,
                            active: wifiOn,
                            size: inner,
                            iconSize: icon,
                            scale: scale
                        ) { wifiOn.toggle() }

                        connectivityCell(
                            icon: "personalhotspot",
                            color: IOSColors.systemGreen,
                            active: hotspotOn,
                            size: inner,
                            iconSize: icon,
                            scale: scale
                        ) { hotspotOn.toggle() }
                    }
                }
            }

            ccVerticalSlider(
                icon: "sun.max.fill",
                value: $brightness,
                tint: IOSColors.systemYellow,
                width: sliderW,
                height: sliderH,
                scale: scale
            )

            ccVerticalSlider(
                icon: "speaker.wave.3.fill",
                value: $volume,
                tint: IOSColors.systemBlue,
                width: sliderW,
                height: sliderH,
                scale: scale
            )
        }
    }

    // MARK: - Now Playing

    private func nowPlayingModule(scale: CGFloat) -> some View {
        ccModule(width: nil, height: IOSMetrics.ccNowPlayingHeight * scale, scale: scale) {
            HStack(spacing: 12 * scale) {
                RoundedRectangle(cornerRadius: 8 * scale, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "5E5CE6"), Color(hex: "BF5AF2")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 48 * scale, height: 48 * scale)
                    .overlay {
                        Image(systemName: "music.note")
                            .font(.system(size: 20 * scale, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.9))
                    }

                VStack(alignment: .leading, spacing: 3 * scale) {
                    Text(Fr.notPlaying)
                        .font(.system(size: 15 * scale, weight: .semibold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    Text(Fr.ccTapToPlay)
                        .font(.system(size: 13 * scale))
                        .foregroundStyle(.white.opacity(0.55))
                        .lineLimit(1)
                }

                Spacer(minLength: 0)

                Image(systemName: "airplayaudio")
                    .font(.system(size: 18 * scale, weight: .medium))
                    .foregroundStyle(.white.opacity(0.55))
                    .frame(width: 36 * scale, height: 36 * scale)
            }
            .padding(.horizontal, 14 * scale)
        }
    }

    // MARK: - Toggles ronds

    private func quickTogglesRow(scale: CGFloat) -> some View {
        let mod = IOSMetrics.ccToggleSize * scale
        let gap = IOSMetrics.ccGridSpacing * scale

        return HStack(spacing: gap) {
            ccRoundToggle(
                icon: "lock.rotation",
                color: Color.white.opacity(0.92),
                active: rotationLock,
                activeTint: Color(hex: "FF453A"),
                size: mod,
                scale: scale
            ) { rotationLock.toggle() }

            ccRoundToggle(
                icon: "bell.slash.fill",
                color: Color.white.opacity(0.92),
                active: silentMode,
                activeTint: Color(hex: "FF453A"),
                size: mod,
                scale: scale
            ) { silentMode.toggle() }

            ccRoundToggle(
                icon: "moon.fill",
                color: Color.white.opacity(0.92),
                active: focusOn,
                activeTint: Color(hex: "5E5CE6"),
                size: mod,
                scale: scale
            ) { focusOn.toggle() }

            ccRoundToggle(
                icon: flashlightOn ? "flashlight.on.fill" : "flashlight.off.fill",
                color: Color.white.opacity(0.92),
                active: flashlightOn,
                activeTint: IOSColors.systemYellow,
                size: mod,
                scale: scale
            ) { flashlightOn.toggle() }

            Spacer(minLength: 0)
        }
    }

    // MARK: - Focus + extras

    private func focusAndExtrasRow(scale: CGFloat) -> some View {
        let mod = IOSMetrics.ccModuleSize * scale
        let gap = IOSMetrics.ccGridSpacing * scale
        let half = (mod - gap) / 2

        return HStack(spacing: gap) {
            ccModule(width: mod, height: mod, scale: scale) {
                VStack(spacing: 8 * scale) {
                    Image(systemName: "moon.fill")
                        .font(.system(size: 22 * scale, weight: .medium))
                        .foregroundStyle(.white.opacity(0.92))
                    Text(Fr.focus)
                        .font(.system(size: 13 * scale, weight: .medium))
                        .foregroundStyle(.white.opacity(0.92))
                }
            }

            ccModule(width: mod, height: mod, scale: scale) {
                VStack(spacing: gap) {
                    HStack(spacing: gap) {
                        ccSmallTile(icon: "timer", scale: scale, tileSize: half)
                        ccSmallTile(icon: "calculator", scale: scale, tileSize: half)
                    }
                    HStack(spacing: gap) {
                        ccSmallTile(icon: "camera.fill", scale: scale, tileSize: half)
                        ccSmallTile(icon: "qrcode.viewfinder", scale: scale, tileSize: half)
                    }
                }
            }

            Spacer(minLength: 0)
        }
    }

    // MARK: - Primitives

    @ViewBuilder
    private func ccModule<Content: View>(
        width: CGFloat?,
        height: CGFloat,
        scale: CGFloat,
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .frame(width: width, height: height)
            .frame(maxWidth: width == nil ? .infinity : width)
            .background(iosModuleBackground(cornerRadius: IOSMetrics.ccModuleRadius * scale))
    }

    private func connectivityCell(
        icon: String,
        color: Color,
        active: Bool,
        size: CGFloat,
        iconSize: CGFloat,
        scale: CGFloat,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            RoundedRectangle(cornerRadius: IOSMetrics.ccInnerRadius * scale, style: .continuous)
                .fill(active ? color : IOSColors.moduleFill)
                .frame(width: size, height: size)
                .overlay {
                    Image(systemName: icon)
                        .font(.system(size: iconSize, weight: .medium))
                        .foregroundStyle(active ? Color.black.opacity(0.85) : color)
                }
        }
        .buttonStyle(.plain)
    }

    private func ccRoundToggle(
        icon: String,
        color: Color,
        active: Bool,
        activeTint: Color,
        size: CGFloat,
        scale: CGFloat,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Circle()
                .fill(active ? activeTint : IOSColors.moduleFill)
                .frame(width: size, height: size)
                .overlay {
                    Image(systemName: icon)
                        .font(.system(size: 22 * scale, weight: .medium))
                        .foregroundStyle(active ? Color.black.opacity(0.85) : color)
                }
        }
        .buttonStyle(.plain)
    }

    private func ccSmallTile(icon: String, scale: CGFloat, tileSize: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: IOSMetrics.ccInnerRadius * scale, style: .continuous)
            .fill(IOSColors.moduleFill)
            .frame(width: tileSize, height: tileSize)
            .overlay {
                Image(systemName: icon)
                    .font(.system(size: 18 * scale, weight: .medium))
                    .foregroundStyle(.white.opacity(0.92))
            }
    }

    private func ccVerticalSlider(
        icon: String,
        value: Binding<Double>,
        tint: Color,
        width: CGFloat,
        height: CGFloat,
        scale: CGFloat
    ) -> some View {
        GeometryReader { geo in
            let h = geo.size.height
            let fillH = max(28 * scale, h * value.wrappedValue)

            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(IOSColors.moduleFill)

                Capsule()
                    .fill(tint)
                    .frame(height: fillH)

                VStack {
                    Spacer()
                    Image(systemName: icon)
                        .font(.system(size: 18 * scale, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.bottom, 14 * scale)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { g in
                        let v = 1 - (g.location.y / h)
                        value.wrappedValue = min(1, max(0, v))
                    }
            )
        }
        .frame(width: width, height: height)
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

// MARK: - Barre d'état (overlays NC / CC)

struct IOSOverlayStatusBar: View {
    let scale: CGFloat
    @EnvironmentObject private var phone: PhoneViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(phone.lockTime)
                .font(.system(size: IOSMetrics.statusBarTimeFont * scale, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 54 * scale, alignment: .leading)
                .padding(.leading, IOSMetrics.statusBarHorizontalPadding * scale)

            Spacer(minLength: 0)

            HStack(spacing: 5 * scale) {
                if cellularOn {
                    Image(systemName: "cellularbars")
                        .font(.system(size: IOSMetrics.statusBarIconFont * scale, weight: .semibold))
                }
                if wifiOn {
                    Image(systemName: "wifi")
                        .font(.system(size: IOSMetrics.statusBarIconFont * scale, weight: .semibold))
                }
                batteryIndicator(scale: scale)
            }
            .foregroundStyle(.white)
            .padding(.trailing, IOSMetrics.statusBarHorizontalPadding * scale)
        }
        .frame(height: IOSMetrics.statusBarHeight * scale)
    }

    private var cellularOn: Bool {
        phone.package?.content.system?.batterie?.lowercased() != "avion"
    }

    private var wifiOn: Bool { true }

    private var batteryLevel: Double {
        switch phone.package?.content.system?.batterie?.lowercased() {
        case "faible", "low": return 0.25
        case "charge", "charging": return 0.85
        default: return 0.72
        }
    }

    private func batteryIndicator(scale: CGFloat) -> some View {
        let w = IOSMetrics.statusBarBatteryWidth * scale
        let h = IOSMetrics.statusBarBatteryHeight * scale
        let fill = max(0.08, batteryLevel)

        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 2.5 * scale, style: .continuous)
                .strokeBorder(.white.opacity(0.35), lineWidth: 1)
                .frame(width: w, height: h)
            RoundedRectangle(cornerRadius: 1.5 * scale, style: .continuous)
                .fill(.white)
                .frame(width: max(0, (w - 4 * scale) * fill), height: h - 4 * scale)
                .padding(.leading, 2 * scale)
        }
        .frame(width: w + 2 * scale, height: h)
        .overlay(alignment: .trailing) {
            RoundedRectangle(cornerRadius: 0.5 * scale)
                .fill(.white.opacity(0.4))
                .frame(width: 1.5 * scale, height: 4 * scale)
                .offset(x: 2 * scale)
        }
    }
}

// MARK: - Fonds partagés

func iosModuleBackground(cornerRadius: CGFloat) -> some View {
    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .fill(IOSColors.moduleFill)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(Color.white.opacity(0.08), lineWidth: 0.5)
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
            .environment(\.colorScheme, .dark)
            .ignoresSafeArea()
    }
}
