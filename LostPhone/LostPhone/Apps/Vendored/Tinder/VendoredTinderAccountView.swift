import SwiftUI

struct VendoredTinderAccountView: View {
    private let profile = VendoredTinderData.account

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Color.gray.opacity(0.2).ignoresSafeArea()

                VStack(spacing: 15) {
                    Spacer(minLength: 40)

                    VendoredTinderBundledPhoto(imageName: profile.imageName)
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())

                    Text("\(profile.name), \(profile.age)")
                        .font(.system(size: 25, weight: .semibold))

                    HStack(spacing: 30) {
                        accountAction("gearshape", title: "SETTINGS")
                        addMediaButton
                        accountAction("pencil", title: "EDIT INFO")
                    }
                    .padding(.top, 20)

                    Spacer()
                }
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity)
                .frame(height: geo.size.height * 0.6)
                .background(
                    Color.white
                        .clipShape(VendoredTinderAccountCurve())
                        .shadow(color: .gray.opacity(0.1), radius: 10)
                )
            }
        }
    }

    private func accountAction(_ symbol: String, title: String) -> some View {
        VStack(spacing: 10) {
            Image(systemName: symbol)
                .font(.system(size: 35))
                .foregroundStyle(.gray.opacity(0.5))
                .frame(width: 60, height: 60)
                .background(Circle().fill(.white).shadow(color: .gray.opacity(0.1), radius: 10))
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.gray.opacity(0.8))
        }
    }

    private var addMediaButton: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottomTrailing) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                    .frame(width: 80, height: 80)
                    .background(VendoredTinderTheme.primaryGradient, in: Circle())
                    .shadow(color: .gray.opacity(0.1), radius: 10)
                Image(systemName: "plus")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(VendoredTinderTheme.primary)
                    .frame(width: 25, height: 25)
                    .background(Circle().fill(.white).shadow(color: .gray.opacity(0.1), radius: 8))
            }
            Text("ADD MEDIA")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.gray.opacity(0.8))
        }
        .padding(.top, 20)
    }
}

private struct VendoredTinderAccountCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: 0, y: rect.maxY),
            control: CGPoint(x: rect.midX, y: rect.maxY + rect.width * 0.15)
        )
        path.closeSubpath()
        return path
    }
}
