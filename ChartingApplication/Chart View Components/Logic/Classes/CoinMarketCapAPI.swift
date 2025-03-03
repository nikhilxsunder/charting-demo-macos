//
//  CoinMarketCapAPI.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/14/25.
//

import Foundation

// CoinMarketCap API
class CoinMarketCapAPI
{
    private let apiKey = "2df25965-2317-4db5-ac8f-f42dbfe9ea7b"
    private let baseURL = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info"
    // Fetch Metadata
    func fetchMetadata(for symbol: String, completion: @escaping (CoinMetadata?) -> Void)
    {
        guard let url = URL(string: "\(baseURL)?symbol=\(symbol)")
        else
        {
            print("Invalid URL")
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            if let error = error
            {
                print("Error fetching metadata: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data
            else
            {
                print("No data received")
                completion(nil)
                return
            }
            if let jsonString = String(data: data, encoding: .utf8)
            {
                print("")
            }
            else
            {
                print("Failed to convert data to string")
            }
            do
            {
                let decodedResponse = try JSONDecoder().decode(CoinMarketCapResponse.self, from: data)
                if let coinArray = decodedResponse.data[symbol], let coinData = coinArray.first
                {
                    let metadata = CoinMetadata(
                        id: symbol,
                        name: coinData.name,
                        logoURL: coinData.logo,
                        description: coinData.description
                    )
                    completion(metadata)
                }
                else
                {
                    print("No metadata found for symbol: \(symbol)")
                    completion(nil)
                }
            }
            catch
            {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
