//
//  NewsVCFactory.swift
//  Stocks
//
//  Created by msc on 09.04.2021.
//

import Foundation
class NewsFactory {
    static func getVC() -> NewsViewController {
        let vc = NewsViewController()
        let presenter = NewsPresenter()
        let api = APIClientclass()
        let interactor = NewsInteractor(api: api, presenter: presenter)
        interactor.presenter = presenter
        presenter.newsVC = vc
        vc.interactor = interactor
        return vc
    }
}
