//
//  GameHeaderView.swift
//  Alias
//
//  Created by Victor Rubenko on 05.05.2022.
//

import UIKit

class GameHeaderView: UIView {
    
    var guessedValue = 0 {
        didSet {
            guessedWordLabel.text = "\(guessedValue)"
        }
    }
    
    private lazy var guessedWordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 65, weight: .bold)
        label.textAlignment = .center
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.Colors.secondaryTextColor
        return label
    }()
    
    private lazy var guessedWordPlaceholder: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ОЧКИ"
        label.textColor = Constants.Colors.secondaryTextColor
        return label
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = Constants.Colors.navBarColor
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        addSubview(container)
        
        container.addSubview(guessedWordLabel)
        container.addSubview(guessedWordPlaceholder)
        
        NSLayoutConstraint.activate([
            guessedWordLabel.topAnchor.constraint(equalTo: container.topAnchor),
            guessedWordLabel.widthAnchor.constraint(equalTo: widthAnchor),
            guessedWordLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            guessedWordPlaceholder.topAnchor.constraint(equalTo: guessedWordLabel.bottomAnchor, constant: -5),
            guessedWordPlaceholder.widthAnchor.constraint(equalTo: widthAnchor),
            guessedWordPlaceholder.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            guessedWordPlaceholder.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor),
            
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
}
