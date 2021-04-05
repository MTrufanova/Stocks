//
//  DetailsView.swift
//  Stocks
//
//  Created by msc on 02.04.2021.
//

import UIKit
import SwiftChart

final class DetailView: UIView {
    
    let detailView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
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
    
    let changePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .black
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
    let chart = Chart(frame: CGRect.zero)

    var first = UIView()
    var second = UIView()
    var third = UIView()
    
    init() {
        super.init(frame: CGRect.zero)
        first = createViews(firstItem: openPriceLabel, secItem: maxPriceLabel, thirdItem: minPriceLabel, firstText: "Open", secText: "High", thirdText: "Low", place: detailView)
        second = createViews(firstItem: volLabel, secItem: peLabel, thirdItem: mktCapLabel, firstText: "Vol", secText: "P/E", thirdText: "Mkt Cap", place: detailView)
        third = createViews(firstItem: maxYearLabel, secItem: minYearLabel, thirdItem: midVolLabel, firstText: "52W H", secText: "52W L", thirdText: "Avg Vol", place: detailView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(detailView)
        detailView.addSubview(first)
        detailView.addSubview(second)
        detailView.addSubview(third)
        detailView.addSubview(priceLabel)
        detailView.addSubview(changePriceLabel)
        detailView.addSubview(chart)
        
        priceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(detailView.safeAreaLayoutGuide).offset(16)
        }
        
        changePriceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
        }
        
        first.snp.makeConstraints { (make) in
            make.top.equalTo(changePriceLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        second.snp.makeConstraints { (make) in
            make.top.equalTo(first.snp.top)
            make.trailing.equalToSuperview().offset(-16)
        }
        third.snp.makeConstraints { (make) in
            make.top.equalTo(first.snp.bottom).offset(20)
            make.leading.equalTo(first.snp.leading)
        }
        
         chart.snp.makeConstraints { (make) in
             make.top.equalTo(third.snp.bottom).offset(10)
             make.leading.trailing.equalTo(detailView.safeAreaLayoutGuide).inset(8)
             make.height.equalTo(250)
         }
    }
    
}

extension DetailView {
    func createViews( firstItem: UILabel, secItem: UILabel, thirdItem: UILabel, firstText: String, secText: String, thirdText: String, place: UIView) -> UIView {
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
       
       let stack = UIStackView(arrangedSubviews: [stackViewLabel, stackViewItems])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.frame.size = CGSize(width: stackViewLabel.frame.size.width + stackViewItems.frame.size.width, height: stackViewLabel.frame.size.height + stackViewItems.frame.size.height)
        return stack
   }
}
