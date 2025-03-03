//
//  calculateSMA.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation

// Exponential Moving Average
func calculateEMA(data: [KlineData], period: Int) -> [Double]
{
    var emaValues: [Double] = []
    let alpha = 2.0 / Double(period + 1)
    guard data.count >= period
    else
    {
        print("Not enough data to calculate EMA")
        return []
    }
    var previousEMA = data.prefix(period).reduce(0)
    {
        $0 + $1.close
    }
    / Double(period)
    emaValues.append(previousEMA)
    for i in period..<data.count
    {
        let currentPrice = data[i].close
        let currentEMA = (currentPrice * alpha) + (previousEMA * (1 - alpha))
        emaValues.append(currentEMA)
        previousEMA = currentEMA
    }
    return emaValues
}
