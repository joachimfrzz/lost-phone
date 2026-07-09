//
//  ChatBubbleTail.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 9/4/24.
//

import SwiftUI

struct ChatBubbleTail: Shape {
    var isSender: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()

        if isSender {
            // Draw the sender's bubble with the tail on the right
            path.move(to: CGPoint(x: rect.width - 10, y: rect.height))
            path.addLine(to: CGPoint(x: 15, y: rect.height))
            path.addQuadCurve(to: CGPoint(x: 0, y: rect.height - 15), control: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 15))
            path.addQuadCurve(to: CGPoint(x: 15, y: 0), control: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width - 15, y: 0))
            path.addQuadCurve(to: CGPoint(x: rect.width, y: 15), control: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height - 10))
            path.addQuadCurve(to: CGPoint(x: rect.width - 10, y: rect.height), control: CGPoint(x: rect.width, y: rect.height))
            path.move(to: CGPoint(x: rect.width - 10, y: rect.height))
            path.addQuadCurve(to: CGPoint(x: rect.width - 20, y: rect.height - 10), control: CGPoint(x: rect.width - 15, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width - 20, y: rect.height - 20))
            path.addQuadCurve(to: CGPoint(x: rect.width - 10, y: rect.height - 20), control: CGPoint(x: rect.width - 15, y: rect.height - 20))
        } else {
            // Draw the receiver's bubble with the tail on the left
            path.move(to: CGPoint(x: rect.minX + 10, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - 15, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + 15), control: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 15))
            path.addQuadCurve(to: CGPoint(x: rect.maxX - 15, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + 10, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - 10), control: CGPoint(x: rect.minX, y: rect.maxY))
            
            // Tail
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 25))
            path.addQuadCurve(to: CGPoint(x: rect.minX - 10, y: rect.minY + 15), control: CGPoint(x: rect.minX, y: rect.minY + 15))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 10))
            path.addQuadCurve(to: CGPoint(x: rect.minX + 10, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
        }

        return path
    }
}

