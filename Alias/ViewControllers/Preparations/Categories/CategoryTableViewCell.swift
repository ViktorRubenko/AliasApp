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
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.numberOfLines = 1
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
        contentView.addSubview(view)
        view.addSubview(subTitle)
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            
            view.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            view.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            
            subTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            subTitle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            contentView.topAnchor.constraint(equalTo: title.topAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            
            contentView.topAnchor.constraint(lessThanOrEqualTo: image.topAnchor, constant: -10),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: image.bottomAnchor, constant: 10)
        ])
        
    }

}
