//
//  MainStocksTableViewController.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import UIKit
protocol StocksDisplayLogic: class {
    func showData(data: [Stock])
    func showError()
}

class MainStocksTableViewController: UITableViewController {

    let cellID = "cell"
    
   private var stocks = [Stock]()
    var interactor: MainStocksBusinessLogic?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchStocks()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Stocks"
        tableView.register(MainStockCell.self, forCellReuseIdentifier: cellID)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MainStockCell {

        let stock = stocks[indexPath.row]
        cell.setupCell(stock)
        cell.selectionStyle = .none

        return cell
    }
    return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }

}

extension MainStocksTableViewController: StocksDisplayLogic {
    func showData(data: [Stock]) {
        stocks = data
        tableView.reloadData()
    }
    
    func showError() {
        
    }
    
    
}
