//
//  Bowling_ChallengeTests.swift
//  Bowling ChallengeTests
//
//  Created by Mohamed Ali on 25/08/2019.
//  Copyright © 2019 Wedev. All rights reserved.
//

import XCTest
@testable import Bowling_Challenge

class Bowling_ChallengeTests: XCTestCase {

    var scoreManager = BowlingScoreManager()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        scoreManager.roll(pinKnocked: 9)
        scoreManager.roll(pinKnocked: 1)

        scoreManager.roll(pinKnocked: 0)
        scoreManager.roll(pinKnocked: 10)

        scoreManager.roll(pinKnocked: 10)

        scoreManager.roll(pinKnocked: 10)

        scoreManager.roll(pinKnocked: 6)
        scoreManager.roll(pinKnocked: 2)

        scoreManager.roll(pinKnocked: 7)
        scoreManager.roll(pinKnocked: 3)

        scoreManager.roll(pinKnocked: 8)
        scoreManager.roll(pinKnocked: 2)
        
        scoreManager.roll(pinKnocked: 10)

        scoreManager.roll(pinKnocked: 9)
        scoreManager.roll(pinKnocked: 0)

        scoreManager.roll(pinKnocked: 9)
        scoreManager.roll(pinKnocked: 0)


    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFrameNumber() {
        XCTAssertEqual(scoreManager.frameNumber(), 6)
    }

    func testScoreSoFar() {
        XCTAssertEqual(scoreManager.scoreSoFar(), 56)
    }
    
    func testGameIsOver() {
        XCTAssertFalse(scoreManager.gameIsOver())
    }
    
    func testRoll() {
        let frames = scoreManager.roll(pinKnocked: 8)
        XCTAssertEqual(frames.count, 4)
        XCTAssertEqual(scoreManager.scoreSoFar(), 64)
    }
    
    func testMaxScore() {
        let scoreMax = BowlingScoreManager()
        for _ in 0...9 {
            scoreMax.roll(pinKnocked: 10)
            scoreMax.roll(pinKnocked: 10)
            scoreMax.roll(pinKnocked: 10)
        }
        XCTAssertEqual(scoreMax.scoreSoFar(), 300)
        XCTAssertTrue(scoreMax.gameIsOver())
    }

}
