//
//  AliasTests.swift
//  AliasTests
//
//  Created by Victor Rubenko on 03.05.2022.
//

import XCTest
@testable import Alias

class AliasTests: XCTestCase {
    
    var sut: GameBaseService!
    var score = 0
    var getAction = false

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = GameBrain.shared
        sut.setActionFrequency(.none)
    }

    override func tearDownWithError() throws {
        sut = nil
        score = 0
        getAction = false
    }
    
    func testMinimumTeams() {
        XCTAssertEqual(sut.teams.count, 2)
    }
    
    func testScoreIsComputedCorrectly() {
        sut.delegate = self
        sut.selectCategory(0)
        sut.startNewGame()
        sut.startCurrentTeamRound()
        
        score += getAction ? 3 : 1
        sut.guessedWord()
        
        score += getAction ? 3 : 1
        sut.guessedWord()
        
        score += getAction ? 3 : 1
        sut.guessedWord()
        
        score -= getAction ? 3 : 1
        sut.skipWord()
        
        XCTAssertEqual(sut.points, score)
        XCTAssertEqual(sut.roundResults.reduce(0, { partialResult, element in
            partialResult + (element.guessed ? 1 : 0)
        }), 3)
        
        sut.resetTeamRound()
    }
}

extension AliasTests: GameServiceDelegate {
    func teamRoundDidEnd(gameService: GameBaseService) {
        
    }
    
    func gameDidEnd(gameService: GameBaseService) {
        
    }
    
    func handleWord(gameService: GameBaseService, word: String, action: String?) {
        getAction = action != nil
    }
    
    func timerDidUpdate(gameService: GameBaseService, seconds: Int) {
        
    }
    
}
