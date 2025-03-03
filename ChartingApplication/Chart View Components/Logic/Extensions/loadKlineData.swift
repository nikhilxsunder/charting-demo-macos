//
//  loadKlineData.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation

// Load Kline Data
extension ChartView
{
    func loadKlineData()
    {
        let symbol = symbolLoader.selectedSymbol
        let interval = selectedInterval.rawValue

        dataManager.loadKlineData(symbol: symbol, interval: interval)
        { data in
            DispatchQueue.main.async
            {
                self.klineData = data
            }
        }
    }
}
