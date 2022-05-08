//
//  GameSettingsTableViewCell.swift
//  Alias
//
//  Created by Даниил Симахин on 06.05.2022.
//

import UIKit

class GameSettingsTableViewCell: UITableViewCell {
    
    static var identifire = "GameSettingsTableViewCell"
    
    var callback: ((Float) -> ())?
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        title.backgroundColor = .clear
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = Constants.Colors.textColor
        return title
    }()
    let subTitleLabel: UILabel = {
        let subTitle = UILabel()
        subTitle.font = .systemFont(ofSize: 13, weight: .semibold)
        subTitle.textColor = .systemGray
        subTitle.backgroundColor = .clear
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        return subTitle
    }()
    let titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = .clear
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        scoreLabel.numberOfLines = 1
        scoreLabel.textColor = Constants.Colors.tertiaryTextColor
        scoreLabel.backgroundColor = .clear
        scoreLabel.textAlignment = .right
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return scoreLabel
    }()
    let slider: UISlider = {
        let slider = UISlider()
        slider.backgroundColor = .clear
        slider.minimumTrackTintColor = Constants.Colors.tertiaryTextColor
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGameSetting(settings: SettingCell, initialValue: (string : String, int: Int)) {
        titleLabel.text = settings.titleLabel
        scoreLabel.text = initialValue.string
        subTitleLabel.text = settings.subTitleLabel
        slider.minimumValue = Float(settings.sliderMinValue)
        slider.maximumValue = Float(settings.sliderMaxValue)
        slider.setValue(Float(initialValue.int), animated: false)
    }
    
    @objc func changeValueSlider(_ sender: UISlider) {
        scoreLabel.text = String(Int(round(sender.value)))
        callback?(round(sender.value))
        slider.value = round(sender.value)
    }
    
    func setupUI() {
        backgroundColor = .clear
        
        slider.addTarget(self, action: #selector(changeValueSlider), for: .valueChanged)
        
        contentView.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(subTitleLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(slider)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleView.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -10),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -10),

            subTitleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -10),
            subTitleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -10),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 10),

            slider.heightAnchor.constraint(equalToConstant: 20),
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            slider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            slider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            slider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            
            scoreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            scoreLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -10),
            scoreLabel.leadingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: 10),
        ])
    }
    
    
    
}
