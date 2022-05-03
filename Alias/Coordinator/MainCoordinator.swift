//
//  MainCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import Foundation
import UIKit

enum AppFlow {
    case main
}

final class MainCoordinator: MainBaseCoordinator {
    var rootViewController: UIViewController? = NavigationController()
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var menuCoordinator = MenuCoordinator()
    
    func start() -> UIViewController {
        menuCoordinator.parentCoordinator = self
        menuCoordinator.rootViewController = rootViewController
        navigationRootViewController?.viewControllers = [menuCoordinator.start()]
        return rootViewController!
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .main:
            resetToRoot()
        }
    }
    
    @discardableResult
    func resetToRoot() -> Self {
        moveTo(flow: .main)
        return self
    }
}
