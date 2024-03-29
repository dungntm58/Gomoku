//
//  Gomoku.swift
//  Gomoku
//
//  Created by Robert on 09/04/2023.
//

import Foundation
import Combine
import GomokuBot

class HumanPlayer: Human {
    var delegate: PlayerDelegate?
    let id: PlayerIdentifier

    init(id: PlayerIdentifier = .random) {
        self.id = id
    }
}

class BotPlayer: Bot {
    var delegate: GomokuBot.PlayerDelegate?
    let id: PlayerIdentifier

    init(id: PlayerIdentifier = .random) {
        self.id = id
    }

    func makeMove(on board: Board) async throws -> Move {
        var move = makeRandomMove(on: board)
        while !board.canMark(move) {
            move = makeRandomMove(on: board)
        }
        return move
    }

    func makeRandomMove(on board: Board) -> Move {
        let row = Int.random(in: 0...board.row)
        let column = Int.random(in: 0...board.column)
        return Move(row: row, column: column, playerID: id)
    }
}

enum Symbol: String, CaseIterable {
    case x
    case o
    case empty = ""
    case block
}

class Gomoku: ObservableObject {
    var winnerTester: WinnerTestable

    @Published
    var isPlayingWithBot: Bool = false
    @Published
    var row: Int
    @Published
    var column: Int
    @Published
    var isStarted = false
    @Published
    var isWaitingForOpponent = false
    @Published
    var errorMessage: String?

    var cancellables = Set<AnyCancellable>()

    init(winnerTester: WinnerTestable = ClassicWinnerTester(), isPlayingWithBot: Bool = false, row: Int = 5, column: Int = 5) {
        self.winnerTester = winnerTester
        self.isPlayingWithBot = isPlayingWithBot
        self.row = row
        self.column = column
    }

    var currentGame: Game?

    func startNewGame() {
        let players: [any Player] = [
            HumanPlayer(),
            isPlayingWithBot ? BotPlayer() : HumanPlayer()
        ]

        let game = Game(board: .init(row: row, column: column, winnerTester: winnerTester), players: players)
        self.currentGame = game
        game.$board
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        game.start()
        isStarted = true
    }

    func tryMarkMove(row: Int, column: Int) {
        guard let currentGame, let mainID = currentGame.mainPlayer?.id else {
            return
        }
        do {
            try currentGame.board.mark(.init(row: row, column: column, playerID: mainID))
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func symbol(row: Int, column: Int) -> Symbol {
        guard let currentGame else {
            return .block
        }
        let id = currentGame.board[row][column]
        if id == 0 {
            return .empty
        }
        guard let index = currentGame.players.firstIndex(where: { id == $0.id.id }) else {
            return .block
        }
        return Symbol.allCases[index]
    }
}
