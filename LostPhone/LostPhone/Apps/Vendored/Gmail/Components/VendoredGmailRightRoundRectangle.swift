//
//  RightRoundRectangle.swift
//  Youtube_Gmail
//
//  Created by Sopheamen VAN on 8/10/24.
//

import SwiftUI

struct VendoredGmailRightRoundedRectangle: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Start at the top left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        // Line to the top right corner
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)

        // Line to the bottom right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)

        // Line to the bottom left corner
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Close the path back to the start
        path.closeSubpath()

        return path
    }
}

