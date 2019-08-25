//
//  Frame_Tests.swift
//  Bowling ChallengeTests
//
//  Created by Mohamed Ali on 25/08/2019.
//  Copyright © 2019 Wedev. All rights reserved.
//

import Foundation
import XCTest

@testable import Bowling_Challenge

class FrameTests: XCTestCase {
    var frame = Frame()

    override func setUp() {
        frame.addScore(score: 0)
        frame.addScore(score: 5)
    }
    
    func testIsSpare() {
        var frame = Frame()
        frame.addScore(score: 5)
        frame.addScore(score: 5)
        XCTAssertTrue(frame.isSpare)
        XCTAssertFalse(frame.isStrike)
    }

    func testIsStrike() {
        var frame = Frame()
        frame.addScore(score: 10)
        XCTAssertTrue(frame.isStrike)
        XCTAssertFalse(frame.isSpare)
    }

    func testAddScore() {
        let isAdded = frame.addScore(score: 8)
        XCTAssertFalse(isAdded)
    }

    func testAddWrongScore() {
        XCTAssertFalse(frame.addScore(score: -9))
        XCTAssertFalse(frame.addScore(score: 17))
    }

    
    func testIsDone() {
        XCTAssertTrue(frame.isDone)
    }

    
    func testTotalScore() {
        XCTAssertEqual(5, frame.totalScore)
    }


}
