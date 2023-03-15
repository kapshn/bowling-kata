//
//  File.swift
//  
//
//  Created by Igor Pervushin on 14.03.2023.
//

import Foundation

public class Frame {
    var firstRoll: Int
    var secondRoll: Int?
    var thirdRoll: Int?
    
    var isLastFrame: Bool = false
    
    var state: State {
        if isLastFrame {
            if
                (firstRoll == 10 && thirdRoll != nil) || // strike
                ((firstRoll + (secondRoll ?? 0)) == 10 && thirdRoll != nil) || // spare
                (firstRoll + (secondRoll ?? 0) < 10 && secondRoll != nil) // simple rolls
            {
                return State.finishedFrame
            } else {
                return State.unfinishedFrame
            }
        } else {
            if firstRoll == 10 {
                return State.strike
            } else if firstRoll + (secondRoll ?? 0) == 10 {
                return State.spare
            } else if secondRoll == nil {
                return State.unfinishedFrame
            } else {
                return State.finishedFrame
            }
        }
    }
    
    var score: Int {
        firstRoll + (secondRoll ?? 0) + (thirdRoll ?? 0)
    }
    
    enum State {
        case finishedFrame
        case unfinishedFrame
        case spare
        case strike
    }
    
    init(firstRoll: Int, secondRoll: Int? = nil, thirdRoll: Int? = nil, isLastFrame: Bool = false) {
        self.firstRoll = firstRoll
        self.secondRoll = secondRoll
        self.thirdRoll = thirdRoll
        self.isLastFrame = isLastFrame
    }
    
    func setNextRoll(_ rolledScore: Int) {
        if isLastFrame, secondRoll != nil {
            thirdRoll = rolledScore
        } else {
            secondRoll = rolledScore
        }
    }
}
