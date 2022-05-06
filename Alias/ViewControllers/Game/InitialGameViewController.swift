//
//  InitialGameViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 05.05.2022.
//

import UIKit

class InitialGameViewController: UIViewController, GameBaseViewController {
    var gameService: GameBaseService!
    var componentsFactory: ComponentsBaseFactory!
    weak var coordinator: GameBaseCoordinator?
    let button = UIBarButtonItem()
    
    init(coordinator: GameBaseCoordinator?, gameService: GameBaseService, componentsFactory: ComponentsBaseFactory) {
        self.coordinator = coordinator
        self.componentsFactory = componentsFactory
        self.gameService = gameService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNavBar() {
        let backButtonItem = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(didTapBackButtonItem))
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    @objc func didTapBackButtonItem() {
        let alert = UIAlertController(title: "Выход из игры", message: "Игра будет сброшена.\nВы уверены?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in
            self.coordinator?.resetToRoot()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
