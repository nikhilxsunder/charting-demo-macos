//
//  VolumeChartView.swift
//  test
//
//  Created by Nikhil Sunder on 1/24/25.
//

import SwiftUI
import Charts

// Volume Chart View
struct VolumeChartView: View
{
    let klineData: [KlineData]
    let barWidth: CGFloat
    var body: some View
    {
        let maxVolume = klineData.map { $0.volume }.max() ?? 1
        Chart
        {
            ForEach(klineData)
            {
                dataPoint in
                BarMark(
                    x: .value("Time", dataPoint.openTime),
                    y: .value("Volume", dataPoint.volume),
                    width: .fixed(barWidth)
                )
                .foregroundStyle(dataPoint.open < dataPoint.close ? .green.opacity(0.5) : .red.opacity(0.5))
            }
        }
        .chartYAxis
        {
            AxisMarks(position: .leading)
        }
        .chartXAxis
        {
            AxisMarks(position: .bottom)
        }
        .chartYScale(domain: 0...maxVolume)
        .frame(height: 100)
        .padding(.horizontal)
        .transaction
        {
            transaction in
            transaction.animation = .easeInOut
        }
    }
}

#Preview
{
    VolumeChartView(
        klineData: [
            KlineData(openTime: 1643020800000, open: 0.0001, high: 0.0002, low: 0.0001, close: 0.0002, volume: 1000),
            KlineData(openTime: 1643024400000, open: 0.0002, high: 0.0003, low: 0.0002, close: 0.0003, volume: 2000),
            KlineData(openTime: 1643028000000, open: 0.0003, high: 0.0004, low: 0.0003, close: 0.0004, volume: 1000),
            KlineData(openTime: 1643031600000, open: 0.0004, high: 0.0005, low: 0.0004, close: 0.0005, volume: 4000),
            KlineData(openTime: 1643035200000, open: 0.0005, high: 0.0006, low: 0.0005, close: 0.0006, volume: 5000),
            KlineData(openTime: 1643038800000, open: 0.0006, high: 0.0007, low: 0.0006, close: 0.0007, volume: 8000),
            KlineData(openTime: 1643042400000, open: 0.0007, high: 0.0008, low: 0.0007, close: 0.0008, volume: 7000),
            KlineData(openTime: 1643046000000, open: 0.0008, high: 0.0009, low: 0.0008, close: 0.0009, volume: 8000),
            KlineData(openTime: 1643049600000, open: 0.0009, high: 0.0010, low: 0.0009, close: 0.0010, volume: 12000),
            KlineData(openTime: 1643053200000, open: 0.0010, high: 0.0011, low: 0.0010, close: 0.0011, volume: 5000),
        ],
        barWidth: 5
    )
}
