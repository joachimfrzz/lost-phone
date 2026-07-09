//
//  File.swift
//  SpotifySwiftUI
//
//  Created by ladans on 26/08/25.
//

import SwiftUI

extension VendoredSpotifyBaseView {
    func onChange(sideMenuWidth: CGFloat) {
        let newOffset = gestureOffset + oldOffset
        offset = gestureOffset != 0
        ? (newOffset < 0 ? 0 : (newOffset > sideMenuWidth ? sideMenuWidth : newOffset))
        : offset
    }
    
    func onEnd(value: DragGesture.Value, sideMenuWidth: CGFloat) {
        let velocityX = value.velocity.width
        let translation = value.translation.width
        
        let baseDistance: CGFloat = sideMenuWidth
        let minDuration = 0.15
        let maxDuration = 0.4
        let computedDuration = min(max(Double(1.0 - abs(translation) / baseDistance) * maxDuration, minDuration), maxDuration)
        
        let dragThreshold = sideMenuWidth * 0.4
        let swipeReverseThreshold = velocityX < -800
        let swipeForwardThreshold = velocityX > 800
        
        let isOpenThresholdReached = translation > dragThreshold || swipeForwardThreshold
        let isCloseThresholdUnreached = translation < 0 && translation > -dragThreshold && !swipeReverseThreshold
        
        withAnimation(.easeOut(duration: computedDuration)) {
            if isOpenThresholdReached || isCloseThresholdUnreached {
                offset = sideMenuWidth
                showMenu = true
            } else {
                offset = 0
                showMenu = false
            }
            oldOffset = offset
        }
    }
    
    func resetSideMenuState() {
        showMenu = false
        offset = 0;
        oldOffset = offset
    }
}
