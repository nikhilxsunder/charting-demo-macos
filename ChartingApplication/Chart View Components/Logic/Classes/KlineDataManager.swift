//
//  ChartObjects.swift
//  test
//
//  Created by Nikhil Sunder on 2/12/25.
//

import SwiftData
import Foundation

//Kline Data Manager
class KlineDataManager
{
    private let modelContext: ModelContext
    init(context: ModelContext)
    {
        self.modelContext = context
    }
    // Load Kline Data
    func loadKlineData(symbol: String, interval: String, completion: @escaping ([KlineData]) -> Void)
    {
        guard let intervalEnum = KlineInterval(rawValue: interval)
        else
        {
            print("Invalid interval: \(interval)")
            completion([])
            return
        }
        let cachedKlines = fetchCachedKlines(symbol: symbol, interval: interval)
        
        if !cachedKlines.isEmpty
        {
            let klineData = cachedKlines.map
            {
                KlineData(
                    openTime: Int($0.openTime.timeIntervalSince1970 * 1000),
                    open: $0.open,
                    high: $0.high,
                    low: $0.low,
                    close: $0.close,
                    volume: $0.volume
                )
            }
            completion(klineData)
            return
        }
        fetchKlineData(symbol: symbol, interval: intervalEnum)
        {
            result in
            switch result
            {
            case .success(let apiData):
                DispatchQueue.main.async
                {
                    let newKlineData = apiData.map
                    {
                        let data = KlineData(
                            openTime: $0[0] as? Int ?? 0,
                            open: Double($0[1] as? String ?? "0") ?? 0.0,
                            high: Double($0[2] as? String ?? "0") ?? 0.0,
                            low: Double($0[3] as? String ?? "0") ?? 0.0,
                            close: Double($0[4] as? String ?? "0") ?? 0.0,
                            volume: Double($0[5] as? String ?? "0") ?? 0.0
                        )
                        let newKline = KlineModel(
                            openTime: data.openTime.timeIntervalSince1970.toInt(),
                            open: data.open,
                            high: data.high,
                            low: data.low,
                            close: data.close,
                            volume: data.volume,
                            symbol: symbol,
                            interval: interval
                        )
                        self.modelContext.insert(newKline)
                        return data
                    }
                    completion(newKlineData)
                }
            case .failure(let error):
                print("Error fetching Kline data: \(error)")
                completion([])
            }
        }
    }
    // Fetch Cached Klines
    private func fetchCachedKlines(symbol: String, interval: String) -> [KlineModel]
    {
        let fetchDescriptor = FetchDescriptor<KlineModel>(predicate: #Predicate{
            $0.symbol == symbol && $0.interval == interval
            })
        do
        {
            return try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch cached Kline data: \(error)")
            return []
        }
    }
    // Delete Old Klines
    func deleteOldKlines()
    {
        let expirationDate = Date().addingTimeInterval(-7 * 24 * 60 * 60)
        let fetchDescriptor = FetchDescriptor<KlineModel>(predicate: #Predicate {
            $0.openTime < expirationDate
        })
        do
        {
            let oldData = try modelContext.fetch(fetchDescriptor)
            for data in oldData
            {
                modelContext.delete(data)
            }
        }
        catch
        {
            print("Failed to delete old Kline data: \(error)")
        }
    }
}


