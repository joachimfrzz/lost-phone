//
//  LineChartView.swift
//  Youtube_Phantom_clone
//
//  Created by Sopheamen VAN on 13/3/25.
//

import SwiftUI
import Charts

struct LineChartData: Identifiable {
    let id = UUID()
    let value: Double
    let index: Int
}

struct LineMinusChartView: View {
    @State private var animatedData: [LineChartData] = []

    let data: [LineChartData] = {
        var values: [Double] = []
        var currentValue: Double = 100

        for index in 0..<50 {
            let change = Double.random(in: -7...3) // Gradual downward trend with minor recoveries
            currentValue += change
            values.append(currentValue)
        }

        return values.enumerated().map { LineChartData(value: $0.element, index: $0.offset) }
    }()

    var body: some View {
        Chart(animatedData) { item in
            LineMark(
                x: .value("Index", item.index),
                y: .value("Value", item.value)
            )
            .foregroundStyle(Color.red)
            .lineStyle(StrokeStyle(lineWidth: 1.5))
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .onAppear {
            animateChart()
        }
    }

    // Animation Logic
    private func animateChart() {
        var index = 0
        animatedData = []
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            if index < data.count {
                withAnimation(.easeInOut(duration: 0.2)) {
                    animatedData.append(data[index])
                }
                index += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

struct LinePlusChartView: View {
    @State private var animatedData: [LineChartData] = []

    let data: [LineChartData] = {
        var values: [Double] = []
        var currentValue: Double = 20

        for index in 0..<50 {
            let change = Double.random(in: -3...7) // Slight dips but upward trend
            currentValue += change
            values.append(currentValue)
        }

        return values.enumerated().map { LineChartData(value: $0.element, index: $0.offset) }
    }()

    var body: some View {
        Chart(animatedData) { item in
            LineMark(
                x: .value("Index", item.index),
                y: .value("Value", item.value)
            )
            .foregroundStyle(Color.green)
            .lineStyle(StrokeStyle(lineWidth: 1.5))
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .onAppear {
            animateChart()
        }
    }

    // Animation Logic
    private func animateChart() {
        var index = 0
        animatedData = []
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            if index < data.count {
                withAnimation(.easeInOut(duration: 0.2)) {
                    animatedData.append(data[index])
                }
                index += 1
            } else {
                timer.invalidate()
            }
        }
    }
}


#Preview {
    LinePlusChartView()
}
