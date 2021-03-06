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
    func roundLabel() -> UILabel
    func roundTeamListLabel() -> UILabel
    func roundTeamScoreListLabel() -> UILabel
    func nextRoundTeamLabel() -> UILabel
    func numberOfRoundsTextLabel() -> UILabel
    func numberOfRoundsCountLabel() -> UILabel
    func bottomButtonContainer() -> UIView
    func logoImageView() -> UIImageView
    func wordResultLabel() -> UILabel
    func wordResultImageView(guessed: Bool) -> UIImageView
    func resultsTeamLabel() -> UILabel
    func resultsScoreLabel() -> UILabel
    func winnerLabel() -> UILabel
    func winnerTeamLabel() -> UILabel
    func teamsGameResultsLabel() -> UILabel
}

struct ComponentsFactory: ComponentsBaseFactory {
    
    func teamsGameResultsLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.Colors.tertiaryTextColor
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Результаты команд"
        return label
    }
    
    func winnerLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.Colors.greenColor
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ПОБЕДИТЕЛЬ"
        return label
    }
    
    func winnerTeamLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.Colors.textColor
        label.font = .systemFont(ofSize: 55, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func resultsScoreLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.Colors.tertiaryTextColor
        label.font = .systemFont(ofSize: 55, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func resultsTeamLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.Colors.textColor
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func wordResultImageView(guessed: Bool) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: guessed ? "hand.thumbsup" : "hand.thumbsdown")
        iv.tintColor = guessed ? Constants.Colors.greenColor : Constants.Colors.redColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }
    
    func wordResultLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.Colors.textColor
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func logoImageView() -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "logo")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }
    
    func bottomButtonContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = Constants.Colors.bottomButtonColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func numberOfRoundsCountLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.Colors.tertiaryTextColor
        label.font = .systemFont(ofSize: 100, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func numberOfRoundsTextLabel() -> UILabel {
        let label = UILabel()
        label.text = "Количество раундов:"
        label.textColor = Constants.Colors.textColor
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func roundLabel() -> UILabel {
        let label = UILabel()
        label.text = "Количество раундов"
        label.textColor = Constants.Colors.textColor
        label.font = .systemFont(ofSize: 50, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func roundTeamScoreListLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.Colors.textColor
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func nextRoundTeamLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.Colors.tertiaryTextColor
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func roundTeamListLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = Constants.Colors.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    
    
    func bottomButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(Constants.Colors.secondaryTextColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.backgroundColor = Constants.Colors.bottomButtonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func mainMenuButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(Constants.Colors.secondaryTextColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        button.backgroundColor = Constants.Colors.secondaryBackgrounColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func footerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
