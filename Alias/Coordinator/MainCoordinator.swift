//
//  MainCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import UIKit

protocol MainBaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get }
    func goToPreparations()
    func goToRules()
    func goToGame()
}

protocol MainBaseCoordinated {
    var coordinator: MainBaseCoordinator? { get }
}

final class MainCoordinator: MainBaseCoordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController? = NavigationController()
    var parentCoordinator: MainBaseCoordinator?
    
    func start() -> UIViewController {
        let vc = MenuViewController(coordinator: self, componentsFactory: ComponentsFactory())
        navigationRootViewController?.viewControllers = [vc]
        return rootViewController!
    }
    
    func goToPreparations() {
        let coordinator = PreparationsCoordinator()
        createChild(coordinator: coordinator)
        navigationRootViewController?.pushViewController(coordinator.start(), animated: true)
    }
    
    func goToRules() {
        let coordinator = RulesCoordinator()
        createChild(coordinator: coordinator)
        navigationRootViewController?.pushViewController(coordinator.start(), animated: true)
    }
    
    func goToGame() {
        let coordinator = GameCoordinator()
        createChild(coordinator: coordinator)
        navigationRootViewController?.pushViewController(coordinator.start(), animated: true)
        for i in (1..<navigationRootViewController!.viewControllers.count - 1).reversed() {
            navigationRootViewController?.viewControllers[i].removeFromParent()
        }
        for i in (0..<childCoordinators.count - 1).reversed() {
            childCoordinators.remove(at: i)
        }
        print(childCoordinators)
    }
    
    @discardableResult
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: true)
        return self
    }
}

extension MainCoordinator {
    private func createChild(coordinator: Coordinator) {
        coordinator.parentCoordinator = self
        coordinator.rootViewController = rootViewController
        childCoordinators.append(coordinator)
    }
}
