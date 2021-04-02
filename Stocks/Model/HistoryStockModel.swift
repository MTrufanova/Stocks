//
//  HistoryStockModel.swift
//  Stocks
//
//  Created by msc on 31.03.2021.
//

import Foundation

protocol CharModel {
    var symbol: String {get set}
    var timestamp: String {get set}
    var high: Double {get set}
    var low: Double {get set}
  //  var midRate: Double {get set}
}

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
    //var high: Double
    //var low: Double
   // var midRate: Double {
  //      return (high + low) / 2
  //  }

    init(high: Double, low: Double, timestamp: String, symbol: String) {
        self.midRate = (high + low) / 2
        self.timestamp = timestamp
        self.symbol = symbol
    }
}

/*func convert(stocks: HistoryStocks) -> [ChartViewModel] {
    stocks.items.map { (key, value) in
        .init(
            high: value.high,
            low: value.low,
            timestamp: key,
            symbol: stocks.meta?.symbol
        )
    }
}*/
