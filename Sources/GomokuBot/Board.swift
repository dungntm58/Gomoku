//
//  Board.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import Foundation

public typealias BoardColumn = ContiguousArray<Int>
public typealias BoardGrid = ContiguousArray<BoardColumn>

public struct Board {
    public let row: Int
    public let column: Int
    private let winnerTester: WinnerTestable

    private var grid: BoardGrid
    private var moves: [Move]

    public private(set) var canMakeMove: Bool

    public init(row: Int, column: Int, winnerTester: WinnerTestable) {
        assert(row >= 5 || column >= 5)
        self.row = row
        self.column = column

        var grid = BoardGrid()
        for _ in stride(from: 0, to: row, by: 1) {
            grid.append(.init(repeating: 0, count: column))
        }
        self.grid = grid
        self.moves = []
        self.winnerTester = winnerTester
        self.canMakeMove = true
    }

    public subscript(_ row: Int) -> BoardColumn {
        grid[row]
    }

    public var lastMove: Move? {
        moves.last
    }

    public func canMark(_ move: Move) -> Bool {
        if isRunningOutOfMove {
            return false
        }
        return grid[move.row][move.column] == 0
    }

    public mutating func mark(_ move: Move) throws {
        guard isRunningOutOfMove else {
            canMakeMove = false
            throw MoveError.runOutOfMoves
        }
        guard grid[move.row][move.column] == 0 else {
            throw MoveError.illegalMove(move)
        }
        moves.append(move)
        grid[move.row][move.column] = Int(move.playerID.id)
    }

    public mutating func undoLastMove() {
        guard let lastMove = moves.last else {
            return
        }
        canMakeMove = true
        grid[lastMove.row][lastMove.column] = 0
    }

    public var isRunningOutOfMove: Bool {
        moves.count == row * column
    }

    public func checkWin() async -> UInt? {
        await withTaskGroup(of: UInt?.self, body: { group in
            let taskPriority = TaskPriority.background
            // Check each row
            for i in stride(from: 0, to: row, by: 1) {
                group.addTask(priority: taskPriority) {
                    return winnerTester.testRow(at: i, grid: grid)
                }
            }
            // Check each column
            for i in stride(from: 0, to: column, by: 1) {
                group.addTask(priority: taskPriority) {
                    return winnerTester.testColumn(at: i, grid: grid)
                }
            }
            // Check primary diagonals
            for i in stride(from: 0, to: row, by: 1) {
                group.addTask(priority: taskPriority) {
                    return winnerTester.testPrimaryDiagonal(row: i, column: 0, grid: grid)
                }
            }
            for i in stride(from: 0, to: column, by: 1) {
                group.addTask(priority: taskPriority) {
                    return winnerTester.testPrimaryDiagonal(row: 0, column: i, grid: grid)
                }
            }
            
            // Check secondary diagonals
            for i in stride(from: 0, to: row, by: 1) {
                group.addTask(priority: taskPriority) {
                    return winnerTester.testSecondaryDiagonal(row: i, column: 0, grid: grid)
                }
            }
            for i in stride(from: 0, to: column, by: 1) {
                group.addTask(priority: taskPriority) {
                    return winnerTester.testSecondaryDiagonal(row: 0, column: i, grid: grid)
                }
            }
            for await result in group {
                if let result {
                    return result
                }
            }
            return nil
        })
    }
}

public enum MoveError: LocalizedError {
    case illegalMove(_ move: Move)
    case runOutOfMoves

    public var errorDescription: String? {
        switch self {
        case .illegalMove(let move):
            return "Illegal move at row \(move.row) and column \(move.column)"
        case .runOutOfMoves:
            return "Run out of moves"
        }
    }
}
