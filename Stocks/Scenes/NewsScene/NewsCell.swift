//
//  NewsCell.swift
//  Stocks
//
//  Created by msc on 09.04.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var dateSourseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    func setupCell(_ data: NewsModel) {
        titleLabel.text = data.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: data.pubDate)
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        let dateToDisplay = dateFormatter.string(from: date ?? Date())
        dateSourseLabel.text = dateToDisplay + " - " + data.source
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(dateSourseLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
            make.height.equalTo(70)
        }
        dateSourseLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
