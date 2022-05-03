//
//  RulesViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

fileprivate struct RuleModel {
    let text: String
}

class RulesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let rules = [
        RuleModel(text: "Задача каждого игрока - объяснить как можно больше слов товарищам по команде за ограниченное время."),
        RuleModel(text: "Во время объяснения нельзя использовать однокоренные слова, озвучивать перевод иностранных языков"),
        RuleModel(text: "Отгаданное слово приносит команде одно очко, а за пропущенное слово команда штрафуется (в зависимости от настроек)."),
        RuleModel(text: "Победителем становится команда, у которой количество очков достигло заранее установленного значения."),
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
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        self.tableView.register(RuleTableViewCell.self, forCellReuseIdentifier: RuleTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        cell.imageRule.image = UIImage(systemName: "i.circle")
        cell.backgroundColor = .clear
        return cell
    }
}
