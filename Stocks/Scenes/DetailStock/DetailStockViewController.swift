//
//  ViewController.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import UIKit
import SnapKit
import SwiftChart

protocol DetailDisplayLogic: class {
    func swowData(data:[ChartViewModel])
    func showError()
}
class DetailViewController: UIViewController {
    var interactor: DetailBusinessLogic?
    var stock: StocksViewModel?
    var historyData = [ChartViewModel]()
    
    lazy var contentView = DetailView()
    override func loadView() {
        self.view = contentView
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchHistory()
        view.backgroundColor = .white
        setupNavTitle()
        setupData()
       configureChart(with: historyData)
    }

//MARK:-Methods
    func configureChart(with viewModel: [ChartViewModel]) {
        
             let data = viewModel.map { (chart) in
                 chart.midRate
             }
             let series = ChartSeries(data)
        self.contentView.chart.add(series)
     }
    
    func setupNavTitle()  {
        let stackView = UIStackView(arrangedSubviews: [self.contentView.symbolLabel, self.contentView.nameLabel])
        stackView.axis = .vertical
        stackView.frame.size = CGSize(width: self.contentView.symbolLabel.frame.size.width + self.contentView.nameLabel.frame.size.width, height: max(self.contentView.symbolLabel.frame.size.height, self.contentView.nameLabel.frame.size.height))
        stackView.spacing = 4
        
        navigationItem.titleView = stackView
    }
    
    func setupData() {
        self.contentView.nameLabel.text = stock?.fullName
        self.contentView.symbolLabel.text = stock?.symbol
        self.contentView.priceLabel.text = String(stock?.price ?? 0) + "$"
        self.contentView.changePriceLabel.text = String(format: "%.2f", stock?.changePrice ?? 0) + "$ " + "(" + String(format: "%.2f", stock?.changePercent ?? 0) + "%)"
        self.contentView.changePriceLabel.textColor = stock!.changePrice > 0 ? .green : .red
        
        self.contentView.openPriceLabel.text = String(stock?.regularMarketOpen ?? 0)
        self.contentView.maxPriceLabel.text = String(stock?.regularMarketDayHigh ?? 0)
        self.contentView.minPriceLabel.text = String(stock?.regularMarketDayLow ?? 0)
        
        self.contentView.volLabel.text = String(format: "%.2f",Double(stock!.regularMarketVolume)/1000000) + "M"
        self.contentView.peLabel.text = String(format: "%.2f",stock?.trailingPE ?? 0)
        self.contentView.mktCapLabel.text = String(format: "%.2f",Double(stock!.marketCap)/1000000000) + "B"
        
        self.contentView.maxYearLabel.text = String(stock?.fiftyTwoWeekHigh ?? 0)
        self.contentView.minYearLabel.text = String(stock?.fiftyTwoWeekLow ?? 0)
        self.contentView.midVolLabel.text = String(format: "%.2f",Double(stock!.averageDailyVolume3Month)/1000000) + "M"
    
    }
    
}

extension DetailViewController: DetailDisplayLogic {
    func swowData(data: [ChartViewModel]) {
        historyData = data.filter { $0.symbol == stock?.symbol}
        configureChart(with: historyData)
       
    }
    
    func showError() {
        
    }
    
}


