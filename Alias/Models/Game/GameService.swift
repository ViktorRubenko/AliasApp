//
//  GameService.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import Foundation

protocol GameServiceProtocol {
    var points: Int { get }
    var currentRound: Int { get }
    var maxRounds: Int { get }
    var results: [String: Bool] { get }
    func nextWord() -> String
    func randomAction() -> String
    func guessed()
    func skip()
    func reset()
}

protocol GameServiceDelegate {
    func handleAction(gameService: GameServiceProtocol, action: String)
    func gameDidEnded(gameService: GameServiceProtocol, points: Int)
}
