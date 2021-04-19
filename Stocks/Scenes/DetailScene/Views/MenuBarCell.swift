//
//  MenuBarCell.swift
//  Stocks
//
//  Created by msc on 14.04.2021.
//

import UIKit

class MenuBarCell: UICollectionViewCell {
    lazy var menuLabel: UILabel = {
     let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    override var isHighlighted: Bool {
        didSet {
            menuLabel.textColor = isHighlighted ? .black : .gray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            menuLabel.textColor = isSelected ? .black : .gray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(menuLabel)
        menuLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
