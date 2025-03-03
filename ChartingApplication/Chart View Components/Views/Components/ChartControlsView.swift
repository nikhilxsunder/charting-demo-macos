//
//  ChartControlsView.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import SwiftUI
import SwiftData

// Chart Controls
struct ChartControlsView: View
{
    @Binding var selectedSource: Source
    @Binding var selectedInterval: KlineInterval
    @Binding var showSheet: Bool
    @Binding var isLive: Bool
    @Binding var isPanelVisible: Bool
    @Binding var offset: CGFloat
    @Binding var panelWidth: CGFloat
    @ObservedObject var symbolLoader: SymbolLoader
    @ObservedObject var websocketManager: WebSocketManager
    var body: some View
    {
        VStack
        {
            // Chart Pickers
            HStack
            {
                // Source Controller
                VStack
                {
                    Text("Source").font(.headline)
                    Picker("", selection: $selectedSource)
                    {
                        Text("Binance US").tag(Source.binanceUS)
                    }
                }
                .padding()
                // Interval Controller
                VStack
                {
                    Text("Interval").font(.headline)
                    Picker("", selection: $selectedInterval)
                    {
                        ForEach(KlineInterval.allCases)
                        {
                            interval in
                            Text(interval.rawValue).tag(interval)
                        }
                    }
                }
                .padding()
                // Symbol Controller
                VStack
                {
                    if symbolLoader.symbols.isEmpty
                    {
                        Text("Loading...")
                    }
                    else
                    {
                        Text("Symbol").font(.headline)
                        Picker("", selection: $symbolLoader.selectedSymbol)
                        {
                            ForEach(symbolLoader.symbols.sorted(), id: \.self)
                            {
                                symbol in
                                Text(symbol).tag(symbol)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: symbolLoader.selectedSymbol)
                        {
                            print("Selected Symbol: \(symbolLoader.selectedSymbol)")
                        }
                    }
                }
                .padding()
            }
            .padding(.horizontal)
            // Chart Buttons
            HStack
            {
                // Symbol Cache Contreoller
                Button("Refresh Symbols")
                {
                    symbolLoader.refreshSymbols()
                }
                .padding()
                // Indicators View Controller
                Button(action:
                {
                    showSheet.toggle()
                })
                {
                    Text("Indicators")
                }
                .sheet(isPresented: $showSheet)
                {
                    IndicatorsView()
                }
                .padding()
                // Live Data Controller
                Button(action:
                {
                    isLive.toggle()
                    if isLive
                    {
                        websocketManager.startLiveData(symbol: symbolLoader.selectedSymbol, interval: selectedInterval)
                    }
                    else
                    {
                        websocketManager.stopLiveData()
                    }
                })
                {
                    Text(isLive ? "Stop Live" : "Go Live")
                }
                .padding()
                // Research Panel View Controller
                Button("Research Panel")
                {
                    withAnimation(.easeInOut(duration: 0.5))
                    {
                        isPanelVisible.toggle()
                        offset = isPanelVisible ? 0 : panelWidth
                    }
                }
                .padding()
            }
        }
    }
}

