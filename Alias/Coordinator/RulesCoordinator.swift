//
//  RulesCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import UIKit

protocol RulesBaseCoordinator: Coordinator {
    
}

protocol RulesBaseCoordinated {
    var coordinator: RulesBaseCoordinator? { get }
}

class RulesCoordinator: RulesBaseCoordinator {
    var rootViewController: UIViewController?
    
    func start() -> UIViewController {
        let vc = AppContainer.shared.container.resolve(RulesViewController.self)!
        vc.coordinator = self
        return vc
    }
    
    var parentCoordinator: MainBaseCoordinator?
    
    
}

