//
//  TopCornerRadius.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 29/4/24.
//

import SwiftUI

// Define a custom shape that rounds specific corners
struct VendoredLinkedInRoundedSpecificCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
