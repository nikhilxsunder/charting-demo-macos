//
//  calculatedBarWidth.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation
import SwiftUI

// Calculated Bar Width
func calculatedBarWidth(screenWidth: CGFloat, totalBars: Int) -> CGFloat
    {
        let maxChartWidth = screenWidth * 0.9
        return max(min(maxChartWidth / CGFloat(totalBars), 10), 3)
    }
