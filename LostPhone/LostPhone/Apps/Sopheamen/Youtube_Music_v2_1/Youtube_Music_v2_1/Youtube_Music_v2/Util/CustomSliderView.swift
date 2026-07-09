//
//  CustomSliderView.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 5/9/24.
//
import SwiftUI

struct CustomSliderView: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let thumbSize: CGFloat
    let trackHeight: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.6))
                    .frame(height: trackHeight)
                
                Capsule()
                    .fill(Color.white)
                    .frame(width: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * geometry.size.width, height: trackHeight)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: thumbOffset(geometry: geometry))
                    .gesture(
                        DragGesture()
                            .onChanged { dragValue in
                                let sliderWidth = geometry.size.width
                                let newValue = (dragValue.location.x / sliderWidth) * (range.upperBound - range.lowerBound) + range.lowerBound
                                value = min(max(range.lowerBound, newValue), range.upperBound)
                            }
                    )
            }
        }
        .frame(height: thumbSize)
    }
    
    private func thumbOffset(geometry: GeometryProxy) -> CGFloat {
        let sliderWidth = geometry.size.width
        let relativeValue = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
        return relativeValue * sliderWidth - thumbSize / 2
    }
}

