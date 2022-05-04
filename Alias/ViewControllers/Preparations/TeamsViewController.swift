//
//  TeamsViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class TeamsViewController: UIViewController, PreparationsBaseViewController {
    
    weak var coordinator: PreparationsBaseCoordinator?
    var componentsFactory: ComponentsBaseFactory!
    var gameService: GameBaseService!
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 44.0
        tableView.allowsSelection = false
        return tableView
    }()
    
    private lazy var bottomButton: UIButton = {
        let button = componentsFactory.bottomButton()
        button.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return button
    }()
    
    init(coordinator: PreparationsBaseCoordinator, gameService: GameBaseService, componentsFactory: ComponentsBaseFactory) {
        self.coordinator = coordinator
        self.componentsFactory = componentsFactory
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

    private func setupViews() {
        view.backgroundColor = Constants.Colors.bottomButtonColor
        tableView.backgroundColor = Constants.Colors.mainBackgroundColor
        
        view.addSubview(tableView)
        view.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomButton.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: Constants.Sizes.BottomButton.height)
        ])
    }
    
    private func setupNavBar() {
        title = "Команды"
        
        let addBarItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(didTapAddBarItem))
        navigationItem.rightBarButtonItem = addBarItem
    }
    
    @objc private func didTapAddBarItem() {
        let alert = UIAlertController(title: "Добавить команду", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Название команды..."
        }
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                return
            }
            self.gameService.addTeam(name: text)
            self.tableView.performBatchUpdates {
                self.tableView.insertRows(
                    at: [IndexPath(row: self.gameService.teams.count - 1, section: 0)],
                    with: .fade)
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapBottomButton() {
        coordinator?.goToCaterogies()
    }
}

extension TeamsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameService.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = UIListContentConfiguration.cell()
        config.text = gameService.teams[indexPath.row].name
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        gameService.teams.count > 2
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gameService.deleteTeam(at: indexPath.row)
            tableView.performBatchUpdates {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UITableViewHeaderFooterView()
        
        let footerLabel = componentsFactory.footerLabel()
        footerLabel.text = """
        Минимальное количество команд: 2
        Чтобы добавить команду - нажмите кнопку "Добавить"
        Чтобы удалить команду - свапните её влево
        """
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.contentView.addSubview(footerLabel)
        NSLayoutConstraint.activate([
            footerLabel.topAnchor.constraint(equalTo: footerView.contentView.topAnchor, constant: 10),
            footerLabel.bottomAnchor.constraint(equalTo: footerView.contentView.bottomAnchor, constant: -10),
            footerLabel.leadingAnchor.constraint(equalTo: footerView.contentView.leadingAnchor, constant: 10),
            footerLabel.trailingAnchor.constraint(equalTo: footerView.contentView.trailingAnchor, constant: -10),
        ])
        
        return footerView
    }
}
