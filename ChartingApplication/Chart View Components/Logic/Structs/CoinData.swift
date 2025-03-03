//
//  CoinData.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/14/25.
//

import Foundation

// Coin Data
struct CoinData: Decodable
{
    let id: Int
    let name: String
    let symbol: String
    let category: String
    let description: String?
    let slug: String
    let logo: String?
    enum CodingKeys: String, CodingKey
    {
        case id, name, symbol, category, slug, logo
        case description = "description"
    }
}
