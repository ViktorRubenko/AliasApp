//
//  GameSettingsCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import Foundation
import UIKit

protocol GameSettingsBaseCoordinator: Coordinator {
    func goToNextRound()
}

protocol GameSettingsBaseCoordinated {
    var coordinator: GameSettingsBaseCoordinator? { get }
}

final class GameSettingsCoordinator: GameSettingsBaseCoordinator {
    var rootViewController: UIViewController?
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var nextRoundCoordinator = NextRoundCoordinator()
    
    func start() -> UIViewController {
        GameSettingsViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
    }
    
    func goToNextRound() {
        nextRoundCoordinator.parentCoordinator = parentCoordinator
        nextRoundCoordinator.rootViewController = rootViewController
        navigationRootViewController?.pushViewController(nextRoundCoordinator.start(), animated: true)
    }
}
