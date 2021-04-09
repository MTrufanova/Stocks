//
//  DetailPresenter.swift
//  Stocks
//
//  Created by msc on 01.04.2021.
//

import Foundation
protocol DetailPresentationLogic {
    func presentSuccess(data: HistoryStocks)
    func presentFail() 
}

class DetailPresenter {
    weak var detailVC: DetailViewController?
}

extension DetailPresenter: DetailPresentationLogic {
  
    func presentSuccess(data: HistoryStocks) {
       let stock = data.items.map{ (key, value) in
            
        ChartViewModel(high: value.high, low: value.low, timestamp: key, symbol: data.meta.symbol)
           
        }
        self.detailVC?.swowData(data: stock)
        
    }
    
    func presentFail() {
        self.detailVC?.showError()
    }
    
    
}
//timestamp: convertToDate(unixTime: key)
