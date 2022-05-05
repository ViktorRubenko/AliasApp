//
//  GameBrain_v2.swift
//  Alias
//
//  Created by Андрей Бородкин on 03.05.2022.
//

import Foundation

class GameBrain: GameBaseService {
    
    static let shared = GameBrain()
    
    weak var delegate: GameServiceDelegate?
    
    private(set) var currentRound: Int = 1
    private(set) var points: Int = 0
    private(set) var skippedWords: Int = 0
    private(set) var totalRounds: Int = 4
    private(set) var roundResults: [(word: String, guessed: Bool)] = []
    private(set) var teams: [TeamModel] = [
        TeamModel(name: "Травоядные", score: 0),
        TeamModel(name: "Хищники", score: 0)
    ]
    private(set) var currentTeam: TeamModel? = nil
    let categories: [CategoryModel] = CategoriesDict.sorted(by: { $0.value.count > $1.value.count }).compactMap {
        CategoryModel(name: $0, words: $1)
    }
    private(set) var totalTimerSeconds: Int = 4
    var gameDidEnd: Bool {
        subRoundsPlayed == teams.count * totalRounds
    }
    
    private var withAction: Bool = false
    private var currentWord: String = ""
    private let actions: [String] = GameActions
    private var secondsRemaining: Int = 0
    private var currentCategory: CategoryModel? = nil
    private var usedWords: [[String]] = []
    private var shuffledWords: [String] = []
    weak private var timer: Timer?
    private var subRoundsPlayed = 0
    
    private init() {}
    
    func addTeam(name: String) {
        teams.append(TeamModel(name: name, score: 0))
    }
    
    func deleteTeam(at: Int) {
        if teams.count > 2 {
            teams.remove(at: at)
        }
    }
    
    func renameTeam(index: Int, name: String) {
        teams[index].name = name
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
        currentRound = 1
        subRoundsPlayed = 0
        for i in 0..<teams.count {
            teams[i].score = 0
        }
        roundResults.removeAll()
        usedWords.removeAll()
        timer?.invalidate()
        currentTeam = teams.first
        guard let currentCategory = currentCategory else {
            return
        }
        shuffledWords = currentCategory.words.shuffled()
    }
    
    func startCurrentTeamRound() {
        if currentRound > totalRounds {
            fatalError()
        }
        roundResults.removeAll()
        points = 0
        skippedWords = 0
        secondsRemaining = totalTimerSeconds
        
        if usedWords.count > 4 {
            shuffledWords += usedWords.removeFirst()
            shuffledWords.shuffle()
        }
        
        usedWords.append([])
        
        currentWord = shuffledWords.removeFirst()
        delegate?.handleWord(gameService: self, word: currentWord, action: nil)
        
        startTimer()
    }
    
    func guessedWord() {
        points += withAction ? 3 : 1
        roundResults.append((word: currentWord, guessed: true))
        nextWord()
    }
    
    func skipWord() {
        points -= points > 0 ? 1 : 0
        skippedWords += 1
        roundResults.append((word: currentWord, guessed: false))
        nextWord()
    }
    
    func resetTeamRound() {
        timer?.invalidate()
    }
    
    func endTeamRound() {
        usedWords[usedWords.count - 1].append(currentWord)
        var teamIndex = teams.firstIndex(where: {$0 == currentTeam})!
        teams[teamIndex].score += points
        teamIndex = (teamIndex < teams.count-1) ? teamIndex + 1 : 0
        currentTeam = teams[teamIndex]
        if teamIndex == 0 {
            currentRound += 1
        }
    }
}

private extension GameBrain {
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer) in
            guard let self = self else {timer.invalidate(); return}
            self.secondsRemaining -= 1
            self.delegate?.timerDidUpdate(gameService: self, seconds: self.secondsRemaining)
            if self.secondsRemaining == 0 {
                self.subRoundsPlayed += 1
                self.delegate?.teamRoundDidEnd(gameService: self)
                timer.invalidate()
            }
        }
    }
    
    func checkSuffledWords() {
        if shuffledWords.count < 1 {
            shuffledWords += usedWords.removeFirst()
            shuffledWords.shuffle()
        }
    }
    
    func nextWord() {
        usedWords[usedWords.count - 1].append(currentWord)
        currentWord = shuffledWords.removeFirst()
        withAction = [true, false, false, false].randomElement()!
        delegate?.handleWord(gameService: self, word: currentWord, action: withAction ? actions.randomElement()! : nil)
        checkSuffledWords()
    }
}
