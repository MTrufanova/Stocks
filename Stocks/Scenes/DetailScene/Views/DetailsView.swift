//
//  DetailsView.swift
//  Stocks
//
//  Created by msc on 02.04.2021.
//

import UIKit
import SwiftChart
import SnapKit

final class DetailView: UIView {
    
    lazy var detailView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    lazy var financeScrollView = UIScrollView()
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
         return label
    }()
    
    lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
         return label
    }()
    
    lazy var changePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .black
         return label
    }()
    lazy var chartInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    lazy var chartDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    lazy var openPriceLabel = UILabel()
    lazy var maxPriceLabel = UILabel()
    lazy var minPriceLabel = UILabel()
    lazy var volLabel = UILabel ()
    lazy var peLabel = UILabel()
    lazy var mktCapLabel = UILabel()
    lazy var maxYearLabel = UILabel()
    lazy var minYearLabel = UILabel()
    lazy var midVolLabel = UILabel()
    lazy var chart = Chart()
    lazy var first = UIView()
    lazy var second = UIView()
    lazy var third = UIView()
    lazy var financeStack = UIStackView()
    
    init() {
        super.init(frame: CGRect.zero)
        first = createViews(firstItem: openPriceLabel, secItem: maxPriceLabel, thirdItem: minPriceLabel, firstText: "Open", secText: "High", thirdText: "Low")
        second = createViews(firstItem: volLabel, secItem: peLabel, thirdItem: mktCapLabel, firstText: "Vol", secText: "P/E", thirdText: "Mkt Cap")
        third = createViews(firstItem: maxYearLabel, secItem: minYearLabel, thirdItem: midVolLabel, firstText: "52W H", secText: "52W L", thirdText: "Avg Vol")
        financeStack = createFinanceStack(firstSubView: first, secondSubView: second, thirdSubView: third)
    
        detailView.backgroundColor = .white
        setupLayout()
        setupScroll()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScroll() {
        financeScrollView.contentSize = CGSize(width: financeStack.frame.size.width, height: financeStack.frame.size.height)
        financeScrollView.showsHorizontalScrollIndicator = false
    }
    
    private func setupLayout() {
        addSubview(detailView)
        detailView.addSubview(priceLabel)
        detailView.addSubview(changePriceLabel)
        detailView.addSubview(chart)
        detailView.addSubview(chartInfoLabel)
        detailView.addSubview(chartDateLabel)
        detailView.addSubview(financeScrollView)
        financeScrollView.addSubview(financeStack)
        
        priceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(detailView.safeAreaLayoutGuide).offset(16)
        }
        
        changePriceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
        }
        
         chart.snp.makeConstraints { (make) in
             make.top.equalTo(changePriceLabel.snp.bottom).offset(30)
             make.leading.trailing.equalTo(detailView.safeAreaLayoutGuide).inset(16)
             make.height.equalTo(250)
         }
        chartInfoLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(chartDateLabel.snp.bottom).offset(8)
        }
        chartDateLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(detailView.safeAreaLayoutGuide).offset(16)
        }
        
        financeScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(chart.snp.bottom).offset(20)
            make.leading.trailing.equalTo(detailView.safeAreaLayoutGuide).inset(10)
        }
        
        financeStack.snp.makeConstraints { (make) in
            make.top.equalTo(financeScrollView.snp.top)
            make.leading.trailing.equalTo(financeScrollView.contentSize)
            make.bottom.equalTo(financeScrollView.safeAreaLayoutGuide)
        }
        
    }
    
}

extension UIView {
    func createViews( firstItem: UILabel, secItem: UILabel, thirdItem: UILabel, firstText: String, secText: String, thirdText: String) -> UIView {
      let firstLabel = UILabel()
       firstLabel.textColor = .gray
       firstLabel.text = firstText
       firstLabel.font = .systemFont(ofSize: 16)
          
       firstItem.textColor = .black
       firstItem.font = .systemFont(ofSize: 16)
       firstItem.textAlignment = .right
       
       let secondLabel = UILabel()
       secondLabel.textColor = .gray
       secondLabel.text = secText
       secondLabel.font = .systemFont(ofSize: 16)
      
       secItem.textColor = .black
       secItem.font = .systemFont(ofSize: 16)
       secItem.textAlignment = .right
      
       let thirdLabel = UILabel()
       thirdLabel.textColor = .gray
       thirdLabel.text = thirdText
       thirdLabel.font = .systemFont(ofSize: 16)
      
       thirdItem.textColor = .black
       thirdItem.font = .systemFont(ofSize: 16)
       thirdItem.textAlignment = .right
       
       let stackViewLabel = UIStackView(arrangedSubviews: [firstLabel, secondLabel, thirdLabel])
       stackViewLabel.axis = .vertical
       stackViewLabel.spacing = 8
       stackViewLabel.frame.size = CGSize(width: max(firstLabel.frame.size.width, secondLabel.frame.size.width, thirdLabel.frame.size.width), height: firstLabel.frame.size.height + secondLabel.frame.size.height + thirdLabel.frame.size.height)
       
       let stackViewItems = UIStackView(arrangedSubviews: [firstItem, secItem, thirdItem])
       stackViewItems.axis = .vertical
       stackViewItems.spacing = 8
       stackViewItems.frame.size = CGSize(width: max(firstItem.frame.size.width, secItem.frame.size.width, thirdItem.frame.size.width), height: firstItem.frame.size.height + secItem.frame.size.height + thirdItem.frame.size.height)
       
        let viewMod = UIView()
        viewMod.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        viewMod.layer.cornerRadius = 5
        
       let stack = UIStackView(arrangedSubviews: [stackViewLabel, stackViewItems])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.frame.size = CGSize(width: (stackViewLabel.frame.size.width + stackViewItems.frame.size.width), height: stackViewLabel.frame.size.height)
        viewMod.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.centerX.equalTo(viewMod.snp.centerX)
            make.centerY.equalTo(viewMod.snp.centerY)
        }
        viewMod.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(100)
        }
        return viewMod
   }
    
    func createFinanceStack(firstSubView: UIView, secondSubView: UIView, thirdSubView: UIView) -> UIStackView {
        let financeStack = UIStackView(arrangedSubviews: [firstSubView, secondSubView, thirdSubView])
        financeStack.axis = .horizontal
        financeStack.spacing = 8
        financeStack.frame.size = CGSize(width: firstSubView.frame.size.width + secondSubView.frame.size.width + thirdSubView.frame.size.width, height: firstSubView.frame.size.height)
        return financeStack
    }
    
}
