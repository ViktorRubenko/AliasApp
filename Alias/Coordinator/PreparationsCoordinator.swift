//
//  PreparationsCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import UIKit

protocol PreparationsBaseCoordinator: Coordinator {
    func goToGameSettings()
    func goToCaterogies()
    func goToNextRound()
}

protocol PreparationsBaseCoordinated {
    var coordinator: PreparationsBaseCoordinator? { get }
}

class PreparationsCoordinator: PreparationsBaseCoordinator {
    var rootViewController: UIViewController?
    var parentCoordinator: MainBaseCoordinator?
    
    
    func start() -> UIViewController {
        TeamsViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
    }
    
    func goToCaterogies() {
        let vc = CategoriesViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
        navigationRootViewController?.pushViewController(vc, animated: true)
    }
    
    func goToGameSettings() {
        let vc = GameSettingsViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
        navigationRootViewController?.pushViewController(vc, animated: true)
    }
    
    func goToNextRound() {
        parentCoordinator?.goToGame()
    }
}
