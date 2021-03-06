//
//  RulesViewController.swift
//  Alias
//
//  Created by Даниил Симахин on 01.05.2022.
//

import UIKit

fileprivate struct RuleModel {
    let text: String
}

class RulesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RulesBaseCoordinated {
    
    weak var coordinator: RulesBaseCoordinator?
    
    private let alphanumerics = ["①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩", "⑪", "⑫", "⑬", "⑭", "⑮", "⑯", "⑰", "⑱", "⑲", "⑳"]
    
    private let rules = [
        RuleModel(text: "Задача каждого игрока - объяснить как можно больше слов товарищам по команде за ограниченное время."),
        RuleModel(text: "Во время объяснения нельзя использовать однокоренные слова, озвучивать перевод иностранных языков"),
        RuleModel(text: "Случайно может выпадать слово-действие, за которое игрок может получить больше баллов при выполнении, но также и потерять больше баллов при пропуске слова."),
        RuleModel(text: "Отгаданное слово приносит команде один балл, а за пропущенное слово команда штрафуется на одно балл."),
        RuleModel(text: "Победителем становится команда, набравшая наибольшее количество баллов за игру."),
    ]
    
    private lazy var headerView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        view.center.x = tableView.center.x
        view.image = UIImage(named: "logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    private var tableView = UITableView()
    
    init(coordinator: RulesBaseCoordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createTable()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        
        ])
        title = "Правила"
        view.backgroundColor = Constants.Colors.mainBackgroundColor
        tableView.tableHeaderView = headerView
    }
    
    private func createTable() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(RuleTableViewCell.self, forCellReuseIdentifier: RuleTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 140
        tableView.allowsSelection = false
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RuleTableViewCell.identifier, for: indexPath) as! RuleTableViewCell
        cell.labelRule.text = rules[indexPath.row].text
        cell.indexLabel.text = alphanumerics[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
}
