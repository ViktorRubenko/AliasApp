//
//  GameService.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import Foundation

struct TeamModel {
    let name: String
    var score: Int
}

struct CategoryModel {
    let name: String
    let words: [String]
}

protocol GameServiceProtocol {
    var currentRound: Int { get }
    var roundPoints: Int { get }
    var skippedWords: Int { get }
    var totalRounds: Int { get }
    var roundResults: [String: Bool] { get }
    var teams: [TeamModel] { get }
    var currentTeam: TeamModel { get }
    var categories: [CategoryModel] { get }
    var totalSeconds: Int { get }
    
    func addTeam(name: String)
    func deleteTeam(at: Int)
    func setRounds(_ rounds: Int)
    func setSeconds(_ seconds: Int)
    func selectCategory(_ index: Int)
    
    func startNewGame()
    func startRound()
    func guessedWord()
    func skipWord()
    func resetRound()
}

protocol GameServiceDelegate {
    func handleAction(gameService: GameServiceProtocol, action: String)
    func handleWord(gameService: GameServiceProtocol, action: String)
    func timeDidChange(gameService: GameServiceProtocol, secondsLeft: String)
    func roundDidEnded(gameService: GameServiceProtocol, roundPoints: Int, roundResults: [String: Bool])
}
