//
//  NewsInteractor.swift
//  Stocks
//
//  Created by msc on 09.04.2021.
//

import Foundation

protocol NewsBusinessLogic {
    func fetchNews()
}

class NewsInteractor {
    private let api: APIClientclass
    var presenter: NewsPresentationLogic
    
    init(api: APIClientclass, presenter: NewsPresentationLogic) {
        self.api = api
        self.presenter = presenter
    }
}

extension NewsInteractor: NewsBusinessLogic {
    func fetchNews() {
        api.fetchNews { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.presenter.presentSuccess(data: news)
                case .failure(_):
                    self.presenter.presentFail()
                    
                }
            }
        }
    }
    
   
}
