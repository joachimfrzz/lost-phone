//
//  PlaygroundWaveStack.swift
//  voice memos clone swiftui
//

import SwiftUI

struct PlaygroundWaveStack: View {
    let generatedMeter: [CGFloat]

    private var bars: [CGFloat] {
        if generatedMeter.isEmpty {
            return (0..<40).map { index in
                CGFloat(12 + (index % 7) * 4)
            }
        }
        return generatedMeter
    }

    var body: some View {
        HStack(alignment: .center, spacing: 3) {
            ForEach(Array(bars.enumerated()), id: \.offset) { _, height in
                Capsule()
                    .fill(DictaphoneAppTheme.waveActive)
                    .frame(width: 3, height: height)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
