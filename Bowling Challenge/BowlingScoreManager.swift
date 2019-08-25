//
//  BowlingScoreManager.swift
//  Bowling Challenge
//
//  Created by Mohamed Ali on 25/08/2019.
//  Copyright © 2019 Wedev. All rights reserved.
//

import Foundation


struct Frame {
    private(set) var scores: [Int] = []
    
    var isStrike: Bool {
        guard let firstScore = scores.first else {
            return false
        }
        return firstScore == 10
    }
    
    var isSpare: Bool {
        guard scores.count >= 2 else {
            return false
        }
        let computedScore = scores[0] + scores[1]
        return computedScore == 10
    }
    
    var isDone: Bool {
        return isSpare || isStrike || scores.count == 2
    }
    
    var totalScore: Int? {
        if (isSpare || isStrike && scores.count < 3) {
            return nil
        }
        return scores.reduce(0, +)
    }
    
    /// - TODO: Handle error
    @discardableResult
    mutating func addScore(score: Int) -> Bool {
        scores.append(score)
        return true
    }
    
}

final class BowlingScoreManager {
    var currentFrame: Int
    var frames: [Frame]
    
    init() {
        currentFrame = 0
        frames = [Frame()]
    }
    
    func frameNumber() -> Int {
        return frames.count
    }
    
    func scoreSoFar() -> Int {
        return frames.reduce(0, { (result, frame) -> Int in
            let totalScore = frame.totalScore ?? 0
            return result + totalScore
        })
    }
    
    func gameIsOver() -> Bool {
        guard let lastFrame = frames.last else {
            return false
        }
        return frames.count == 10 && lastFrame.totalScore != nil
    }
    
    @discardableResult
    func roll(pinKnocked: Int) -> [Frame] {
        guard frames.indices.contains(currentFrame) else {
            return frames
        }
        if frames[currentFrame].isDone {
            var frame = Frame()
            frame.addScore(score: pinKnocked)
            frames.append(frame)
            currentFrame += 1
        } else {
            frames[currentFrame].addScore(score: pinKnocked)
        }
        updateScores()
        return frames
    }
    
    func updateScores() {
        for (key, value) in frames.enumerated()
            where value.totalScore == nil {
                if frames[key].isSpare,
                    let nextScore = retrieveNextScore(at: key) {
                    frames[key].addScore(score: nextScore)
                } else if frames[key].isStrike,
                    let nextScore = retrieveStrikeScore(at: key) {
                    frames[key].addScore(score: nextScore.0)
                    frames[key].addScore(score: nextScore.1)
                }
        }
    }
    
    func retrieveNextScore(at index: Int) -> Int? {
        guard frames.indices.contains(index + 1),
            let nextScore = frames[index + 1].scores.first else {
                return nil
        }
        return nextScore
    }
    
    func retrieveStrikeScore(at index: Int) -> (Int, Int)? {
        guard frames.indices.contains(index + 1) else {
            return nil
        }
        let nextFrame = frames[index + 1]
        if nextFrame.isStrike,
            let score = retrieveNextScore(at: index + 1) {
            return (10, score)
        } else if nextFrame.scores.count >= 2 {
            return (nextFrame.scores[0], nextFrame.scores[1])
        }
        return nil
    }
    
}
