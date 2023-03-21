//
//  Game.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import Foundation
import Distributed

public class Game {
    public var players: [any Player]
    public var board: Board

    public init(board: Board, players: [any Player]) {
        self.board = board
        self.players = players
    }

    public convenience init(board: Board, player: any Player...) {
        self.init(board: board, players: player)
    }

    public var state: State {
        get async {
            if let winner = await board.checkWin(), let winner = players.first(where: { $0.id.id == winner }) {
                return .win(player: winner)
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
