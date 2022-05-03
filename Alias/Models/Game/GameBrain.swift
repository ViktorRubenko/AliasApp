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
    
    private init(){
        
    }
    
    private(set) var currentRound: Int = 0
    
    private(set) var roundPoints: Int = 0
    
    private(set) var skippedWords: Int = 0
    
    private(set) var totalRounds: Int = 0
    
    private(set) var roundResults: [String : Bool] = [:]
    
    private(set) var teams: [TeamModel] = []
    
    private(set) var currentTeam: TeamModel? = nil
    
    private(set) var categories: [CategoryModel] = []
    
    private(set) var totalTimerSeconds: Int = 60
    
    private var withAction: Bool = false
    
    private var currentWord: String = ""
    
    private let actions: [String] = ["Jump", "Run", "Sit", "Fly"]
    
//    private var timer: Timer!
    private var secondsRemaining: Int = 0
    
    private var currentCategory: CategoryModel? = nil
    private var usedWords: [[String]] = []
    private var shuffledWords: [String] = []
    
    func addTeam(name: String) {
        teams.append(TeamModel(name: name, score: 0))
    }
    
    func deleteTeam(at: Int) {
        teams.remove(at: at)
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
        if usedWords.count > 4 {
            shuffledWords += usedWords.removeFirst()
            shuffledWords.shuffle()
        }
        usedWords.append([])
        currentWord = shuffledWords.removeFirst()
        delegate?.handleWord(gameService: self, word: currentWord)
        
        roundPoints = 0
        skippedWords = 0
        secondsRemaining = totalTimerSeconds
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer) in
            guard let self = self else {timer.invalidate(); return}
            self.secondsRemaining -= 1
            self.delegate?.timerDidUpdate(gameService: self, seconds: self.secondsRemaining)
            if self.secondsRemaining == 0 {
                self.delegate?.roundDidEnd(gameService: self, teamName: self.currentTeam!.name, roundPoints: self.roundPoints, roundResults: self.roundResults)
                var teamIndex = self.teams.firstIndex(where: {$0 == self.currentTeam})!
                teamIndex = (teamIndex < self.teams.count-1) ? teamIndex+1 : 0
                self.currentTeam = self.teams[teamIndex]
                timer.invalidate()
            }
        }
            
    }
    
    func guessedWord() {
        nextWord()
        roundPoints += withAction ? 3 : 1
        
        roundResults[currentWord] = true
        
    }
    
    func skipWord() {
        nextWord()
        roundPoints -= 1
        roundResults[currentWord] = false
    }
    
    func resetRound() {
        roundResults = [:]
    }
    
    func endGame() {
        teams.removeAll()
        roundResults.removeAll()
        usedWords.removeAll()
    }
    
    func nextWord(){
        usedWords[usedWords.count-1].append(currentWord)
        currentWord = shuffledWords.removeFirst()
        delegate?.handleWord(gameService: self, word: currentWord)
        if [true, false].randomElement()! {
            
            delegate?.handleAction(gameService: self, action: actions.randomElement()!)
            
        }
    }
    
    
}
