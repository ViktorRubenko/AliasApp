//
//  RuleTableViewCell.swift
//  Alias
//
//  Created by Даниил Симахин on 03.05.2022.
//

import UIKit

class RuleTableViewCell: UITableViewCell {

    static let identifier = "RuleTableViewCell"
    
    let indexLabel: UILabel = {
        $0.font = .systemFont(ofSize: 50)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = Constants.Colors.bottomButtonColor
        return $0
    }(UILabel())
    
    let labelRule: UILabel = {
        $0.textColor = Constants.Colors.textColor
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(labelRule)
        contentView.addSubview(indexLabel)
        NSLayoutConstraint.activate([
            indexLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            indexLabel.widthAnchor.constraint(equalToConstant: 50),
        
            labelRule.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelRule.leadingAnchor.constraint(equalTo: indexLabel.trailingAnchor, constant: 10),
            labelRule.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        
            contentView.topAnchor.constraint(equalTo: labelRule.topAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: labelRule.bottomAnchor, constant: 10),
            
            contentView.topAnchor.constraint(lessThanOrEqualTo: indexLabel.topAnchor, constant: -10),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: indexLabel.bottomAnchor, constant: 10)
        ])
        
    }

}
