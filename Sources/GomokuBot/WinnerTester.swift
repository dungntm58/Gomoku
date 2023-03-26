//
//  WinnerTester.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import Foundation

public protocol WinnerTestable {
    func testRow(at row: Int, grid: BoardGrid) -> UInt?
    func testColumn(at column: Int, grid: BoardGrid) -> UInt?
    func testPrimaryDiagonal(row: Int, column: Int, grid: BoardGrid) -> UInt? // \ diagonal
    func testSecondaryDiagonal(row: Int, column: Int, grid: BoardGrid) -> UInt? // / diagonal
}

public struct ClassicWinnerTester: WinnerTestable {
    public init() {}

    public func testRow(at row: Int, grid: BoardGrid) -> UInt? {
        let gridColumn = grid[row]
        guard var index = gridColumn.firstIndex(where: { $0 > 0 }) else {
            return nil
        }
        var currentValue = gridColumn[index]
        let column = gridColumn.count
        while index < column {
            var firstDiffIndex = index + 1
            while firstDiffIndex < column && gridColumn[firstDiffIndex] == currentValue {
                firstDiffIndex += 1
            }
            if firstDiffIndex - index >= 5 {
                return UInt(currentValue)
            }
            if firstDiffIndex < column {
                currentValue = gridColumn[firstDiffIndex]
            }
            index = firstDiffIndex
        }
        return nil
    }

    public func testColumn(at column: Int, grid: BoardGrid) -> UInt? {
        guard var index = grid.firstIndex(where: { $0[column] > 0 }) else {
            return nil
        }
        var currentValue = grid[index][column]
        let row = grid.count
        while index < row {
            var firstDiffIndex = index + 1
            while firstDiffIndex < row && grid[firstDiffIndex][column] == currentValue {
                firstDiffIndex += 1
            }
            if firstDiffIndex - index >= 5 {
                return UInt(currentValue)
            }
            if firstDiffIndex < row {
                currentValue = grid[firstDiffIndex][column]
            }
            index = firstDiffIndex
        }
        return nil
    }

    public func testPrimaryDiagonal(row: Int, column: Int, grid: BoardGrid) -> UInt? {
        if grid.isEmpty {
            return nil
        }
        let scanningEdge = min(grid.count, grid[0].count)
        var row = row, column = column
        while row < scanningEdge && column < scanningEdge && grid[row][column] <= 0 {
            row += 1
            column += 1
        }
        if row >= scanningEdge || column >= scanningEdge {
            return nil
        }
        var currentValue = grid[row][column]
        while row < scanningEdge && column < scanningEdge {
            var firstDiffRow = row, firstDiffColumn = column
            while firstDiffRow < scanningEdge && firstDiffColumn < scanningEdge && grid[firstDiffRow][firstDiffColumn] == currentValue {
                firstDiffRow += 1
                firstDiffColumn += 1
            }
            if firstDiffRow - row >= 5 {
                return UInt(currentValue)
            }
            if firstDiffRow < scanningEdge && firstDiffColumn < scanningEdge {
                currentValue = grid[firstDiffRow][firstDiffColumn]
            }
            row = firstDiffRow
            column = firstDiffColumn
        }
        return nil
    }

    public func testSecondaryDiagonal(row: Int, column: Int, grid: BoardGrid) -> UInt? {
        if grid.isEmpty {
            return nil
        }
        let scanningEdge = min(grid.count, grid[0].count)
        var row = row, column = column
        while row >= 0 && column < scanningEdge && grid[row][column] <= 0 {
            row -= 1
            column += 1
        }
        if row < 0 || column >= scanningEdge {
            return nil
        }
        var currentValue = grid[row][column]
        while row >= 0 && column < scanningEdge {
            var firstDiffRow = row, firstDiffColumn = column
            while firstDiffRow >= 0 && firstDiffColumn < scanningEdge && grid[firstDiffRow][firstDiffColumn] == currentValue {
                firstDiffRow -= 1
                firstDiffColumn += 1
            }
            if row - firstDiffRow >= 5 {
                return UInt(currentValue)
            }
            if firstDiffRow >= 0 && firstDiffColumn < scanningEdge {
                currentValue = grid[firstDiffRow][firstDiffColumn]
            }
            row = firstDiffRow
            column = firstDiffColumn
        }
        return nil
    }
}
