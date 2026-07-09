//
//  FloatingButtonView.swift
//

import SwiftUI

struct FloatingButtonView: View {
    @Binding var promptText: String
    var onSubmit: (() -> Void)?

    var body: some View {
        HStack {
            HStack {
                TextField("Ask Gemini", text: $promptText)
                    .padding(.leading)
                    .onSubmit { onSubmit?() }
                HStack(spacing: 24) {
                    Button {} label: { Image(systemName: "mic") }
                    Button {} label: { Image(systemName: "camera") }
                }
                .foregroundStyle(.primary)
                .frame(width: 110, height: 48)
                .background(Color.hightLightColor)
                .clipShape(Capsule())
            }
            .padding(.trailing, 4)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .overlay(Capsule().stroke(.gray.opacity(0.2)))

            Button {} label: {
                ZStack {
                    Circle()
                        .fill(Color.hightLightColor)
                        .frame(width: 50, height: 50)
                    Image(systemName: "waveform")
                        .foregroundStyle(.primary)
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .background(Color(uiColor: .systemBackground))
        .shadow(color: .gray.opacity(0.15), radius: 10)
    }
}

#Preview {
    FloatingButtonView(promptText: .constant("Hello, World"))
}
