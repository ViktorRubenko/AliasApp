//
//  NextRoundController.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import UIKit

protocol NextRoundBaseCoordinator: Coordinator {
    func goToGame()
}

protocol NextRoundBaseCoordinated {
    var coordinator: NextRoundBaseCoordinator? { get }
}

final class NextRoundCoordinator: NextRoundBaseCoordinator {
    var rootViewController: UIViewController?
    var parentCoordinator: MainBaseCoordinator?

    func start() -> UIViewController {
        NextRoundViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
    }
    
    func goToGame() {
        print("goTogame")
    }
    
}
