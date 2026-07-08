import SwiftUI

/// Port de `explore_detail_page.dart` — fiche profil plein écran.
struct VendoredTinderExploreDetailView: View {
    let profile: VendoredTinderProfile
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ZStack(alignment: .bottomTrailing) {
                    VendoredTinderBundledPhoto(imageName: profile.imageName)
                        .frame(height: 450)
                        .frame(maxWidth: .infinity)
                        .clipped()

                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                            .background(VendoredTinderTheme.primaryGradient, in: Circle())
                    }
                    .padding(15)
                }

                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .firstTextBaseline, spacing: 5) {
                        Text(profile.name)
                            .font(.system(size: 35, weight: .bold))
                        Text(profile.age)
                            .font(.system(size: 28, weight: .medium))
                    }

                    labelRow(symbol: "info.circle", text: "Royal University of Phnom Penh")
                    labelRow(symbol: "mappin.and.ellipse", text: "1 kilometer away")

                    FlowLayout(spacing: 10) {
                        ForEach(Array(profile.likes.enumerated()), id: \.offset) { index, tag in
                            Text(tag)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(index == 0 ? VendoredTinderTheme.primary : .gray)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .overlay {
                                    Capsule()
                                        .stroke(index == 0 ? VendoredTinderTheme.primary : Color.gray, lineWidth: 2)
                                }
                        }
                    }

                    Divider()
                    Text("Fun and Crazy")
                        .font(.system(size: 20))
                        .foregroundStyle(.black.opacity(0.5))
                    Divider()
                }
                .padding(.horizontal, 25)

                HStack(spacing: 30) {
                    detailAction("xmark", size: 58, tint: VendoredTinderTheme.primary)
                    detailAction("star.fill", size: 45, tint: .blue)
                    detailAction("heart.fill", size: 57, tint: VendoredTinderTheme.likeGreen)
                }
                .padding(.vertical, 30)
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }

    private func labelRow(symbol: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: symbol)
                .foregroundStyle(.black.opacity(0.5))
                .padding(.top, 4)
            Text(text)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.black.opacity(0.5))
        }
    }

    private func detailAction(_ symbol: String, size: CGFloat, tint: Color) -> some View {
        Image(systemName: symbol)
            .font(.system(size: size * 0.4, weight: .bold))
            .foregroundStyle(tint)
            .frame(width: size, height: size)
            .background(Circle().fill(.white).shadow(color: .gray.opacity(0.1), radius: 10))
    }
}

/// Simple flow layout for passion tags.
private struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, frame) in result.frames.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY), proposal: .unspecified)
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, frames: [CGRect]) {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var frames: [CGRect] = []

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            frames.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
        return (CGSize(width: maxWidth, height: y + rowHeight), frames)
    }
}
