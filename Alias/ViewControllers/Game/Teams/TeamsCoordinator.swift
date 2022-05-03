//
//  TeamsCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import Foundation
import UIKit

protocol TeamsBaseCoordinator: Coordinator {
    func goToCategories()
}

protocol TeamsBaseCoordinated {
    var coordinator: TeamsBaseCoordinator? { get }
}

final class TeamsCoordinator: TeamsBaseCoordinator {
    weak var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController?
    
    lazy var categoriesCoordinator = CategoriesCoordinator()
    
    func start() -> UIViewController {
        TeamsViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
    }
    
    func goToCategories() {
        categoriesCoordinator.rootViewController = rootViewController
        categoriesCoordinator.parentCoordinator = parentCoordinator
        navigationRootViewController?.pushViewController(categoriesCoordinator.start(), animated: true)
    }
}
