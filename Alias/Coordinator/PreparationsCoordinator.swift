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
        let vc = AppContainer.shared.container.resolve(TeamsViewController.self)!
        vc.coordinator = self
        return vc
    }
    
    func goToCaterogies() {
        let vc = AppContainer.shared.container.resolve(CategoriesViewController.self)!
        vc.coordinator = self
        navigationRootViewController?.pushViewController(vc, animated: true)
    }
    
    func goToGameSettings() {
        let vc = AppContainer.shared.container.resolve(GameSettingsViewController.self)!
        vc.coordinator = self
        navigationRootViewController?.pushViewController(vc, animated: true)
    }
    
    func goToNextRound() {
        parentCoordinator?.goToGame()
    }
}
