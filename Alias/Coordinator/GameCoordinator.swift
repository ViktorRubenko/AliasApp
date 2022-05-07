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
    var coordinator: GameBaseCoordinator? { get set }
}

fileprivate enum GameFlow {
    case game, results, winner, nextRound
}

class GameCoordinator: GameBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController?
    
    func start() -> UIViewController {
        let vc = AppContainer.shared.container.resolve(NextRoundViewController.self)!
        vc.coordinator = self
        return vc
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
        var vc: GameBaseCoordinated
        switch to {
        case .nextRound:
            vc = AppContainer.shared.container.resolve(NextRoundViewController.self)!
        case .game:
            vc = AppContainer.shared.container.resolve(GameViewController.self)!
        case .results:
            vc = AppContainer.shared.container.resolve(ResultsViewController.self)!
        case .winner:
            vc = AppContainer.shared.container.resolve(WinnerViewController.self)!
        }
        vc.coordinator = self
        guard let navRootVC = navigationRootViewController else { return }
        navRootVC.pushViewController(vc as! UIViewController, animated: true)
        navRootVC.viewControllers[navRootVC.viewControllers.count - 2].removeFromParent()
    }
}
