//
//  GameService.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import Foundation

struct TeamModel: Equatable {
    var name: String
    var score: Int
}

struct CategoryModel {
    let name: String
    let words: [String]
}

protocol GameBaseService: AnyObject {
    var delegate: GameServiceDelegate? {get set}
    
    var currentRound: Int { get }
    var roundPoints: Int { get }
    var skippedWords: Int { get }
    var totalRounds: Int { get }
    var roundResults: [String: Bool] { get }
    var teams: [TeamModel] { get }
    var currentTeam: TeamModel? { get }
    var categories: [CategoryModel] { get }
    var totalTimerSeconds: Int { get }
    var gameDidEnd: Bool { get }
    
    func addTeam(name: String)
    func deleteTeam(at: Int)
    func renameTeam(index: Int, name: String)
    func setRounds(_ rounds: Int)
    func setSeconds(_ seconds: Int)
    func selectCategory(_ index: Int)
    
    func startNewGame()
    func startRound()
    func guessedWord()
    func skipWord()
    func resetRound()
    func endGame()
}

protocol GameServiceDelegate: AnyObject {
    func handleWord(gameService: GameBaseService, word: String, action: String?)
    func timerDidUpdate(gameService: GameBaseService, seconds: Int)
    func roundDidEnd(gameService: GameBaseService)
}
