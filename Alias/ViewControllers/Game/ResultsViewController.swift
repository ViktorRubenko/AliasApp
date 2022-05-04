//
//  ResultsViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class ResultsViewController: UIViewController, GameBaseViewController {

    var gameService: GameBaseService!
    var componentsFactory: ComponentsBaseFactory!
    weak var coordinator: GameBaseCoordinator?
    
    init(coordinator: GameBaseCoordinator, gameService: GameBaseService, componentsFactory: ComponentsBaseFactory) {
        self.coordinator = coordinator
        self.gameService = gameService
        self.componentsFactory = componentsFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
