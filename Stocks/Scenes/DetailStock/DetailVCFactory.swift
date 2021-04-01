//
//  DetailVCFactory.swift
//  Stocks
//
//  Created by msc on 01.04.2021.
//

import Foundation

class DetailVCFactory {
    static func getDetailVC() -> DetailViewController {
        let vc = DetailViewController()
        let api = APIClientclass()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor(api: api, presenter: presenter)
        
        interactor.presenter = presenter
        presenter.detailVC = vc
        vc.interactor = interactor
        return vc
    }
}
