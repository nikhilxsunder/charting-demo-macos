//
//  WebSocketManager.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation
import Combine

//WebSocket Manager
class WebSocketManager: ObservableObject
{
    @Published var liveData: KlineData? = nil
    private var webSocketTask: URLSessionWebSocketTask?
    private var isConnected = false
    // Start Live Data
    func startLiveData(symbol: String, interval: KlineInterval)
    {
        let urlString = "wss://stream.binance.us:9443/ws/\(symbol.lowercased())@kline_\(interval.rawValue)"
        guard let url = URL(string: urlString)
        else
        {
            print("Invalid WebSocket URL")
            return
        }
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        webSocketTask?.receive
        {
            [weak self] result in
            switch result
            {
            case .success:
                self?.isConnected = true
                self?.listenForMessages()
            case .failure(let error):
                print("WebSocket error: \(error.localizedDescription)")
            }
        }
    }
    // Stop Live Data
    func stopLiveData()
    {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        liveData = nil
    }
    private func listenForMessages()
    {
        webSocketTask?.receive
        {
            [weak self] result in
            switch result
            {
            case .failure(let error):
                print("WebSocket error: \(error.localizedDescription)")
                self?.isConnected = false
            case .success(let message):
                switch message
                {
                case .data(let data):
                    self?.handleWebSocketData(data)
                case .string(let string):
                    print("Received string: \(string)")
                @unknown default:
                    print("Received unknown message type.")
                }
            }
            self?.listenForMessages()
        }
    }
    // Handle Websocket Data
    private func handleWebSocketData(_ data: Data)
    {
        do
        {
            let decoder = JSONDecoder()
            let klineResponse = try decoder.decode(WebSocketKlineResponse.self, from: data)
            if let kline = klineResponse.kline
            {
                let newKline = KlineData(openTime: kline.openTime.toInt(),
                                         open: kline.open,
                                         high: kline.high,
                                         low: kline.low,
                                         close: kline.close,
                                         volume: kline.volume)
                DispatchQueue.main.async
                {
                    self.liveData = newKline
                }
            }
        }
        catch
        {
            print("Error parsing WebSocket data: \(error.localizedDescription)")
        }
    }
}
