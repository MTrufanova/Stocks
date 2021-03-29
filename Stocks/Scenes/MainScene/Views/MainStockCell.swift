//
//  MainStockCell.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import UIKit
import SnapKit
class MainStockCell: UITableViewCell {
    
    var buttonTap: () -> () = { }
    
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
    
    let favouriteButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        favouriteButton.addTarget(self, action: #selector(didTapFavButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
   @objc func didTapFavButton() {
        buttonTap()
    }
    
    func setupCell(_ data: StocksViewModel)  {
        nameLabel.text = data.fullName
        symbolNameLabel.text = data.symbol
        priceLabel.text = String(data.price)
        percentLabel.text = String(format: "%.2f", data.changePrice) + "(" + String(format: "%.2f", data.changePercent) + "%)"
        data.changePercent > 0 ? (percentLabel.textColor = .green) : (percentLabel.textColor = .red)
        favouriteButton.tintColor = data.isFavourite ? #colorLiteral(red: 1, green: 0.7921568627, blue: 0.1098039216, alpha: 1) : #colorLiteral(red: 0.7294117647, green: 0.7294117647, blue: 0.7294117647, alpha: 1)
    }
    
    private func setupLayout() {
        addSubview(nameLabel)
        addSubview(symbolNameLabel)
        addSubview(priceLabel)
        addSubview(percentLabel)
        contentView.addSubview(favouriteButton)
        
        symbolNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(symbolNameLabel.snp.bottom)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(14)
        }
        percentLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalTo(priceLabel.snp.bottom)
        }
        favouriteButton.snp.makeConstraints { (make) in
            make.top.equalTo(symbolNameLabel.snp.top)
            make.leading.equalTo(symbolNameLabel.snp.trailing).offset(8)
        }
    }

}
