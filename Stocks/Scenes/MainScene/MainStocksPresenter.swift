//
//  MainStocksPresenter.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import Foundation
protocol MainStocksPresentationLogic {
    func presentSuccess(data: [Stock])
    func failPresent()
}

class MainStocksPresenter {
    weak var viewController: StocksDisplayLogic?
}

extension MainStocksPresenter: MainStocksPresentationLogic {
    func presentSuccess(data: [Stock]) {
        let stockModel = data.map { (model) -> StocksViewModel in
            let cellModel = StocksViewModel(fullName: model.shortName, symbol: model.symbol, price: model.regularMarketPrice, changePrice: model.regularMarketChangePercent, changePercent: model.regularMarketChangePercent, regularMarketOpen: model.regularMarketOpen, regularMarketDayHigh: model.regularMarketDayHigh , regularMarketDayLow: model.regularMarketDayLow, regularMarketVolume: model.regularMarketVolume, trailingPE: model.trailingPE, marketCap: model.marketCap, fiftyTwoWeekHigh: model.fiftyTwoWeekHigh, fiftyTwoWeekLow: model.fiftyTwoWeekLow, averageDailyVolume3Month: model.averageDailyVolume3Month)
            return cellModel
        }
        self.viewController?.showData(data: stockModel)
    }
    
    func failPresent() {
        self.viewController?.showError()
    }
    
    
}
