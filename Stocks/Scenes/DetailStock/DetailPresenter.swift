//
//  DetailPresenter.swift
//  Stocks
//
//  Created by msc on 01.04.2021.
//

import Foundation
protocol DetailPresentationLogic {
    func presentSuccess(data: [HistoryStocks] )
    func presentFail() 
}

class DetailPresenter {
    weak var detailVC: DetailViewController?
}

extension DetailPresenter: DetailPresentationLogic {
    func presentSuccess(data: [HistoryStocks]) {
        
        self.detailVC?.swowData(data: data)
    }
    
    func presentFail() {
        self.detailVC?.showError()
    }
    
    
}
