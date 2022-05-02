//
//  Temp.swift
//  Alias
//
//  Created by Victor Rubenko on 02.05.2022.
//

import Foundation

final class GameServiceForTest: GameServiceProtocol {
    static let shared = GameServiceForTest()
    
    var currentRound: Int = 1
    var roundPoints: Int = 3
    var skippedWords: Int = 2
    var totalRounds: Int = 4
    var roundResults: [String : Bool] = ["aaa": true, "bbb": false]
    var teams: [TeamModel] = [TeamModel(name: "a", score: 0), TeamModel(name: "b", score: 0)]
    var currentTeam: TeamModel = TeamModel(name: "a", score: 0)
    var categories: [CategoryModel] = [CategoryModel(name: "cat 1", words: ["a", "b"]), CategoryModel(name: "cat 2", words: ["c", "d"])]
    var totalSeconds: Int = 30
    
    private init() {}
    
    func addTeam(name: String) {
        
    }
    
    func deleteTeam(at: Int) {
        
    }
    
    func setRounds(_ rounds: Int) {
        
    }
    
    func setSeconds(_ seconds: Int) {
        
    }
    
    func selectCategory(_ index: Int) {
        
    }
    
    func startNewGame() {
        
    }
    
    func startRound() {
        
    }
    
    func guessedWord() {
        
    }
    
    func skipWord() {
        
    }
    
    func resetRound() {
        
    }
}
