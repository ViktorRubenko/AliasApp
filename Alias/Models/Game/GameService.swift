//
//  GameService.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import Foundation

struct TeamModel {
    let name: String
}

struct CategoryModel {
    let name: String
    let words: [String]
}

protocol GameServiceProtocol {
    var currentRound: Int { get }
    var roundPoints: Int { get }
    var totalRounds: Int { get }
    var roundResults: [String: Bool] { get }
    var teams: [TeamModel] { get }
    var currentTeam: TeamModel { get }
    var categories: [Category] { get }
    var maxTimerSeconds: Int { get }
    
    func addTeam(name: String)
    func deleteTeam(at: Int)
    func setRounds(_ rounds: Int)
    func selectCategory(_ category: CategoryModel)
    
    func start()
    func guessed()
    func skip()
    func reset()
}

protocol GameServiceDelegate {
    func handleAction(gameService: GameServiceProtocol, action: String)
    func handleWord(gameService: GameServiceProtocol, action: String)
    func gameDidEnded(gameService: GameServiceProtocol, roundPoints: Int, roundResults: [String: Bool])
    func timerDidUpdated(gameService: GameServiceProtocol, seconds: Int)
}
