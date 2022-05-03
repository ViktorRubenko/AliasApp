//
//  AliasTests.swift
//  AliasTests
//
//  Created by Victor Rubenko on 03.05.2022.
//

import XCTest
@testable import Alias

class AliasTests: XCTestCase {
    
    var sut: GameServiceProtocol!
    var score = 0
    var getAction = false

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = GameBrain.shared
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
        sut.startRound()
        
        score += getAction ? 3 : 1
        sut.guessedWord()
        
        score += getAction ? 3 : 1
        sut.guessedWord()
        
        score += getAction ? 3 : 1
        sut.guessedWord()
        
        score -= 1
        sut.skipWord()
        
        XCTAssertEqual(sut.roundPoints, score)
        XCTAssertEqual(sut.roundResults.reduce(0, { partialResult, element in
            partialResult + (element.value ? 1 : 0)
        }), 3)
        
        sut.resetRound()
    }
}

extension AliasTests: GameServiceDelegate {
    
    func handleWord(gameService: GameServiceProtocol, word: String, action: String?) {
        
    }
    
    func timerDidUpdate(gameService: GameServiceProtocol, seconds: Int) {
        
    }
    
    func roundDidEnd(gameService: GameServiceProtocol, teamName: String, roundPoints: Int, roundResults: [String : Bool]) {
        
    }
    
    
}
