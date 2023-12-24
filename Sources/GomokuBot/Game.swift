//
//  Game.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import Foundation
import Combine

public final class Game: ObservableObject {
    public private(set) var players: [any Player]
    @Published
    public var board: Board

    private var currentPlayerIndex: Int = -1
    private var mainPlayerIndex: Int?

    public init(board: Board, players: [any Player]) {
        self.board = board
        self.players = players
        setupPlayers()
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

    public var mainPlayer: (any Player)? {
        guard let mainPlayerIndex, mainPlayerIndex >= 0 && mainPlayerIndex < players.count else {
            return nil
        }
        return players[mainPlayerIndex]
    }

    public func setPlayers(_ players: [any Player], mainPlayerIndex: Int?) {
        self.players = players
        self.mainPlayerIndex = mainPlayerIndex
        setupPlayers()
    }

    public func addPlayer(_ player: any Player) {
        players.append(player)
    }

    public func start(withPlayerIndex index: Int) {
        assert(players.count > 1, "There must be at least 2 players to start a game")
        assert(index >= 0 && index < players.count, "Index must be within a range of 0..<players.count")
        currentPlayerIndex = index
    }

    public func start() {
        currentPlayerIndex = 0
    }
}

extension Game: PlayerDelegate {
    public func playerMakeMove(move: Move) async {
        do {
            try board.mark(move)
            if await state.isOver {
                return
            }
            passToNextPlayer()
            try await currentPlayer.opponentMoved(move, board: board)
        } catch let error as MoveError {
            await playerMakeFailedMove(id: move.playerID, error: error)
        } catch {}
    }

    public func playerMakeFailedMove(id: PlayerIdentifier, error: MoveError) async {
        
    }
}

private extension Game {
    func passToNextPlayer() {
        if currentPlayerIndex < players.count - 1 {
            return currentPlayerIndex += 1
        }
        currentPlayerIndex = 0
    }

    var currentPlayer: any Player {
        players[currentPlayerIndex]
    }

    func setupPlayers() {
        for i in stride(from: 0, to: players.count, by: 1) where players[i].delegate !== self {
            players[i].delegate = self
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
