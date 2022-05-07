//
//  WinnerViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class WinnerViewController: InitialGameViewController {
    
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
    private lazy var teamsGameResultsLabel = componentsFactory.teamsGameResultsLabel()
    private lazy var winnerLabel = componentsFactory.winnerLabel()
    private lazy var winnerTeamLabel = componentsFactory.winnerTeamLabel()
    private lazy var bottomButton: UIButton = {
        let button = componentsFactory.bottomButton()
        button.setTitle("Закончить игру", for: .normal)
        button.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return button
    }()
    private lazy var bottomButtonContainer = componentsFactory.bottomButtonContainer()
    private let teamsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var teamsStackViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        updateUI()
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
        contentView.addSubview(winnerLabel)
        contentView.addSubview(winnerTeamLabel)
        contentView.addSubview(teamsGameResultsLabel)
        contentView.addSubview(teamsStackView)
        
        gameService.teams.sorted(by: { $0.score > $1.score }).forEach {
            let innerStackView = UIStackView()
            innerStackView.axis = .horizontal
            innerStackView.distribution = .fillProportionally
            let teamLabel = componentsFactory.roundTeamListLabel()
            let teamScoreLabel = componentsFactory.roundTeamScoreListLabel()
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
            
            winnerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            winnerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            winnerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            winnerTeamLabel.topAnchor.constraint(equalTo: winnerLabel.bottomAnchor, constant: 10),
            winnerTeamLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            winnerTeamLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            teamsGameResultsLabel.topAnchor.constraint(equalTo: winnerTeamLabel.bottomAnchor, constant: 20),
            teamsGameResultsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            teamsGameResultsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            teamsStackView.topAnchor.constraint(equalTo: teamsGameResultsLabel.bottomAnchor, constant: 5),
            teamsStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            teamsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        teamsStackViewHeightConstraint = teamsStackView.heightAnchor.constraint(
            greaterThanOrEqualToConstant: CGFloat(teamsStackView.subviews.count * 44))
    }
    
    private func updateUI() {
        let maxPoints = gameService.teams.compactMap({ $0.score }).max()!
        let winnerTeams = gameService.teams.filter({ $0.score == maxPoints })
        if winnerTeams.count == 1 {
            winnerTeamLabel.text = gameService.teams.sorted(by: { $0.score > $1.score }).first?.name
        } else {
            winnerTeamLabel.text = winnerTeams.compactMap({ $0.name }).joined(separator: ", ")
            winnerLabel.text = "НИЧЬЯ"
        }
    }
    
    override func setupNavBar() {
        title = "Результаты игры"
        navigationItem.hidesBackButton = true
    }
    
    @objc private func didTapBottomButton() {
        coordinator?.resetToRoot()
    }

}
