//
//  NewsPresenter.swift
//  Stocks
//
//  Created by msc on 09.04.2021.
//

import Foundation
protocol NewsPresentationLogic {
    func presentSuccess(data: NewsResponse)
    func presentFail()
}

class NewsPresenter {
    weak var newsVC: NewsViewController?
}
extension NewsPresenter: NewsPresentationLogic {
    func presentSuccess(data: NewsResponse) {
        self.newsVC?.showData(data: data)
    }
    
    func presentFail() {
        self.newsVC?.showError()
    }
    
    
}
