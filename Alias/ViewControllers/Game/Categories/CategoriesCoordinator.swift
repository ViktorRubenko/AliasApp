//
//  CategoriesCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import Foundation
import UIKit

protocol CategoriesBaseCoordinator: Coordinator {
    func goToGameSettings()
}

protocol CategoriesBaseCoordinated {
    var coordinator: CategoriesBaseCoordinator? { get }
}

final class CategoriesCoordinator: CategoriesBaseCoordinator {
    var rootViewController: UIViewController?
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var gameSettingsCoordinator = GameSettingsCoordinator()
    
    func start() -> UIViewController {
        CategoriesViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
    }
    
    func goToGameSettings() {
        gameSettingsCoordinator.parentCoordinator = parentCoordinator
        gameSettingsCoordinator.rootViewController = rootViewController
        let vc = gameSettingsCoordinator.start()
        navigationRootViewController?.pushViewController(vc, animated: true)
    }
}
