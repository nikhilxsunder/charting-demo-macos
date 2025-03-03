//
//  SidebarView.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/14/25.
//

import SwiftUI

// Main View
struct MainView: View
{
    @State var selectedView: String? = nil
    var body: some View
    {
        NavigationSplitView
        {
            List(selection: $selectedView)
            {
                NavigationLink("Chart", value: "ChartView")
                    .padding()
                NavigationLink("News", value: "NewsView")
                    .padding()
                NavigationLink("Settings", value: "SettingsView")
                    .padding()
            }
            .navigationTitle("Menu")
            .frame(minWidth: 200)
        }
        detail:
        {
            if let selectedView = selectedView
            {
                if selectedView == "ChartView"
                {
                    ChartView()
                        .navigationTitle("Chart")
                }
                else if selectedView == "NewsView"
                {
                    EmptyView()
                        .navigationTitle("News")
                }
                else if selectedView == "SettingsView"
                {
                    SettingsView()
                        .navigationTitle("Settings")
                }
            }
            else
            {
                Text("Select an option")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview
{
    MainView()
        .frame(width: 1600, height: 900)
}
