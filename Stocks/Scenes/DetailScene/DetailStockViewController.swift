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
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.detailVC = self
        return mb
    }()
    
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupMenuBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        menuBar.isHidden = true
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
        self.contentView.chart.yLabelsOnRightSide = true
        self.contentView.chart.gridColor = .clear
        self.contentView.chart.highlightLineColor = .black
        self.contentView.chart.add(series)
    }
    
    private func setupMenuBar()  {
        navigationController?.navigationBar.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
    
   private func setupNavTitle()  {
        let stackView = UIStackView(arrangedSubviews: [self.contentView.symbolLabel, self.contentView.nameLabel])
        stackView.axis = .vertical
        stackView.frame.size = CGSize(width: self.contentView.symbolLabel.frame.size.width + self.contentView.nameLabel.frame.size.width, height: max(self.contentView.symbolLabel.frame.size.height, self.contentView.nameLabel.frame.size.height))
        stackView.spacing = 4
        
        navigationItem.titleView = stackView
    }
    
    func setupData() {
        guard let stock = stock else {return}
        self.contentView.nameLabel.text = stock.fullName
        self.contentView.symbolLabel.text = stock.symbol
        self.contentView.priceLabel.text = String(stock.price) + "$"
        self.contentView.changePriceLabel.text = String(format: "%.2f", stock.changePrice) + "$ " + "(" + String(format: "%.2f", stock.changePercent) + "%)"
        self.contentView.changePriceLabel.textColor = stock.changePrice > 0 ? #colorLiteral(red: 0.1411764706, green: 0.6980392157, blue: 0.3647058824, alpha: 1) : .red
        
        self.contentView.openPriceLabel.text = String(stock.regularMarketOpen)
        self.contentView.maxPriceLabel.text = String(stock.regularMarketDayHigh)
        self.contentView.minPriceLabel.text = String(stock.regularMarketDayLow)
        
        self.contentView.volLabel.text = String(format: "%.2f",Double(stock.regularMarketVolume)/1000000) + "M"
        self.contentView.peLabel.text = String(format: "%.2f",stock.trailingPE ?? 0)
        self.contentView.mktCapLabel.text = String(format: "%.2f",Double(stock.marketCap)/1000000000) + "B"
        
        self.contentView.maxYearLabel.text = String(stock.fiftyTwoWeekHigh)
        self.contentView.minYearLabel.text = String(stock.fiftyTwoWeekLow)
        self.contentView.midVolLabel.text = String(format: "%.2f",Double(stock.averageDailyVolume3Month)/1000000) + "M"
        
    }
    
    
}

extension DetailViewController: DetailDisplayLogic {
    func swowData(data: [ChartViewModel]) {
        historyData = data.filter { $0.symbol == stock?.symbol}.sorted(by: { $0.timestamp < $1.timestamp })
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
                    self.contentView.chartInfoLabel.text = String(touchedValue) + "$"
                    let date = Date(timeIntervalSince1970: x)
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
                    dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
                   let labelText = dateFormatter.string(from: date)
                    self.contentView.chartDateLabel.text = "\(labelText)"
                }
                self.contentView.changePriceLabel.isHidden = true
                self.contentView.priceLabel.isHidden = true
                self.contentView.chartInfoLabel.isHidden = false
                self.contentView.chartDateLabel.isHidden = false
            }
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        self.contentView.changePriceLabel.isHidden = false
        self.contentView.priceLabel.isHidden = false
        self.contentView.chartInfoLabel.isHidden = true
        self.contentView.chartDateLabel.isHidden = true
    }
}



