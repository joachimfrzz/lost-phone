//
//  VendoredLinkedInLine.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 2/5/24.
//

import SwiftUI

struct VendoredLinkedInLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

