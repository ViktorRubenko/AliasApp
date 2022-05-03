//
//  RulesCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import Foundation
import UIKit

protocol RulesBaseCoordinator: Coordinator {}

protocol RulesBaseCoordinated {
    var coordinator: RulesBaseCoordinator? { get }
}

final class RulesCoordinator: RulesBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController?
    
    func start() -> UIViewController {
        RulesViewController()
    }
}
