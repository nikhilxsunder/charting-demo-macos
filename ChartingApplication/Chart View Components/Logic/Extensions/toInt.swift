//
//  toInt.swift
//  ChartingApplication
//
//  Created by Nikhil Sunder on 2/13/25.
//

import Foundation

// ToInt Helper
extension TimeInterval {
    func toInt() -> Int {
        return Int(self * 1000)
    }
}
