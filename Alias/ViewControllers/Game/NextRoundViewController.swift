//
//  NextRoundViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class NextRoundViewController: InitialGameViewController {

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
    private lazy var roundLabel = componentsFactory.roundLabel()
    private lazy var nextRoundTeamLabel = componentsFactory.nextRoundTeamLabel()
    private lazy var bottomButton: UIButton = {
        let button = componentsFactory.bottomButton()
        button.setTitle("Старт!", for: .normal)
        button.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return button
    }()
    private lazy var bottomButtonContainer = componentsFactory.bottomButtonContainer()
    private let teamsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var teamsStackViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        
        roundLabel.text = "Раунд \(gameService.currentRound) / \(gameService.totalRounds)"
        nextRoundTeamLabel.text = gameService.currentTeam?.name
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        teamsStackViewHeightConstraint.constant = CGFloat(teamsStackView.subviews.count * 44)
        
        contentView.layoutIfNeeded()
        scrollView.contentSize = contentView.bounds.size
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.mainBackgroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(roundLabel)
        contentView.addSubview(nextRoundTeamLabel)
        contentView.addSubview(teamsStackView)
        
        gameService.teams.forEach {
            let innerStackView = UIStackView()
            innerStackView.axis = .horizontal
            innerStackView.distribution = .equalCentering
            let teamLabel = componentsFactory.roundTeamListLabel()
            let teamScoreLabel = componentsFactory.roundTeamScoreListLabel()
            teamScoreLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            teamLabel.text = "\($0.name):"
            teamScoreLabel.text = "\($0.score)"
            innerStackView.addArrangedSubview(teamLabel)
            innerStackView.addArrangedSubview(teamScoreLabel)
            self.teamsStackView.addArrangedSubview(innerStackView)
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
            contentView.bottomAnchor.constraint(equalTo: teamsStackView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            roundLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            roundLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            roundLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nextRoundTeamLabel.topAnchor.constraint(equalTo: roundLabel.bottomAnchor, constant: 10),
            nextRoundTeamLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            nextRoundTeamLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            teamsStackView.topAnchor.constraint(equalTo: nextRoundTeamLabel.bottomAnchor, constant: 20),
            teamsStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            teamsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        teamsStackViewHeightConstraint = teamsStackView.heightAnchor.constraint(
            equalToConstant: CGFloat(teamsStackView.subviews.count * 44))
    }
    
    override func setupNavBar() {
        title = "Раунд"
        super.setupNavBar()
    }
    
    @objc private func didTapBottomButton() {
        coordinator?.goToGame()
    }
}
