//
//  MetadataManager.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/14/25.
//

import Foundation
import SwiftData

// Metadata Manager
class MetadataManager
{
    private let context: ModelContext
    init(context: ModelContext)
    {
        self.context = context
    }
    // Save Metadata
    func saveMetadata(_ metadata: CoinMetadata)
    {
        let metadataId = metadata.id
        let fetchDescriptor = FetchDescriptor<CoinMetadata>(
            predicate: #Predicate<CoinMetadata>
            {
                coin in
                coin.id == metadataId
            }
        )
        if let existingMetadata = try? context.fetch(fetchDescriptor).first
        {
            existingMetadata.name = metadata.name
            existingMetadata.logoURL = metadata.logoURL
            existingMetadata.coinDescription = metadata.coinDescription
        }
        else
        {

            context.insert(metadata)
        }
        try? context.save()
    }
    // Get Cached Metadata
    func getCachedMetadata(for symbol: String) -> CoinMetadata?
    {
        let fetchDescriptor = FetchDescriptor<CoinMetadata>(
            predicate: #Predicate<CoinMetadata>
            {
                coin in
                coin.id == symbol
            }
        )
        return try? context.fetch(fetchDescriptor).first
    }
}
