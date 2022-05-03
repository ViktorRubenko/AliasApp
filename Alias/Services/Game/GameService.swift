//
//  GameService.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import Foundation

struct TeamModel: Equatable {
    let name: String
    var score: Int
}

struct CategoryModel {
    let name: String
    let words: [String]
}

protocol GameServiceProtocol: AnyObject {
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
    func endGame()
}

protocol GameServiceDelegate: AnyObject {
    func handleWord(gameService: GameServiceProtocol, word: String, action: String?)
    func timerDidUpdate(gameService: GameServiceProtocol, seconds: Int)
    func roundDidEnd(gameService: GameServiceProtocol,teamName: String, roundPoints: Int, roundResults: [String: Bool])
}
