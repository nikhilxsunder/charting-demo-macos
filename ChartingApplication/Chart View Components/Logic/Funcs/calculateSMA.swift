//
//  calculateSMA.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation

// Simple Moving Average
func calculateSMA(data: [KlineData], period: Int) -> [Double]
{
    var smaValues: [Double] = []
    for i in 0..<data.count
    {
        if i < period - 1
        {
            smaValues.append(Double.nan)
        }
        else
        {
            let sum = data[i - (period - 1)...i].reduce(0)
            {
                $0 + $1.close
            }
            smaValues.append(sum / Double(period))
        }
    }
    return smaValues
}
