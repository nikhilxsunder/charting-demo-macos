//
//  dataBox.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation
import SwiftUI

// Data Box 
func dataBox(title: String, value: Double) -> some View
{
    VStack
    {
        Text("\(title):").font(.caption)
        Text(String(format: "%.2f", value)).font(.caption2)
    }
    .frame(minWidth: 50)
}
