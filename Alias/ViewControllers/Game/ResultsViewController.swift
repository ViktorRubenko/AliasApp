//
//  ResultsViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class ResultsViewController: InitialGameViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var teamLabel = componentsFactory.resultsTeamLabel()
    private lazy var scoreLabel = componentsFactory.resultsScoreLabel()
    private lazy var bottomButton: UIButton = {
        let button = componentsFactory.bottomButton()
        button.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return button
    }()
    private lazy var bottomButtonContainer = componentsFactory.bottomButtonContainer()
    private let resultsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var resultsStackViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        teamLabel.text = gameService.currentTeam?.name
        scoreLabel.text = "+\(gameService.points)"
        bottomButton.setTitle(gameService.gameDidEnd ? "Результаты игры" : "Далее", for: .normal)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        resultsStackViewHeightConstraint.constant = CGFloat(resultsStackView.subviews.count * 44)
        
        contentView.layoutIfNeeded()
        scrollView.contentSize = contentView.bounds.size
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.mainBackgroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(teamLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(resultsStackView)
        
        gameService.roundResults.forEach {
            let innerStackView = UIStackView()
            innerStackView.axis = .horizontal
            innerStackView.distribution = .equalCentering
            let wordLabel = componentsFactory.wordResultLabel()
            let wordResultImageView = componentsFactory.wordResultImageView(guessed: $1)
            wordLabel.text = $0
            innerStackView.addArrangedSubview(wordLabel)
            innerStackView.addArrangedSubview(wordResultImageView)
            resultsStackView.addArrangedSubview(innerStackView)
        }
        
        view.addSubview(bottomButtonContainer)
        bottomButtonContainer.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            bottomButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomButtonContainer.leadingAnchor.constraint(equalTo: bottomButton.leadingAnchor),
            bottomButtonContainer.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor),
            bottomButtonContainer.topAnchor.constraint(equalTo: bottomButton.topAnchor),
            
            bottomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: Constants.Sizes.BottomButton.height),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomButtonContainer.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: resultsStackView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            teamLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            teamLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            teamLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 10),
            scoreLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            scoreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            resultsStackView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 40),
            resultsStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            resultsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        resultsStackViewHeightConstraint = resultsStackView.heightAnchor.constraint(
            equalToConstant: CGFloat(resultsStackView.subviews.count * 44))
        
    }
    
    override func setupNavBar() {
        title = "Результаты раунда"
        super.setupNavBar()
    }
    
    @objc private func didTapBottomButton() {
        gameService.endTeamRound()
        if gameService.gameDidEnd {
            coordinator?.goToWinner()
        } else {
            coordinator?.goToNextRound()
        }
    }

}
