//
//  CandlestickChartView.swift
//  test
//
//  Created by Nikhil Sunder on 1/24/25.
//

import SwiftUI
import Charts

//Candlestick Chart View
struct CandlestickChartView: View
{
    let klineData: [KlineData]
    let barWidth: CGFloat
    var yAxisRange: ClosedRange<Double>
    {
        guard let minValue = klineData.map({ $0.low }).min(),
              let maxValue = klineData.map({ $0.high }).max()
        else
        {
            return 0...1
        }
        return minValue...maxValue
    }
    var body: some View
    {
        Chart
        {
            ForEach(klineData, id: \.openTime)
            {
                dataPoint in
                BarMark(
                    x: .value("Time", dataPoint.openTime, unit: .minute),
                    yStart: .value("Open", dataPoint.open),
                    yEnd: .value("Close", dataPoint.close),
                    width: .fixed(barWidth)
                )
                .foregroundStyle(dataPoint.open < dataPoint.close ? .green : .red)

                RuleMark(
                    x: .value("Time", dataPoint.openTime, unit: .minute),
                    yStart: .value("Low", dataPoint.low),
                    yEnd: .value("High", dataPoint.high)
                )
                .foregroundStyle(dataPoint.open < dataPoint.close ? .green : .red)
            }
        }
        .chartYAxis
        {
            AxisMarks(position: .leading)
        }
        .chartYScale(domain: yAxisRange)
        .chartXAxis
        {
            AxisMarks(position: .bottom)
        }
        .padding()
        .frame(height: 300)
        .transaction
        {
            transaction in
            transaction.animation = .easeInOut
        }
    }
}

#Preview
{
    CandlestickChartView(
        klineData: [
            KlineData(openTime: 1643020800000, open: 0.0001, high: 0.0002, low: 0.0001, close: 0.0002, volume: 1000),
            KlineData(openTime: 1643024400000, open: 0.0002, high: 0.0003, low: 0.0002, close: 0.0001, volume: 2000),
            KlineData(openTime: 1643028000000, open: 0.0003, high: 0.0004, low: 0.0003, close: 0.0004, volume: 3000),
            KlineData(openTime: 1643031600000, open: 0.0004, high: 0.0005, low: 0.0004, close: 0.0005, volume: 4000),
            KlineData(openTime: 1643035200000, open: 0.0005, high: 0.0006, low: 0.0005, close: 0.0002, volume: 5000),
            KlineData(openTime: 1643038800000, open: 0.0002, high: 0.0007, low: 0.0006, close: 0.0007, volume: 6000),
            KlineData(openTime: 1643042400000, open: 0.0007, high: 0.0008, low: 0.0007, close: 0.0008, volume: 7000),
            KlineData(openTime: 1643046000000, open: 0.0008, high: 0.0009, low: 0.0008, close: 0.0009, volume: 8000),
            KlineData(openTime: 1643049600000, open: 0.0009, high: 0.0010, low: 0.0009, close: 0.0015, volume: 9000),
            KlineData(openTime: 1643053200000, open: 0.0015, high: 0.0011, low: 0.0010, close: 0.0011, volume: 10000),
            KlineData(openTime: 1643056800000, open: 0.0011, high: 0.0012, low: 0.0011, close: 0.0012, volume: 11000),
            KlineData(openTime: 1643060400000, open: 0.0012, high: 0.0013, low: 0.0012, close: 0.0013, volume: 12000),
        ],
        barWidth: 5
    )
}
