//
//  GameFooterView.swift
//  Alias
//
//  Created by Victor Rubenko on 05.05.2022.
//

import UIKit

class GameFooterView: UIView {
    
    var skipValue = 0 {
        didSet {
            skipCountLabel.text = "\(skipValue)"
        }
    }
    
    private let resetCompletion: (() -> Void)
    
    private lazy var skipCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 65, weight: .bold)
        label.textAlignment = .center
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.Colors.secondaryTextColor
        return label
    }()
    
    private lazy var skipPlaceholder: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ПРОПУЩЕНО"
        label.textColor = Constants.Colors.secondaryTextColor
        return label
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitle("СБРОСИТЬ", for: .normal)
        button.setTitleColor(Constants.Colors.textColor, for: .normal)
        button.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(frame: CGRect, resetCompletion: @escaping () -> Void) {
        self.resetCompletion = resetCompletion
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = Constants.Colors.bottomBackgroundColor
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(container)
        container.addSubview(skipCountLabel)
        container.addSubview(skipPlaceholder)
        addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            skipCountLabel.topAnchor.constraint(equalTo: container.topAnchor),
            skipCountLabel.widthAnchor.constraint(equalTo: widthAnchor),
            skipCountLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            skipPlaceholder.topAnchor.constraint(equalTo: skipCountLabel.bottomAnchor, constant: -5),
            skipPlaceholder.widthAnchor.constraint(equalTo: widthAnchor),
            skipPlaceholder.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            skipPlaceholder.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor),
            
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor),
            
            resetButton.topAnchor.constraint(equalTo: container.bottomAnchor),
            resetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    @objc private func didTapResetButton() {
        resetCompletion()
    }
}

