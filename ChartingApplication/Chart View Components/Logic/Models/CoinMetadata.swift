//
//  CoinMetadata.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/14/25.
//

import Foundation
import SwiftData

// CoinMetaData
@Model
class CoinMetadata
{
    @Attribute(.unique) var id: String
    var name: String
    var logoURL: String?
    var coinDescription: String?
    init(id: String, name: String, logoURL: String? = nil, description: String? = nil)
    {
        self.id = id
        self.name = name
        self.logoURL = logoURL
        self.coinDescription = description
    }
}
