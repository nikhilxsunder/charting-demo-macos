//
//  LastDataView.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import SwiftUI

// Last Data
struct LastDataView: View
{
    let lastKline: KlineData
    var body: some View
    {
        HStack
        {
            dataBox(title: "Open", value: lastKline.open)
            dataBox(title: "Close", value: lastKline.close)
            dataBox(title: "High", value: lastKline.high)
            dataBox(title: "Low", value: lastKline.low)
            dataBox(title: "Volume", value: lastKline.volume)
        }
    }
}


