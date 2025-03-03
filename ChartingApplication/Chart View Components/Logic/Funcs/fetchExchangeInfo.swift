//
//  ChartFunctions.swift
//  test
//
//  Created by Nikhil Sunder on 1/24/25.
//

import SwiftData
import Foundation

// Fetch Exchange Info
func fetchExchangeInfo(context: ModelContext, completion: @escaping ([String]) -> Void)
{
    let urlString = "https://api.binance.us/api/v3/exchangeInfo"
    guard let url = URL(string: urlString) else
    {
        print("Invalid URL")
        completion([])
        return
    }
    let task = URLSession.shared.dataTask(with: url)
    {
        data, response, error in
        if let error = error
        {
            print("Error fetching symbols: \(error.localizedDescription)")
            completion([])
            return
        }
        guard let data = data else
        {
            print("No data received")
            completion([])
            return
        }
        do
        {
            print("Received data: \(String(data: data, encoding: .utf8) ?? "Invalid Data")")
            let exchangeInfo = try JSONDecoder().decode(ExchangeInfo.self, from: data)
            DispatchQueue.main.async
            {
                let symbols = exchangeInfo.symbols.map
                {
                    $0.symbol
                }
                print("Symbols Loaded: \(symbols.count)")
                let fetchDescriptor = FetchDescriptor<SymbolModel>()
                if let cachedSymbols = try? context.fetch(fetchDescriptor)
                {
                    cachedSymbols.forEach
                    {
                        context.delete($0)
                    }
                }
                symbols.forEach
                {
                    symbol in
                    let newSymbol = SymbolModel(symbol: symbol)
                    context.insert(newSymbol)
                }
                try? context.save()
                completion(symbols)
            }
        }
        catch
        {
            print("Failed to decode JSON: \(error)")
            completion([])
        }
    }
    task.resume()
}


