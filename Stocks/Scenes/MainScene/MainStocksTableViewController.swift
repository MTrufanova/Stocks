//
//  MainStocksTableViewController.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import UIKit
protocol StocksDisplayLogic: class {
    func showData(data: [StocksViewModel])
    func showError()
}

class MainStocksTableViewController: UITableViewController {

    let cellID = "cell"
    
   private var stocks = [StocksViewModel]()
    private var filterStock = [StocksViewModel]()
    var interactor: MainStocksBusinessLogic?
    let searchController = UISearchController(searchResultsController: nil)
    let activityIndicator = UIActivityIndicatorView()
    
    var timer: Timer?
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Something went wrong. Please try again."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    
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
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        reloadButton.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        setupSearchBar()
        setupLayout()
        updateInfo()
    }

    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find company or ticker"
        definesPresentationContext = true
        navigationItem.searchController = searchController
        
    }
    func setupLayout() {
        
        tableView.addSubview(activityIndicator)
        tableView.addSubview(errorLabel)
        tableView.addSubview(reloadButton)
        
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        activityIndicator.startAnimating()
        
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
        }
        reloadButton.snp.makeConstraints { (make) in
            make.top.equalTo(errorLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
    }
    
    func updateInfo() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(loadData), userInfo: nil, repeats: true)
    }
    
  
    @objc func loadData() {
        interactor?.fetchStocks()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterStock .count
        }
        return stocks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MainStockCell {
           
            var stock: StocksViewModel
            if isFiltering {
                 stock = filterStock[indexPath.row]
                
            } else {
                 stock = stocks[indexPath.row]
              
            }
        cell.setupCell(stock)
            cell.buttonTap = {
                stock.isFavourite = !stock.isFavourite
               // self.stocks[indexPath.row] = stock
               // self.filterStock[indexPath.row] = stock
                let tabBar = self.tabBarController as! TabBarController
                let navVC = tabBar.viewControllers?[1] as! UINavigationController
                let favVC = navVC.topViewController as! FavouriteTableViewController
                favVC.favouriteStocks.append(stock)
                cell.favouriteButton.tintColor = stock.isFavourite ? #colorLiteral(red: 1, green: 0.7921568627, blue: 0.1098039216, alpha: 1) : #colorLiteral(red: 0.7294117647, green: 0.7294117647, blue: 0.7294117647, alpha: 1)
            }
        cell.selectionStyle = .none

        return cell
    }
    return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        var stock: StocksViewModel
        if isFiltering {
             stock = filterStock[indexPath.row]
            
        } else {
             stock = stocks[indexPath.row]
          
        }
        detailVC.stock = stock
        
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

extension MainStocksTableViewController: StocksDisplayLogic {
    func showData(data: [StocksViewModel]) {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        stocks = data
        tableView.reloadData()
    }
    
    func showError() {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }
    
    
}

extension MainStocksTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentSearchText(searchController.searchBar.text!)
        
    }
    
    private func filterContentSearchText(_ searchText: String) {
        filterStock = stocks.filter { (stock: StocksViewModel) -> Bool in
            return stock.fullName.lowercased().contains(searchText.lowercased())
        }
        filterStock += stocks.filter({ (stock: StocksViewModel) -> Bool in
            return stock.symbol.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
