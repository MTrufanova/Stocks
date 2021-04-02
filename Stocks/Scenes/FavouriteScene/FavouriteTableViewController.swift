//
//  FavouriteTableViewController.swift
//  Stocks
//
//  Created by msc on 26.03.2021.
//

import UIKit

class FavouriteTableViewController: UITableViewController {

    let favCell = "CellID"
    var favouriteStocks: [StocksViewModel] {
        
        get {
            guard let encodedData = UserDefaults.standard.array(forKey: "key") as? [Data] else {
                return []
            }
            
            return encodedData.map { try! JSONDecoder().decode(StocksViewModel.self, from: $0)}
        }
        
        set {
            let data = newValue.map { try? JSONEncoder().encode($0) }
            UserDefaults.standard.set(data, forKey: "key")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Favourite"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: favCell)
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favouriteStocks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favCell, for: indexPath) as? FavouriteCell else {return UITableViewCell()}

        let stock = favouriteStocks[indexPath.row]
        cell.setupCell(stock)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVCFactory.getDetailVC()
        let stock = favouriteStocks[indexPath.row]
        detailVC.stock = stock
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     
        return true
    }
   

  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favouriteStocks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    

  

}
