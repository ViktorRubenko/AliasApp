//
//  AppContainer.swift
//  Alias
//
//  Created by Victor Rubenko on 07.05.2022.
//

import Foundation
import Swinject

class AppContainer {
    let container = Container()
    static let shared = AppContainer()
    
    private init() {
        container.register(GameBaseService.self) { _ in
            GameBrain.shared
        }
        container.register(ComponentsBaseFactory.self) { _ in
            ComponentsFactory()
        }
        container.register(JokeServiceProtocol.self) { _ in
            JokeBrain()
        }
        container.register(MenuViewController.self) { resolver in
            MenuViewController(coordinator: nil, componentsFactory: resolver.resolve(ComponentsBaseFactory.self)!)
        }
        container.register(GameSettingsViewController.self) { resolver in
            GameSettingsViewController(coordinator: nil, gameService: resolver.resolve(GameBaseService.self)!, componentsFactory: resolver.resolve(ComponentsBaseFactory.self)!)
        }
        container.register(GameViewController.self) { resolver in
            GameViewController(coordinator: nil, gameService: resolver.resolve(GameBaseService.self)!, componentsFactory: resolver.resolve(ComponentsBaseFactory.self)!, jokeService: resolver.resolve(JokeServiceProtocol.self)!)
        }
        container.register(WinnerViewController.self) { resolver in
            WinnerViewController(coordinator: nil, gameService: resolver.resolve(GameBaseService.self)!, componentsFactory: resolver.resolve(ComponentsBaseFactory.self)!)
        }
        container.register(ResultsViewController.self) { resolver in
            ResultsViewController(coordinator: nil, gameService: resolver.resolve(GameBaseService.self)!, componentsFactory: resolver.resolve(ComponentsBaseFactory.self)!)
        }
        container.register(NextRoundViewController.self) { resolver in
            NextRoundViewController(coordinator: nil, gameService: resolver.resolve(GameBaseService.self)!, componentsFactory: resolver.resolve(ComponentsBaseFactory.self)!)
        }
        container.register(TeamsViewController.self) { resolver in
            TeamsViewController(coordinator: nil, gameService: resolver.resolve(GameBaseService.self)!, componentsFactory: resolver.resolve(ComponentsBaseFactory.self)!)
        }
        container.register(CategoriesViewController.self) { resolver in
            CategoriesViewController(coordinator: nil, gameService: resolver.resolve(GameBaseService.self)!, componentsFactory: resolver.resolve(ComponentsBaseFactory.self)!)
        }
        container.register(RulesViewController.self) { resolver in
            RulesViewController(coordinator: nil)
        }
    }
}
