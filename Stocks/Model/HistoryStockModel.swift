//
//  HistoryStockModel.swift
//  Stocks
//
//  Created by msc on 31.03.2021.
//

import Foundation
//MARK: -вытащить дату, цену и символ, но на одну дату приходится несколько цен, этот порядок зашит в словаре items
struct Meta: Decodable {
    let symbol: String
}

struct Item: Decodable {
    let date: String
    let open, high, low, close: Double
}

struct HistoryStocks: Decodable {
    let meta: Meta
    let items: [String: Item]
}


typealias HistoryStock = [HistoryStocks]
