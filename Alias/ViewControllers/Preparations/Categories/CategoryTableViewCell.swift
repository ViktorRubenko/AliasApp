//
//  CatergoryTableViewCell.swift
//  Alias
//
//  Created by Даниил Симахин on 06.05.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let identifire = "CategoryTableViewCell"
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = Constants.Colors.bottomButtonColor
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 25, weight: .bold)
        title.textColor = Constants.Colors.textColor
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    let bgSubTitle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.numberOfLines = 1
        subTitle.textColor = Constants.Colors.textColor
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        return subTitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(bgSubTitle)
        bgSubTitle.addSubview(subTitle)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            title.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5),

            bgSubTitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            bgSubTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bgSubTitle.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5),
            
            subTitle.leadingAnchor.constraint(equalTo: bgSubTitle.leadingAnchor, constant: 5),
            subTitle.trailingAnchor.constraint(equalTo: bgSubTitle.trailingAnchor, constant: -5),
            subTitle.centerYAnchor.constraint(equalTo: bgSubTitle.centerYAnchor),

            contentView.topAnchor.constraint(equalTo: title.topAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: bgSubTitle.bottomAnchor, constant: 10),
        ])
        
    }

}
