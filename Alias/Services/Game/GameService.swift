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

enum Frequency: Int {
    case none = 0
    case low
    case medium
    case hight
}

protocol GameBaseService: AnyObject {
    var delegate: GameServiceDelegate? {get set}
    
    var frequancyValue: Frequency { get }
    var currentRound: Int { get }
    var points: Int { get }
    var skippedWords: Int { get }
    var totalRounds: Int { get }
    var roundResults: [(word: String, guessed: Bool)] { get }
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
    func setActionFrequency(_ frequency: Frequency)
    
    func startNewGame()
    func guessedWord()
    func skipWord()
    func startCurrentTeamRound()
    func resetTeamRound()
    func endTeamRound()
    
    
}

protocol GameServiceDelegate: AnyObject {
    func handleWord(gameService: GameBaseService, word: String, action: String?)
    func timerDidUpdate(gameService: GameBaseService, seconds: Int)
    func teamRoundDidEnd(gameService: GameBaseService)
}
