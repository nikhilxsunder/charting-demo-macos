//
//  WebSocketKline.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation

struct WebSocketKline: Decodable
{
    let openTime: TimeInterval
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Double
}
