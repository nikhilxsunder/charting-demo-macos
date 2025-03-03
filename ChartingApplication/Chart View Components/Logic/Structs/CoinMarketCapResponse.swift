//
//  CoinMarketCapResponse.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/14/25.
//

import Foundation

// CoinMarketCap Response
struct CoinMarketCapResponse: Decodable
{
    let data: [String: [CoinData]]
}
