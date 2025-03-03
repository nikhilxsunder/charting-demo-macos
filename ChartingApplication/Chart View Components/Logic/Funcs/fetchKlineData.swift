//
//  fetchKlineData.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation

// Fetch Kline Data
func fetchKlineData(symbol: String, interval: KlineInterval, limit: Int = 500, completion: @escaping (Result<[[Any]], Error>) -> Void)
{
    let baseUrl = "https://api.binance.us/api/v3/klines"
    var urlComponents = URLComponents(string: baseUrl)!
    urlComponents.queryItems = [
        URLQueryItem(name: "symbol", value: symbol),
        URLQueryItem(name: "interval", value: interval.rawValue),
        URLQueryItem(name: "limit", value: String(limit))
    ]
    guard let url = urlComponents.url
    else
    {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request)
    {
        data, response, error in if let error = error
        {
            completion(.failure(error))
            return
        }
        guard let data = data
        else
        {
            completion(.failure(NSError(domain: "No Data Received", code: 0, userInfo: nil)))
            return
        }
        do
        {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[Any]]
            {
                
                completion(.success(json))
            }
            else
            {
                completion(.failure(NSError(domain: "Invalid JSON format", code: 0, userInfo: nil)))
            }
        }
        catch
        {
            completion(.failure(error))
        }
    }
    task.resume()
}
