//
//  StocksModel.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import Foundation

typealias StockResponse = [Stock]

struct Stock: Decodable {
    let shortName: String
    let symbol: String
    let regularMarketPrice: Double
    let regularMarketChange: Double
    let regularMarketChangePercent: Double
    
    let regularMarketOpen: Double
    let regularMarketDayHigh: Double
    let regularMarketDayLow: Double
    
    let regularMarketVolume: Int
    let trailingPE: Double?
    let marketCap: Int
    
    let fiftyTwoWeekHigh: Double
    let fiftyTwoWeekLow: Double
    let averageDailyVolume3Month: Int
    
    
}

struct StocksViewModel: Codable {
    let fullName: String
    let symbol: String
    let price: Double
    let changePrice: Double
    let changePercent: Double
    var isFavourite: Bool
    
    let regularMarketOpen: Double
    let regularMarketDayHigh: Double
    let regularMarketDayLow: Double
    
    let regularMarketVolume: Int
    let trailingPE: Double?
    let marketCap: Int
    
    let fiftyTwoWeekHigh: Double
    let fiftyTwoWeekLow: Double
    let averageDailyVolume3Month: Int
    
  
}
