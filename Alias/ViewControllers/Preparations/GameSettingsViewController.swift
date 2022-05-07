//
//  GameSettingsViewController.swift
//  Alias
//
//  Created by Даниил Симахин on 01.05.2022.
//

import UIKit

class GameSettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PreparationsBaseViewController {
    
    weak var coordinator: PreparationsBaseCoordinator?
    var componentsFactory: ComponentsBaseFactory!
    var gameService: GameBaseService!

    private var tableview = UITableView()
    var gameSettings = GameSettings()
    
    private lazy var bottomButton: UIButton = {
        let button = componentsFactory.bottomButton()
        button.setTitle("Далее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return button
    }()
    private lazy var bottomButtonContainer = componentsFactory.bottomButtonContainer()
    private lazy var numberRoundsTextLabel = componentsFactory.numberOfRoundsTextLabel()
    
    init(coordinator: PreparationsBaseCoordinator?, gameService: GameBaseService,componentsFactory: ComponentsBaseFactory) {
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
        createTable()
        setupViews()
        setupNavBar()
    }
    
    func createTable() {
        self.tableview = UITableView(frame: view.bounds, style: .plain)
        self.tableview.register(GameSettingsTableViewCell.self, forCellReuseIdentifier: GameSettingsTableViewCell.identifire)
        
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .clear
        tableview.sectionHeaderHeight = 140
        tableview.allowsSelection = false
    }
    
    func setupViews() {
        view.backgroundColor = Constants.Colors.mainBackgroundColor
        
        view.addSubview(bottomButtonContainer)
        bottomButtonContainer.addSubview(bottomButton)
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            bottomButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomButtonContainer.leadingAnchor.constraint(equalTo: bottomButton.leadingAnchor),
            bottomButtonContainer.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor),
            bottomButtonContainer.topAnchor.constraint(equalTo: bottomButton.topAnchor),
            
            bottomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: Constants.Sizes.BottomButton.height),
            
            tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: 10),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    private func setupNavBar() {
        title = "Настройки"
    }
    
    @objc func didTapBottomButton() {
        //gameService.setRounds(numberRounds)
        gameService.startNewGame()
        coordinator?.goToNextRound()
    }

    //MARK: - UTTableViewDataSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameSettingsTableViewCell.identifire, for: indexPath) as! GameSettingsTableViewCell
        
        let index = indexPath.row
        let model = gameSettings.settingsCells[index]
        cell.setGameSetting(settings: model)
        switch model.type {
        case .numberRounds:
            cell.callback = {value in
                self.gameService.setRounds(Int(value))
            }
            cell.scoreLabel.text = String(2)
        case .timeRounds:
            cell.callback = {value in
                print(value)
            }
            cell.scoreLabel.text = String(30)
        case .frequencyActions:
            cell.scoreLabel.text = "Отключено"
            cell.callback = {value in
                cell.scoreLabel.text = self.gameSettings.frequencyActionsList.list[Int(round(value))]
            }
        }

        return cell
    }
}
