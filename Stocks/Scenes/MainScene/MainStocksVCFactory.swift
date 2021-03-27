//
//  MainStocksVCFactory.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import Foundation

class MainStocksFactory {
    static func getVC() -> MainStocksTableViewController {
        let vc = MainStocksTableViewController()
        let presenter = MainStocksPresenter()
        let api = APIClientclass()
        let interactor = MainStocksInteractor(api: api, presenter: presenter)
        
        interactor.presenter = presenter
        presenter.viewController = vc
        vc.interactor = interactor
       
        return vc
    }
}
