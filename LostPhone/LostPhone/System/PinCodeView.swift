import SwiftUI

struct PinCodeView: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var digits = ""

    var body: some View {
        ZStack {
            WallpaperView()
                .blur(radius: 18)
                .brightness(-0.15)
                .ignoresSafeArea()

            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer().frame(height: 80)
                Text("Entrez le code")
                    .font(.system(size: 17))
                    .foregroundStyle(.white)

                HStack(spacing: 22) {
                    ForEach(0..<4, id: \.self) { index in
                        Circle()
                            .strokeBorder(.white.opacity(0.45), lineWidth: 1.5)
                            .background(Circle().fill(index < digits.count ? .white : .clear))
                            .frame(width: 12, height: 12)
                    }
                }
                .modifier(ShakeEffect(shakes: phone.pinError ? 2 : 0))

                PinKeypadView { key in
                    if key == "delete" {
                        digits = String(digits.dropLast())
                    } else if digits.count < 4 {
                        digits += key
                        if digits.count == 4 {
                            phone.submitPin(digits)
                            digits = ""
                        }
                    }
                }

                Spacer()
            }
        }
    }
}

struct PinKeypadView: View {
    let onKey: (String) -> Void

    private let rows: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "delete"],
    ]

    var body: some View {
        VStack(spacing: 6) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 6) {
                    ForEach(row, id: \.self) { key in
                        if key.isEmpty {
                            Color.clear.frame(width: 78, height: 78)
                        } else {
                            Button {
                                onKey(key)
                            } label: {
                                Group {
                                    if key == "delete" {
                                        Image(systemName: "delete.left")
                                            .font(.system(size: 22))
                                    } else {
                                        Text(key)
                                            .font(.system(size: 32, weight: .light))
                                    }
                                }
                                .frame(width: 78, height: 78)
                                .foregroundStyle(.white)
                                .background(Circle().fill(.white.opacity(key == "delete" ? 0 : 0.12)))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

struct ShakeEffect: GeometryEffect {
    var shakes: CGFloat

    var animatableData: CGFloat {
        get { shakes }
        set { shakes = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: 10 * sin(shakes * .pi * 2), y: 0))
    }
}
