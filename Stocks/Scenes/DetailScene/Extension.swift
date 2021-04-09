//
//  Extension.swift
//  Stocks
//
//  Created by msc on 06.04.2021.
//

import Foundation

extension Double {
    func rounder(toDecimalPlaces n: Int) -> Double {
            return Double(String(format: "%.\(n)f", self))!
        }
}
