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
        self.viewController?.showData(data: data)
    }
    
    func failPresent() {
        self.viewController?.showError()
    }
    
    
}
