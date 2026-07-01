import SwiftUI

// Mesures calquées sur iPhone 15 Pro (390×844 pt) — iOS 17 Centre de contrôle / Notifications.
enum IOSMetrics {
    static let screenWidth: CGFloat = 390

    // Centre de contrôle
    static let ccHorizontalPadding: CGFloat = 16
    static let ccGridSpacing: CGFloat = 12
    static let ccModuleSize: CGFloat = 148
    static let ccModuleRadius: CGFloat = 26
    static let ccInnerRadius: CGFloat = 14
    static let ccConnectivityInner: CGFloat = 66
    static let ccConnectivityIcon: CGFloat = 22
    static let ccSliderWidth: CGFloat = 48
    static let ccSliderHeight: CGFloat = 174
    static let ccToggleSize: CGFloat = 48
    static let ccNowPlayingHeight: CGFloat = 74

    // Centre de notifications
    static let ncHorizontalPadding: CGFloat = 16
    static let ncWeekdayFont: CGFloat = 15
    static let ncDateFont: CGFloat = 34
    static let ncStackSpacing: CGFloat = 10
    static let ncCardRadius: CGFloat = 20
    static let ncCardPadding: CGFloat = 14
    static let ncCardMinHeight: CGFloat = 72
    static let ncAppIconSize: CGFloat = 38
    static let ncAppIconRadius: CGFloat = 10
    static let ncAppNameFont: CGFloat = 13
    static let ncTimeFont: CGFloat = 13
    static let ncTitleFont: CGFloat = 15
    static let ncBodyFont: CGFloat = 15
    static let ncStackPeekOffset: CGFloat = 6
    static let ncStackPeekScale: CGFloat = 0.97

    // Barre d'état (overlays)
    static let statusBarTopPadding: CGFloat = 4
    static let statusBarHeight: CGFloat = 22
    static let statusBarHorizontalPadding: CGFloat = 27
    static let statusBarTimeFont: CGFloat = 16
    static let statusBarIconFont: CGFloat = 14
    static let statusBarBatteryWidth: CGFloat = 25
    static let statusBarBatteryHeight: CGFloat = 12
}

enum IOSColors {
    static let moduleFill = Color(red: 0.46, green: 0.46, blue: 0.50, opacity: 0.32)
    static let systemOrange = Color(red: 1.0, green: 0.624, blue: 0.039)   // #FF9F0A
    static let systemGreen = Color(red: 0.188, green: 0.820, blue: 0.345)  // #30D158
    static let systemBlue = Color(red: 0.039, green: 0.518, blue: 1.0)    // #0A84FF
    static let systemYellow = Color(red: 1.0, green: 0.839, blue: 0.039)
    static let ncCardFill = Color(red: 0.173, green: 0.173, blue: 0.180, opacity: 0.92)
}
