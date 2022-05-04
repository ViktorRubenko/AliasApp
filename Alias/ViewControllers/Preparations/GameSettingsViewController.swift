//
//  GameSettingsViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class GameSettingsViewController: UIViewController, PreparationsBaseViewController {
    
    weak var coordinator: PreparationsBaseCoordinator?
    var componentsFactory: ComponentsBaseFactory!
    var gameService: GameBaseService!
    
    init(coordinator: PreparationsBaseCoordinator, gameService: GameBaseService, componentsFactory: ComponentsFactory) {
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
        let button = UIButton(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        button.setTitle("NextVC", for: .normal)
        button.setTitleColor(.red, for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    @objc func didTap() {
        gameService.startNewGame()
        coordinator?.goToNextRound()
    }
}
