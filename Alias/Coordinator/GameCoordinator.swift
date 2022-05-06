//
//  GameCoordinator.swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import UIKit

protocol GameBaseCoordinator: Coordinator {
    func goToGame()
    func goToResults()
    func goToWinner()
    func goToNextRound()
}

protocol GameBaseCoordinated {
    var coordinator: GameBaseCoordinator? { get }
}

fileprivate enum GameFlow {
    case game, results, winner, nextRound
}

class GameCoordinator: GameBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController?
    
    func start() -> UIViewController {
        NextRoundViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
    }
    
    func goToGame() {
        goTo(to: .game)
    }
    
    func goToResults() {
        goTo(to: .results)
    }
    
    func goToWinner() {
        goTo(to: .winner)
    }
    
    func goToNextRound() {
        goTo(to: .nextRound)
    }
}

extension GameCoordinator {
    private func goTo(to: GameFlow) {
        let vc: UIViewController
        switch to {
        case .nextRound:
            vc = NextRoundViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
        case .game:
            vc = GameViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory(), jokeService: JokeBrain())
        case .results:
            vc = ResultsViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
        case .winner:
            vc = WinnerViewController(coordinator: self, gameService: GameBrain.shared, componentsFactory: ComponentsFactory())
        }
        guard let navRootVC = navigationRootViewController else { return }
        navRootVC.pushViewController(vc, animated: true)
        navRootVC.viewControllers[navRootVC.viewControllers.count - 2].removeFromParent()
    }
}
