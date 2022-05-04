//
//  GameSettingsViewController.swift
//  Alias
//
//  Created by Даниил Симахин on 01.05.2022.
//

import UIKit

class GameSettingsViewController: UIViewController, PreparationsBaseViewController {

    weak var coordinator: PreparationsBaseCoordinator?
    var componentsFactory: ComponentsBaseFactory!
    var gameService: GameBaseService!
    
    private var numberRounds = 4
    
    private lazy var bottomButton: UIButton = {
        let button = componentsFactory.bottomButton()
        button.setTitle("Далее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return button
    }()
    private let bottomButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.bottomButtonColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let numberRoundsTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество раундов"
        label.textColor = Constants.Colors.textColor
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var numberRoundsCountLabel: UILabel = {
        let label = UILabel()
        label.text = String(numberRounds)
        label.textColor = Constants.Colors.tertiaryTextColor
        label.font = .systemFont(ofSize: 100, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var numberRoundsStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.sizeThatFits(CGSize(width: 50, height: 50))
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = Double(numberRounds)
        stepper.addTarget(self, action: #selector(pressedChangedValue), for: .valueChanged)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    private let numberRoundsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fillProportionally
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    init(coordinator: PreparationsBaseCoordinator, gameService: GameBaseService,componentsFactory: ComponentsBaseFactory) {
        self.componentsFactory = componentsFactory
        self.coordinator = coordinator
        self.gameService = gameService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
    }
    
    @objc private func pressedChangedValue() {
        numberRounds = Int(numberRoundsStepper.value)
        numberRoundsCountLabel.text = String(numberRounds)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.mainBackgroundColor
        
        view.addSubview(bottomButtonContainer)
        view.addSubview(numberRoundsStackView)
        bottomButtonContainer.addSubview(bottomButton)
        numberRoundsStackView.addArrangedSubview(numberRoundsTextLabel)
        numberRoundsStackView.addArrangedSubview(numberRoundsCountLabel)
        numberRoundsStackView.addArrangedSubview(numberRoundsStepper)
        
        NSLayoutConstraint.activate([
            bottomButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomButtonContainer.leadingAnchor.constraint(equalTo: bottomButton.leadingAnchor),
            bottomButtonContainer.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor),
            bottomButtonContainer.topAnchor.constraint(equalTo: bottomButton.topAnchor),
            
            bottomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: Constants.Sizes.BottomButton.height),
            
            numberRoundsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            numberRoundsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            numberRoundsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            numberRoundsStackView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomButtonContainer.topAnchor, constant: -100)
        ])
    }
    
    private func setupNavBar() {
        title = "Настройки"
    }

    @objc func didTapBottomButton() {
        gameService.setRounds(numberRounds)
        coordinator?.goToNextRound()
    }
}
