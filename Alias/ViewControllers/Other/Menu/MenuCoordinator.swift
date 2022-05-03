//
//  MenuCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import Foundation
import UIKit

protocol MenuBaseCoordinator: Coordinator {
    func goToRules()
    func goToTeams()
}

protocol MenuBaseCoordinated {
    var coordinator: MenuBaseCoordinator? { get }
}


final class MenuCoordinator: MenuBaseCoordinator {

    var rootViewController: UIViewController?
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rulesCoordinator = RulesCoordinator()
    lazy var teamsCoordinator = TeamsCoordinator()
    
    
    func start() -> UIViewController {
        MenuViewController(coordinator: self, componentsFactory: ComponentsFactory())
    }
    
    func goToRules() {
        rulesCoordinator.parentCoordinator = parentCoordinator
        rulesCoordinator.rootViewController = rootViewController
        navigationRootViewController?.pushViewController(rulesCoordinator.start(), animated: true)
    }
    
    func goToTeams() {
        teamsCoordinator.parentCoordinator = parentCoordinator
        teamsCoordinator.rootViewController = rootViewController
        navigationRootViewController?.pushViewController(teamsCoordinator.start(), animated: true)
    }
}
