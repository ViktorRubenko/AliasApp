//
//  GameBrain_v2.swift
//  Alias
//
//  Created by Андрей Бородкин on 03.05.2022.
//

import Foundation

class GameBrain: GameServiceProtocol {
    
    static let shared = GameBrain()
    
    weak var delegate: GameServiceDelegate?
    
    private(set) var currentRound: Int = 1
    private(set) var roundPoints: Int = 0
    private(set) var skippedWords: Int = 0
    private(set) var totalRounds: Int = 4
    private(set) var roundResults: [String : Bool] = [:]
    private(set) var teams: [TeamModel] = [
        TeamModel(name: "Травоядные", score: 0),
        TeamModel(name: "Хищники", score: 0)
    ]
    private(set) var currentTeam: TeamModel? = nil
    let categories: [CategoryModel] = CategoriesDict.compactMap {
        CategoryModel(name: $0, words: $1)
    }
    private(set) var totalTimerSeconds: Int = 60
    
    private var withAction: Bool = false
    private var currentWord: String = ""
    private let actions: [String] = GameActions
    private var secondsRemaining: Int = 0
    private var currentCategory: CategoryModel? = nil
    private var usedWords: [[String]] = []
    private var shuffledWords: [String] = []
    weak private var timer: Timer?
    
    private init() {}
    
    func addTeam(name: String) {
        teams.append(TeamModel(name: name, score: 0))
    }
    
    func deleteTeam(at: Int) {
        if teams.count > 2 {
            teams.remove(at: at)
        }
    }
    
    func setRounds(_ rounds: Int) {
        totalRounds = rounds
    }
    
    func setSeconds(_ seconds: Int) {
        totalTimerSeconds = seconds
    }
    
    func selectCategory(_ index: Int) {
        currentCategory = categories[index]
    }
    
    func startNewGame() {
        currentTeam = teams.first
        guard let currentCategory = currentCategory else {
            return
        }
        
        shuffledWords = currentCategory.words.shuffled()
    }
    
    func startRound() {
        roundResults = [:]
        roundPoints = 0
        skippedWords = 0
        secondsRemaining = totalTimerSeconds
        
        if usedWords.count > 4 {
            shuffledWords += usedWords.removeFirst()
            shuffledWords.shuffle()
        }
        
        usedWords.append([])
        
        currentWord = shuffledWords.removeFirst()
        delegate?.handleWord(gameService: self, word: currentWord, action: nil)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer) in
            guard let self = self else {timer.invalidate(); return}
            self.secondsRemaining -= 1
            self.delegate?.timerDidUpdate(gameService: self, seconds: self.secondsRemaining)
            if self.secondsRemaining == 0 {
                self.endRound()
                timer.invalidate()
            }
        }
    }
    
    func guessedWord() {
        roundPoints += withAction ? 3 : 1
        roundResults[currentWord] = true
        nextWord()
    }
    
    func skipWord() {
        roundPoints -= 1
        roundResults[currentWord] = false
        nextWord()
    }
    
    func resetRound() {
        roundResults = [:]
        timer?.invalidate()
    }
    
    func endGame() {
        teams.removeAll()
        roundResults.removeAll()
        usedWords.removeAll()
        timer?.invalidate()
    }
    
    func nextWord() {
        usedWords[usedWords.count - 1].append(currentWord)
        currentWord = shuffledWords.removeFirst()
        withAction = [true, false, false, false].randomElement()!
        delegate?.handleWord(gameService: self, word: currentWord, action: withAction ? actions.randomElement()! : nil)
        checkSuffledWords()
    }
    
    private func checkSuffledWords() {
        if shuffledWords.count < 1 {
            shuffledWords += usedWords.removeFirst()
            shuffledWords.shuffle()
        }
    }
    
    func endRound() {
        delegate?.roundDidEnd(
            gameService: self,
            teamName: currentTeam!.name,
            roundPoints: roundPoints,
            roundResults: roundResults)
        usedWords[usedWords.count - 1].append(currentWord)
        var teamIndex = teams.firstIndex(where: {$0 == currentTeam})!
        teams[teamIndex].score += roundPoints
        teamIndex = (teamIndex < teams.count-1) ? teamIndex + 1 : 0
        currentTeam = teams[teamIndex]
    }
}
