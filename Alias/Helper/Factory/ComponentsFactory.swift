//
//  ComponentFactory.swift
//  Alias
//
//  Created by Victor Rubenko on 02.05.2022.
//

import UIKit

protocol ComponentsBaseFactory {
    func bottomButton() -> UIButton
    func mainMenuButton() -> UIButton
    func footerLabel() -> UILabel
}

struct ComponentFactory: ComponentsBaseFactory {
    
    func bottomButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(Constants.Colors.secondaryTextColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.Sizes.BottomButton.textSize, weight: .semibold)
        button.backgroundColor = Constants.Colors.bottomButtonColor
        return button
    }
    
    func mainMenuButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(Constants.Colors.secondaryTextColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        button.backgroundColor = Constants.Colors.secondaryBackgrounColor
        return button
    }
    
    func footerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }
    
    
    
}