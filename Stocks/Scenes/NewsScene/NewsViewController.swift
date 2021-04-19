//
//  NewsViewController.swift
//  Stocks
//
//  Created by msc on 08.04.2021.
//

import UIKit
protocol NewsDisplayLogic: class {
    func showData(data: [NewsModel])
    func showError()
}

class NewsViewController: UIViewController {
    var interactor: NewsBusinessLogic?
    private let cellID = "cellNews"
    private var newsItems = [NewsModel]()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = .white
        table.tableFooterView = UIView()
        table.dataSource = self
        table.delegate = self
        return table
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        interactor?.fetchNews()
        navigationItem.title = "News"
    }
    
   private func setupTable() {
        view.addSubview(tableView)
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: cellID)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    

}
//MARK:-TableViewDelegate & TableViewDataSource
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let item = newsItems[indexPath.row]
        cell.setupCell(item)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsItems[indexPath.row]
        guard let newsURL = URL(string: news.link) else {
            return
        }
        let newsWebVC = NewsWebViewController(url: newsURL, title: news.source)
       
        //newsWebVC.newsWebItem = news
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(newsWebVC, animated: true)
    }
    
}

extension NewsViewController: NewsDisplayLogic {
    func showData(data: [NewsModel]) {
        newsItems = data
        tableView.reloadData()
    }
    
    func showError() {
        
    }
    
    
}
