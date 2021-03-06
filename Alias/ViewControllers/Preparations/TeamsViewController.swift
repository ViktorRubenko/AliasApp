//
//  TeamsViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit
import SwipeCellKit

class TeamsViewController: UIViewController, PreparationsBaseViewController {
    
    weak var coordinator: PreparationsBaseCoordinator?
    var componentsFactory: ComponentsBaseFactory!
    var gameService: GameBaseService!
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 44.0
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    
    private lazy var bottomButton: UIButton = {
        let button = componentsFactory.bottomButton()
        button.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return button
    }()
    
    init(coordinator: PreparationsBaseCoordinator?, gameService: GameBaseService, componentsFactory: ComponentsBaseFactory) {
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
        title = "??????????????"
        
        let addBarItem = UIBarButtonItem(title: "????????????????", style: .plain, target: self, action: #selector(didTapAddBarItem))
        navigationItem.rightBarButtonItem = addBarItem
    }
    
    @objc private func didTapAddBarItem() {
        let alert = UIAlertController(title: "???????????????? ??????????????", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "???????????????? ??????????????..."
        }
        alert.addAction(UIAlertAction(title: "????????????????", style: .default, handler: { _ in
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
        alert.addAction(UIAlertAction(title: "????????????", style: .destructive, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapBottomButton() {
        coordinator?.goToCaterogies()
    }
    
    private func showEditAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "??????????????????????????", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = self.gameService.teams[indexPath.row].name
        }
        alert.addAction(UIAlertAction(title: "????", style: .default, handler: { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self.gameService.renameTeam(index: indexPath.row, name: text)
            self.tableView.performBatchUpdates {
                self.tableView.reloadRows(at: [indexPath], with: .middle)
            }
        }))
        alert.addAction(UIAlertAction(title: "????????????", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

extension TeamsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameService.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        cell.backgroundColor = .white.withAlphaComponent(0.4)
        var config = UIListContentConfiguration.cell()
        config.text = gameService.teams[indexPath.row].name
        config.textProperties.color = Constants.Colors.textColor!
        cell.contentConfiguration = config
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UITableViewHeaderFooterView()
        
        let footerLabel = componentsFactory.footerLabel()
        footerLabel.text = """
        ?????????????????????? ???????????????????? ????????????: 2
        ???????????????? - ?????????????? ???????????? "????????????????"
        ?????????????????????????? - ???????????????? ???? ?????????? ?????? ??????????????
        ?????????? ?????????????? - ???????????????? ???? ??????????
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showEditAlert(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TeamsViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "??????????????") { action, indexPath in
            self.gameService.deleteTeam(at: indexPath.row)
            self.tableView.performBatchUpdates {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }

        }
        
        let editAction = SwipeAction(style: .default, title: "??????????????????????????") { action, indexPath in
            self.showEditAlert(indexPath: indexPath)
        }
        
        return gameService.teams.count > 2 ? [editAction, deleteAction] : [editAction]
    }
}
