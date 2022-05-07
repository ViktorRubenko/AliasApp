//
//  MainCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import UIKit

protocol MainBaseCoordinator: Coordinator {
    func goToPreparations()
    func goToRules()
    func goToGame()
}

protocol MainBaseCoordinated {
    var coordinator: MainBaseCoordinator? { get }
}

final class MainCoordinator: MainBaseCoordinator {
    
    var rootViewController: UIViewController? = NavigationController()
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var preparationsCoordinator = PreparationsCoordinator()
    lazy var rulesCoordinator = RulesCoordinator()
    lazy var gameCoordinator = GameCoordinator()
    
    func start() -> UIViewController {
        let vc = AppContainer.shared.container.resolve(MenuViewController.self)!
        vc.coordinator = self
        navigationRootViewController?.viewControllers = [vc]
        return rootViewController!
    }
    
    func goToPreparations() {
        preparationsCoordinator.parentCoordinator = self
        preparationsCoordinator.rootViewController = rootViewController
        navigationRootViewController?.pushViewController(preparationsCoordinator.start(), animated: true)
    }
    
    func goToRules() {
        rulesCoordinator.parentCoordinator = self
        rulesCoordinator.rootViewController = rootViewController
        navigationRootViewController?.pushViewController(rulesCoordinator.start(), animated: true)
    }
    
    func goToGame() {
        gameCoordinator.parentCoordinator = self
        gameCoordinator.rootViewController = rootViewController
        navigationRootViewController?.pushViewController(gameCoordinator.start(), animated: true)
        for i in (1..<navigationRootViewController!.viewControllers.count - 1).reversed() {
            navigationRootViewController?.viewControllers[i].removeFromParent()
        }
    }
    
    @discardableResult
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: true)
        return self
    }
}
