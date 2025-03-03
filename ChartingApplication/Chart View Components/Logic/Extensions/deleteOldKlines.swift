//
//  deleteOldKlines.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation
import SwiftData

// Delete Old Klines
extension ChartView
{
    func deleteOldKlines()
    {
        let oldData = cachedKlines.filter
        {
            $0.openTime < Date().addingTimeInterval(-7 * 24 * 60 * 60)
        }
        for data in oldData
        {
            modelContext.delete(data)
        }
    }
}
