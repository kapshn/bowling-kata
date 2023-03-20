//
//  Monitor.swift
//  
//
//  Created by Igor Pervushin on 20.03.2023.
//

import Foundation

final class Monitor {
    typealias Player = (name: String, game: Game)
    var players: [Player] = []
    var playerTurnIndex: Int {
        if players.first?.game.frameCount == 0 {
            return 0
        }
        
        for (index, player) in players.enumerated() {
            if player.game.isFrameFinished {
                if let nextPlayer = players[safe: index + 1], nextPlayer.game.isFrameFinished, player.game.frameCount != nextPlayer.game.frameCount {
                    return index + 1
                }
            } else {
                return index
            }
        }
        
        return 0
    }
    
    func addPlayer(_ name: String) {
        players.append(Player(name: name, game: Game()))
    }
    
    func roll(_ rollScore: Int) {
        players[playerTurnIndex].game.roll(rollScore)
    }
}

fileprivate extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
