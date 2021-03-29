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
        let detailVC = DetailViewController()
        let stock = favouriteStocks[indexPath.row]
        detailVC.stock = stock
        navigationController?.pushViewController(detailVC, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
