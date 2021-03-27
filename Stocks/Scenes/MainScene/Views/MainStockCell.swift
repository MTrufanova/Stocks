//
//  MainStockCell.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import UIKit
import SnapKit
class MainStockCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let symbolNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    let percentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ data: Stock)  {
        nameLabel.text = data.shortName
        symbolNameLabel.text = data.symbol
        priceLabel.text = String(data.regularMarketPrice)
        percentLabel.text = String(format: "%.2f", data.regularMarketChange) + "(" + String(format: "%.2f", data.regularMarketChangePercent) + "%)"
        data.regularMarketChangePercent > 0 ? (percentLabel.textColor = .green) : (percentLabel.textColor = .red)
    }
    
    private func setupLayout() {
        addSubview(nameLabel)
        addSubview(symbolNameLabel)
        addSubview(priceLabel)
        addSubview(percentLabel)
        symbolNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(14)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(150)
            make.top.equalTo(symbolNameLabel.snp.bottom)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(14)
        }
        percentLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(100)
            make.top.equalTo(priceLabel.snp.bottom)
        }
    }

}
