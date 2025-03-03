//
//  KlineInterval.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation

// Kline Interval Enum
enum KlineInterval: String, CaseIterable, Identifiable
{
    case oneMinute = "1m"
    case oneHour = "1h"
    case oneDay = "1d"
    case oneWeek = "1w"
    case oneMonth = "1M"
    var id: Self
    {
        self
    }
}
