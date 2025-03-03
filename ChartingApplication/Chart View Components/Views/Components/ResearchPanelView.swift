//
//  ResearchPanelView.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import SwiftUI
import WebKit

// Research Panel
struct ResearchPanelView: View
{
    @Binding var isPanelVisible: Bool
    @ObservedObject var symbolLoader: SymbolLoader
    @State var metadata: CoinMetadata?
    let metadataManager: MetadataManager
    var panelWidth: CGFloat
    var body: some View
    {
        VStack
        {
            HStack
            {
                Spacer()
                VStack(alignment: .leading, spacing: 10)
                {
                    Text("Research Panel")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                    MetadataView(metadata: metadata)
                    Spacer()
                }
            }
            .frame(width: panelWidth)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .offset(x: isPanelVisible ? 0 : panelWidth)
            .animation(.easeInOut(duration: 0.4), value: isPanelVisible)
        }
        .onAppear
        {
            symbolLoader.loadMetadata()
        }
        .onChange(of: symbolLoader.metadata)
        {
            oldValue,
            newMetadata in
            metadata = newMetadata
        }
        .onChange(of: symbolLoader.selectedSymbol)
        {
            symbolLoader.loadMetadata()
        }
    }
}


