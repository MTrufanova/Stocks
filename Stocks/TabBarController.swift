//
//  TabBarController.swift
//  Stocks
//
//  Created by msc on 26.03.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        view.backgroundColor = .gray
        let stocksVC = MainStocksFactory.getVC()
        let favouriteVC = FavouriteTableViewController()
        viewControllers = [generateNavigationContoller(rootViewController: stocksVC, title: "Stocks", image: UIImage(named: "stock") ?? UIImage()), generateNavigationContoller(rootViewController: favouriteVC, title: "Favourite", image: UIImage(systemName: "star.fill") ?? UIImage())]
    }
    
    private func generateNavigationContoller(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
