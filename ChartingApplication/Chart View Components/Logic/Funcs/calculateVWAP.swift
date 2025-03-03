//
//  calculateSMA.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation

// Volume-Weighted Average
func calculateVWAP(klineData: [KlineData]) -> Double? {
    guard !klineData.isEmpty else { return nil } // Ensure data is available

    var cumulativeTPV: Double = 0  // Sum of (Typical Price * Volume)
    var cumulativeVolume: Double = 0  // Sum of Volume

    for kline in klineData {
        let typicalPrice = (kline.high + kline.low + kline.close) / 3
        cumulativeTPV += typicalPrice * kline.volume
        cumulativeVolume += kline.volume
    }

    return cumulativeVolume > 0 ? cumulativeTPV / cumulativeVolume : nil
}
