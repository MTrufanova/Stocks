//
//  MainStocksInteractor.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import Foundation
protocol MainStocksBusinessLogic {
    func fetchStocks()
}

class MainStocksInteractor {
    private let api: APIClientclass
    var presenter: MainStocksPresentationLogic
    
    init(api: APIClientclass, presenter: MainStocksPresentationLogic) {
        self.api = api
        self.presenter = presenter
    }
}

extension MainStocksInteractor: MainStocksBusinessLogic {
    func fetchStocks() {
        var stocks = [Stock]()
        api.fetchData(onResult: {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let stock):
                    stocks = stock
                    self.presenter.presentSuccess(data: stocks)
                case .failure(_):
                    self.presenter.failPresent()
                }
            }
        })
    }
    
    
}
