//
//  CategoriesViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit
import SwiftUI

struct IconCategories {
    let icons = [
        "Еда" : UIImage(named: "food"),
        "Вещи" : UIImage(named: "things"),
        "Животные" : UIImage(named: "animals"),
        "Человек" : UIImage(named: "human"),
        "Места" : UIImage(named: "places"),
        "Субстанции" : UIImage(named: "substances"),
    ]
}

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PreparationsBaseViewController {
    
    weak var coordinator: PreparationsBaseCoordinator?
    var componentsFactory: ComponentsBaseFactory!
    var gameService: GameBaseService!
    
    var tableView = UITableView()
    let iconsCategories = IconCategories()
    
    init(coordinator: PreparationsCoordinator, gameService: GameBaseService, componentsFactory: ComponentsFactory) {
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
        
        setupNavBar()
        createTable()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = Constants.Colors.mainBackgroundColor
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
    }
    
    func createTable() {
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifire)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 140
    }
    
    func setupNavBar(){
        title = "Категории"
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoriesDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifire, for: indexPath) as! CategoryTableViewCell
        
        let key = gameService.categories[indexPath.row].name
        cell.title.text = key
        
        var subTitle = ""
        for index in 0...3 {
            subTitle += "\(gameService.categories[indexPath.row].words[index]), "
        }
        cell.subTitle.text = String(subTitle.dropLast(2))
        
        cell.image.image = iconsCategories.icons[key]!
        
        return cell
    }
    
    //MARK: - UITablewViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gameService.selectCategory(indexPath.row)
        coordinator?.goToGameSettings()
    }
}
