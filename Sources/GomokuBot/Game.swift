//
//  Game.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import Foundation
import Distributed

public class Game {
    public let mainPlayer: any Player
    public let opponent: any Player
    public var board: Board

    public init(mainPlayer: any Player, opponent: any Player, board: Board) {
        self.mainPlayer = mainPlayer
        self.opponent = opponent
        self.board = board
    }

    public var state: State {
        get async {
            if let winner = await board.checkWin() {
                if winner == mainPlayer.id.id {
                    return .win(player: mainPlayer)
                } else {
                    return .win(player: opponent)
                }
            }
            if board.isRunningOutOfMove {
                return .draw
            }
            return .playing
        }
    }
}

extension Game {
    public enum State {
        case playing
        case draw
        case win(player: any Player)

        public var isOver: Bool {
            if case .playing = self {
                return false
            }
            return true
        }
    }
}
