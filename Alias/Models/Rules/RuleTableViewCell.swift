//
//  RuleTableViewCell.swift
//  Alias
//
//  Created by Даниил Симахин on 03.05.2022.
//

import UIKit

class RuleTableViewCell: UITableViewCell {

    let imageRule: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Constants.Colors.bottomButtonColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let labelRule: UILabel = {
        $0.textColor = Constants.Colors.textColor
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    static let identifier = "RuleTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(labelRule)
        contentView.addSubview(imageRule)
        NSLayoutConstraint.activate([
            imageRule.widthAnchor.constraint(equalToConstant: 50),
            imageRule.heightAnchor.constraint(equalToConstant: 50),
            imageRule.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageRule.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        
            labelRule.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelRule.leadingAnchor.constraint(equalTo: imageRule.trailingAnchor, constant: 10),
            labelRule.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        
            contentView.topAnchor.constraint(equalTo: labelRule.topAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: labelRule.bottomAnchor, constant: 10),
            
            contentView.topAnchor.constraint(lessThanOrEqualTo: imageRule.topAnchor, constant: -10),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: imageRule.bottomAnchor, constant: 10)
        ])
        
    }

}
