//
//  WebSocketKlineResponse.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation

struct WebSocketKlineResponse: Decodable
{
    let kline: WebSocketKline?
}
