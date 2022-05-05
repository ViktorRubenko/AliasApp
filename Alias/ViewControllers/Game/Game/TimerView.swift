//
//  TimerView.swift
//  Alias
//
//  Created by Victor Rubenko on 05.05.2022.
//

import UIKit

class TimerView: UIView {

    var timerValue = 0 {
        didSet {
            timerLabel.text = formatSeconds(value: timerValue)
        }
    }
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .regular)
        label.textColor = Constants.Colors.secondaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = Constants.Colors.bottomButtonColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            timerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ])
    }
    
    private func formatSeconds(value: Int) -> String {
        let minutes = value / 60
        let seconds = value % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
