//
//  SymbolLoader.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation
import SwiftData

// Symbol Loader 
class SymbolLoader: ObservableObject
{
    @Published var symbols: [String] = []
    @Published var cleanedSymbol: String = "BTC"
    @Published var metadata: CoinMetadata?
    @Published var selectedSymbol: String = "BTCUSDT"
    {
        didSet
        {
            cleanedSymbol = cleanSymbol(selectedSymbol)
            loadMetadata()
        }
    }
    private let context: ModelContext
    private let api = CoinMarketCapAPI()
    private let metadataManager: MetadataManager

    init(context: ModelContext)
    {
        self.context = context
        self.metadataManager = MetadataManager(context: context)
        loadSymbols()
        cleanedSymbol = cleanSymbol(selectedSymbol)
        loadMetadata()
    }
    // Load Symbols
    func loadSymbols()
    {
        let fetchDescriptor = FetchDescriptor<SymbolModel>()
        if let cachedSymbols = try? context.fetch(fetchDescriptor), !cachedSymbols.isEmpty
        {
            self.symbols = cachedSymbols.map
            {
                $0.symbol
            }
            self.selectedSymbol = self.symbols.first ?? "BTCUSDT"
            print("Loaded symbols from cache: \(self.symbols.count)")
            return
        }
        fetchExchangeInfo(context: context)
        {
            fetchedSymbols in
            DispatchQueue.main.async
            {
                self.symbols = fetchedSymbols
                if let firstSymbol = fetchedSymbols.first
                {
                    self.selectedSymbol = firstSymbol
                }
            }
        }
    }
    // Refresh Symbols
    func refreshSymbols()
    {
        fetchExchangeInfo(context: context)
        {
            fetchedSymbols in
            self.symbols = fetchedSymbols
            if let firstSymbol = fetchedSymbols.first
            {
                self.selectedSymbol = firstSymbol
            }
        }
    }
    // Clean Symbols
    func cleanSymbols(_ symbols: [String]) -> [String]
    {
        let suffixes = ["USD", "USDT", "USD4", "BTC", "AI", "ETH"]
        var cleanedSet = Set<String>()
        var cleanedList: [String] = []
        for symbol in symbols
        {
            var cleanedSymbol = symbol
            for suffix in suffixes
            {
                if cleanedSymbol.hasSuffix(suffix)
                {
                    cleanedSymbol.removeLast(suffix.count)
                    break
                }
            }
            if !cleanedSet.contains(cleanedSymbol)
            {
                cleanedSet.insert(cleanedSymbol)
                cleanedList.append(cleanedSymbol)
            }
        }
        return cleanedList
    }
    // Clean Symbol
    private func cleanSymbol(_ symbol: String) -> String
    {
        let suffixes = ["USD", "USDT", "USD4", "BTC", "AI", "ETH"]
        var cleanedSymbol = symbol
        for suffix in suffixes
        {
            if cleanedSymbol.hasSuffix(suffix)
            {
                cleanedSymbol = String(cleanedSymbol.dropLast(suffix.count))
                break
            }
        }
        return cleanedSymbol
    }
    // Load Metadata
    func loadMetadata()
    {
        let symbolToFetch = cleanedSymbol
        if let cachedMetadata = metadataManager.getCachedMetadata(for: symbolToFetch)
        {
            self.metadata = cachedMetadata
            print("Loaded metadata from cache")
            return
        }
        api.fetchMetadata(for: symbolToFetch)
        {
            [weak self] fetchedMetadata in
            DispatchQueue.main.async
            {
                if let metadata = fetchedMetadata
                {
                    self?.metadata = metadata
                    self?.metadataManager.saveMetadata(metadata)
                    print("Fetched and cached metadata")
                }
            }
        }
    }
}
