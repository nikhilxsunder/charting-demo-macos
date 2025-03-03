//
//  KlineModel.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation
import SwiftData

// Kline Model
@Model
class KlineModel {
    @Attribute(.unique) var id: UUID
    var openTime: Date
    var open: Double
    var high: Double
    var low: Double
    var close: Double
    var volume: Double
    var symbol: String
    var interval: String
    init(openTime: Int, open: Double, high: Double, low: Double, close: Double, volume: Double, symbol: String, interval: String) {
        self.id = UUID()
        self.openTime = Date(timeIntervalSince1970: TimeInterval(openTime / 1000))
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
        self.symbol = symbol
        self.interval = interval
    }
}
