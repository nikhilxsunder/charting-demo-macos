//
//  ChartView.swift
//  test
//
//  Created by Nikhil Sunder on 1/23/25.
//

import SwiftUI
import SwiftData
import Charts
import Foundation

// Chart View
struct ChartView: View
{
    @Environment(\.modelContext) var modelContext
    @Query var cachedKlines: [KlineModel]
    @State var showSheet = false
    @State var isLive = false
    @State var date = Date()
    @State var selectedSource: Source = Source.binanceUS
    @State var selectedInterval: KlineInterval = KlineInterval.oneDay
    @State var klineData: [KlineData] = []
    @State var isPanelVisible = false
    @State var offset: CGFloat = 400
    @State var panelWidth: CGFloat = 400
    @StateObject var symbolLoader : SymbolLoader
    @StateObject var websocketManager: WebSocketManager
    var dataManager: KlineDataManager
    var metadataManager: MetadataManager
    init()
    {
        let modelContainer = try! ModelContainer(for: SymbolModel.self)
        _symbolLoader = StateObject(wrappedValue: SymbolLoader(context: modelContainer.mainContext))
        _websocketManager = StateObject(wrappedValue: WebSocketManager())
        self.dataManager = KlineDataManager(context: modelContainer.mainContext)
        self.metadataManager = MetadataManager(context: modelContainer.mainContext)
    }
    var body: some View
    {
        GeometryReader
        {
            geometry in
            let windowWidth = geometry.size.width
            let calculatedPanelWidth = max(400, windowWidth * 0.3)
            let hiddenOffset = calculatedPanelWidth
            HStack
            {
                // Controller Cluster
                VStack
                {
                    Text("Chart").font(.largeTitle)
                    ChartControlsView(selectedSource: $selectedSource,
                                      selectedInterval: $selectedInterval,
                                      showSheet: $showSheet,
                                      isLive: $isLive,
                                      isPanelVisible: $isPanelVisible,
                                      offset: $offset,
                                      panelWidth: $panelWidth,
                                      symbolLoader: symbolLoader,
                                      websocketManager: websocketManager
                    )
                    .padding()
                    if klineData.isEmpty
                    {
                        Text("Loading Chart...").onAppear
                        {
                            loadKlineData()
                        }
                    }
                    else
                    {
                        // Visual Data Cluster
                        VStack
                        {
                            // Last Data
                            if let lastKline = klineData.last
                            {
                                LastDataView(lastKline: lastKline)
                            }
                            else
                            {
                                Text("Loading data...")
                            }
                            // Chart Stack
                            let barWidth = calculatedBarWidth(screenWidth: geometry.size.width, totalBars: klineData.count)
                            VStack
                            {
                                CandlestickChartView(klineData: klineData, barWidth: barWidth)
                                VolumeChartView(klineData: klineData, barWidth: barWidth)
                            }
                            .padding()
                        }
                    }
                }
                .frame(width: isPanelVisible ? windowWidth - calculatedPanelWidth : windowWidth)
                .animation(.easeInOut(duration: 0.5), value: isPanelVisible)
                .padding()
                // WebSocket Data Reaction
                .onReceive(websocketManager.$liveData)
                {
                    newData in
                    if let newKline = newData
                    {
                        klineData.append(newKline)
                        if klineData.count > 50
                        {
                            klineData.removeFirst()
                        }
                    }
                }
                // Symbol Change Reaction
                .onChange(of: symbolLoader.selectedSymbol)
                {
                    isLive = false
                    websocketManager.stopLiveData()
                    loadKlineData()
                }
                // Interval Change Reaction
                .onChange(of: selectedInterval)
                {
                    isLive = false
                    websocketManager.stopLiveData()
                    loadKlineData()
                }
                // Research Panel
                ResearchPanelView(isPanelVisible: $isPanelVisible,
                                  symbolLoader: symbolLoader,
                                  metadataManager: metadataManager,
                                  panelWidth: calculatedPanelWidth
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear
            {
                panelWidth = calculatedPanelWidth
                offset = hiddenOffset
            }
        }
    }
}

#Preview
{
    ChartView()
        .frame(width: 1200, height: 900)
}
