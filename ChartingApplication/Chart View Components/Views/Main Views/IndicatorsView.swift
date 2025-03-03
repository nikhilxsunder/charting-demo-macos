//
//  IndicatorsView.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/12/25.
//

import SwiftUI

// Indicators View
struct IndicatorsView: View
{
    @State private var smaEnabled = false
    @State private var emaEnabled = false
    @State private var vwapEnabled = false
    @State private var bbEnabled = false
    @State private var accelEnabled = false
    @State private var keltEnabled = false
    @State private var bbwEnabled = false
    @State private var macdEnabled = false
    @State private var rsiEnabled = false
    var body: some View
    {
        VStack()
        {
            Text("Indicators")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            // Averages
            Text("Volume/Moving Averages")
                .font(.headline)
                .padding()
            HStack()
            {
                VStack
                {
                    Toggle(isOn: $smaEnabled)
                    {
                        Text("SMA")
                    }
                    .padding()
                }
                VStack
                {
                    Toggle(isOn: $emaEnabled)
                    {
                        Text("EMA")
                    }
                    .padding()
                }
                VStack
                {
                    Toggle(isOn: $vwapEnabled)
                    {
                        Text("VWAP")
                    }
                    .padding()
                }
            }
            // Channels
            Text("Bands/Channels")
                .font(.headline)
                .padding()
            HStack()
            {
                Toggle(isOn: $bbEnabled)
                {
                    Text("Bollinger Bands")
                }
                .padding()
                Toggle(isOn: $accelEnabled)
                {
                    Text("Acceleration Bands")
                }
                .padding()
                Toggle(isOn: $keltEnabled)
                {
                    Text("Keltner Channel")
                }
                .padding()
            }
            //Oscillators
            Text("Oscillators")
                .font(.headline)
                .padding()
            HStack()
            {
                Toggle(isOn: $bbwEnabled)
                {
                    Text("Bollinger Bands Width")
                }
                .padding()
                Toggle(isOn: $macdEnabled)
                {
                    Text("MACD")
                }
                .padding()
                Toggle(isOn: $rsiEnabled)
                {
                    Text("RSI")
                }
                .padding()
            }
            //Regressions/CoreML
        }
    }
}

#Preview
{
    IndicatorsView()
        .frame(width: 600, height: 600)
}
