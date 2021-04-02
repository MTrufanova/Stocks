//
//  DetailInteractor.swift
//  Stocks
//
//  Created by msc on 01.04.2021.
//

import Foundation
protocol DetailBusinessLogic {
    func fetchHistory() 
}

class DetailInteractor {
    
   private let api: APIClientclass
    var presenter: DetailPresentationLogic
    
    init(api: APIClientclass, presenter: DetailPresentationLogic) {
        self.api = api
        self.presenter = presenter
    }
}

extension DetailInteractor: DetailBusinessLogic {
    func fetchHistory() {
        api.fetchHistoryStock { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let historyStock):
                    self.presenter.presentSuccess(data: historyStock)
                case .failure(_):
                    self.presenter.presentFail()
                }
            }
        }
    }
    
    
}
