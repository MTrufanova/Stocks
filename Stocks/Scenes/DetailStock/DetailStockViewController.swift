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
        setupNavTitle()
        setupData()
        configureChart(with: historyData)
    }
    
    //MARK:-Methods
    func configureChart(with viewModel: [ChartViewModel]) {
        self.contentView.chart.delegate = self
        let data = ChartHelper.convertValueToChartData(values: viewModel) ?? []
        let series = ChartSeries(data: data)
        let xLabels = ChartHelper.findLabels(data: data, axis: .X, numberPoint: 6)
        self.contentView.chart.xLabels = xLabels
        self.contentView.chart.xLabelsFormatter = {
            let date = Date(timeIntervalSince1970: $1)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
            dateFormatter.dateFormat = "MMM dd"
            return dateFormatter.string(from: date)
        }
        self.contentView.chart.yLabelsFormatter = { "$" + String(Int($1)) }
        series.area = true
        self.contentView.chart.hideHighlightLineOnTouchEnd = true
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


extension DetailViewController: ChartDelegate {
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        for (seriesIndex, dataIndex) in indexes.enumerated() {
            if dataIndex != nil {
                let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex)
                
                if let touchedValue = value {
                    self.contentView.chartInfoLabel.text = String(touchedValue)
                    let date = Date(timeIntervalSince1970: x)
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
                    dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
                   let labelText = dateFormatter.string(from: date)
                    
                    self.contentView.chartDateLabel.text = "\(labelText)"
                }
            }
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
    }
    
    func didEndTouchingChart(_ chart: Chart) {
    }
}



