//
//  Bot.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import Foundation

public protocol Bot: Player {
    func makeMove(on board: Board) async throws -> Move
}

extension Bot {
    public func opponentMoved(_ move: Move, board: Board) async throws {
        do {
            let newMove = try await makeMove(on: board)
            await delegate?.playerMakeMove(move: newMove)
        } catch let error as MoveError {
            await delegate?.playerMakeFailedMove(id: id, error: error)
        } catch {}
    }
}
