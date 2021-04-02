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

    //MARK: - UI
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
         return label
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
         return label
    }()
    
    let changePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .black
         return label
    }()
    
    let openPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let openPriceBeidgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Open"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let maxPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let maxPriceBeidgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "High"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let minPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let minPriceBeidgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Low"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let volLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let volBeidgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Vol"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let peLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let peBeidgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "P/E"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let mktCapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let mktCapBeidgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Mkt Cap"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let maxYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let maxYearBeidgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "52W H"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let minYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let minYearBeidgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "52W L"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let midVolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let midVolBeidgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Avg Vol"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let chart = Chart(frame: CGRect.zero)
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavTitle()
        setupData()
        setupLayout()
        createChart()
        view.backgroundColor = .white
        interactor?.fetchHistory()
        
    }
//MARK:-Methods
    
    func createChart() {
        let data = historyData.map { (chart) in
            chart.midRate
        }
        print(data)
        let series = ChartSeries(data)
        
        chart.add(series)
    }
    
    func setupNavTitle()  {
        let stackView = UIStackView(arrangedSubviews: [symbolLabel, nameLabel])
        stackView.axis = .vertical
        stackView.frame.size = CGSize(width: symbolLabel.frame.size.width + nameLabel.frame.size.width, height: max(symbolLabel.frame.size.height, nameLabel.frame.size.height))
        stackView.spacing = 4
        
        navigationItem.titleView = stackView
    }
    
    func setupData() {
        nameLabel.text = stock?.fullName
        symbolLabel.text = stock?.symbol
        priceLabel.text = String(stock?.price ?? 0) + "$" 
        changePriceLabel.text = String(format: "%.2f", stock?.changePrice ?? 0) + "$ " + "(" + String(format: "%.2f", stock?.changePercent ?? 0) + "%)"
        changePriceLabel.textColor = stock!.changePrice > 0 ? .green : .red
        
        openPriceLabel.text = String(stock?.regularMarketOpen ?? 0)
        maxPriceLabel.text = String(stock?.regularMarketDayHigh ?? 0)
        minPriceLabel.text = String(stock?.regularMarketDayLow ?? 0)
        
        volLabel.text = String(format: "%.2f",Double(stock!.regularMarketVolume)/1000000) + "M"
        peLabel.text = String(format: "%.2f",stock?.trailingPE ?? 0)
        mktCapLabel.text = String(format: "%.2f",Double(stock!.marketCap)/1000000000) + "B"
        
        maxYearLabel.text = String(stock?.fiftyTwoWeekHigh ?? 0)
        minYearLabel.text = String(stock?.fiftyTwoWeekLow ?? 0)
        midVolLabel.text = String(format: "%.2f",Double(stock!.averageDailyVolume3Month)/1000000) + "M"
    
    }
    
   private func setupLayout() {
    view.addSubview(priceLabel)
    view.addSubview(changePriceLabel)
    view.addSubview(openPriceLabel)
    view.addSubview(openPriceBeidgeLabel)
    view.addSubview(maxPriceLabel)
    view.addSubview(maxPriceBeidgeLabel)
    view.addSubview(minPriceLabel)
    view.addSubview(minPriceBeidgeLabel)
    view.addSubview(volLabel)
    view.addSubview(volBeidgeLabel)
    view.addSubview(peLabel)
    view.addSubview(peBeidgeLabel)
    view.addSubview(mktCapLabel)
    view.addSubview(mktCapBeidgeLabel)
    view.addSubview(maxYearLabel)
    view.addSubview(maxYearBeidgeLabel)
    view.addSubview(minYearLabel)
    view.addSubview(minYearBeidgeLabel)
    view.addSubview(midVolLabel)
    view.addSubview(midVolBeidgeLabel)
    view.addSubview(chart)
    priceLabel.snp.makeConstraints { (make) in
        make.centerX.equalToSuperview()
        make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
    }
    
    changePriceLabel.snp.makeConstraints { (make) in
        make.centerX.equalToSuperview()
        make.top.equalTo(priceLabel.snp.bottom).offset(8)
    }
    
    openPriceBeidgeLabel.snp.makeConstraints { (make) in
        make.top.equalTo(changePriceLabel.snp.bottom).offset(20)
        make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
    }
    maxPriceBeidgeLabel.snp.makeConstraints { (make) in
        make.top.equalTo(openPriceBeidgeLabel.snp.bottom).offset(8)
        make.leading.equalTo(openPriceBeidgeLabel.snp.leading)
    }
    minPriceBeidgeLabel.snp.makeConstraints { (make) in
        make.top.equalTo(maxPriceBeidgeLabel.snp.bottom).offset(8)
        make.leading.equalTo(openPriceBeidgeLabel.snp.leading)
    }
    
    openPriceLabel.snp.makeConstraints { (make) in
        make.top.equalTo(openPriceBeidgeLabel.snp.top)
        make.leading.equalTo(openPriceBeidgeLabel.snp.trailing).offset(16)
    }
    maxPriceLabel.snp.makeConstraints { (make) in
        make.top.equalTo(maxPriceBeidgeLabel.snp.top)
        make.leading.equalTo(openPriceLabel.snp.leading)
    }
    
    minPriceLabel.snp.makeConstraints { (make) in
        make.top.equalTo(minPriceBeidgeLabel.snp.top)
        make.leading.equalTo(openPriceLabel.snp.leading)
    }
    
    volBeidgeLabel.snp.makeConstraints { (make) in
        make.top.equalTo(openPriceBeidgeLabel.snp.top)
        make.leading.equalTo(mktCapBeidgeLabel.snp.leading)
    }
    
    peBeidgeLabel.snp.makeConstraints { (make) in
        make.top.equalTo(maxPriceBeidgeLabel.snp.top)
        make.leading.equalTo(mktCapBeidgeLabel.snp.leading)
    }
    
    mktCapBeidgeLabel.snp.makeConstraints { (make) in
        make.top.equalTo(minPriceBeidgeLabel.snp.top)
        make.trailing.equalTo(mktCapLabel.snp.leading).offset(-20)
    }
    
    volLabel.snp.makeConstraints { (make) in
        make.top.equalTo(volBeidgeLabel.snp.top)
        make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
    }
    
    peLabel.snp.makeConstraints { (make) in
        make.top.equalTo(peBeidgeLabel.snp.top)
        make.trailing.equalTo(volLabel.snp.trailing)
    }
    
    mktCapLabel.snp.makeConstraints { (make) in
        make.top.equalTo(minPriceLabel.snp.top)
        make.trailing.equalTo(volLabel.snp.trailing)
    }
    
    maxYearBeidgeLabel.snp.makeConstraints { (make) in
        make.top.equalTo(minPriceBeidgeLabel.snp.bottom).offset(20)
        make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
    }
    minYearBeidgeLabel.snp.makeConstraints { (make) in
        make.top.equalTo(maxYearBeidgeLabel.snp.bottom).offset(8)
        make.leading.equalTo(maxYearBeidgeLabel.snp.leading)
    }
    
    midVolBeidgeLabel.snp.makeConstraints { (make) in
        make.top.equalTo(minYearBeidgeLabel.snp.bottom).offset(8)
        make.leading.equalTo(maxYearBeidgeLabel.snp.leading)
    }
    
    maxYearLabel.snp.makeConstraints { (make) in
        make.top.equalTo(maxYearBeidgeLabel.snp.top)
        make.leading.equalTo(maxYearBeidgeLabel.snp.trailing).offset(20)
    }
    
    minYearLabel.snp.makeConstraints { (make) in
        make.top.equalTo(minYearBeidgeLabel.snp.top)
        make.leading.equalTo(maxYearLabel.snp.leading)
    }
    
    midVolLabel.snp.makeConstraints { (make) in
        make.top.equalTo(midVolBeidgeLabel.snp.top)
        make.leading.equalTo(maxYearLabel.snp.leading)
    }
    
    chart.snp.makeConstraints { (make) in
        make.top.equalTo(midVolLabel.snp.bottom).offset(8)
        make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        make.height.equalTo(250)
    }
    
    
    }
    
}

extension DetailViewController: DetailDisplayLogic {
    func swowData(data: [ChartViewModel]) {
        
        historyData = data.filter { $0.symbol == stock?.symbol}
       
    }
    
    func showError() {
        
    }
    
    
}
