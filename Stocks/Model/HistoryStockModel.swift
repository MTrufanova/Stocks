//
//  HistoryStockModel.swift
//  Stocks
//
//  Created by msc on 31.03.2021.
//

import Foundation


struct Meta: Decodable {
    let symbol: String
}

struct Item: Decodable {
    let date: String
    let high, low: Double
}

struct HistoryStocks: Decodable {
    let meta: Meta
    let items: [String: Item]
   
}


struct ChartViewModel {
    
    var symbol: String
    let midRate: Double
    var timestamp: String

    init(high: Double, low: Double, timestamp: String, symbol: String) {
        self.midRate = (high + low) / 2
        self.timestamp = timestamp
        self.symbol = symbol
    }
}


