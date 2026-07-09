import SwiftUI

/// Appareil photo décoratif — pas d'accès caméra (évite les crashs simulateur / permissions).
struct CameraView: View {
    @State private var mode: CameraMode = .photo
    @State private var flashOn = false

    enum CameraMode { case photo, video }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button { flashOn.toggle() } label: {
                        Image(systemName: flashOn ? "bolt.fill" : "bolt.slash.fill")
                            .font(.system(size: 20))
                            .foregroundColor(flashOn ? .yellow : .white)
                    }
                    Spacer()
                    Image(systemName: "chevron.up")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                    Spacer()
                    Image(systemName: "livephoto")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 20)
                .background(LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom))

                Spacer()

                HStack(spacing: 20) {
                    ForEach([".5", "1x", "2", "5"], id: \.self) { label in
                        Text(label)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(label == "1x" ? .yellow : .white)
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 30)

                ZStack(alignment: .bottom) {
                    Color.black.ignoresSafeArea().frame(height: 150)

                    VStack(spacing: 15) {
                        HStack(spacing: 30) {
                            Button { mode = .video } label: {
                                Text("VIDEO")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(mode == .video ? .yellow : .white)
                            }
                            Button { mode = .photo } label: {
                                Text("PHOTO")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(mode == .photo ? .yellow : .white)
                            }
                        }
                        .padding(.top, 10)

                        HStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 48, height: 48)
                            Spacer()
                            Circle()
                                .strokeBorder(Color.white, lineWidth: 4)
                                .frame(width: 80, height: 80)
                                .overlay(Circle().fill(Color.white).frame(width: 70, height: 70))
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.15))
                                    .frame(width: 48, height: 48)
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .font(.system(size: 22, weight: .light))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
