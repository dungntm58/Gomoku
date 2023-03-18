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
    func testPrimaryDiagonal(start: Int, grid: BoardGrid) -> UInt? // \ diagonal
    func testSecondaryDiagonal(start: Int, grid: BoardGrid) -> UInt? // / diagonal
}

public struct ClassicWinnerTester: WinnerTestable {
    public func testRow(at row: Int, grid: BoardGrid) -> UInt? {
        let gridColumn = grid[row]
        guard var index = gridColumn.first(where: { $0 > 0 }) else {
            return nil
        }
        var currentValue = gridColumn[index]
        let column = gridColumn.count
        var firstDiffIndex = index
        while index < column {
            if firstDiffIndex < column && gridColumn[firstDiffIndex] == currentValue {
                firstDiffIndex += 1
            }
            if firstDiffIndex - index >= 5 {
                return UInt(currentValue)
            }
            while gridColumn[firstDiffIndex] <= 0 {
                firstDiffIndex += 1
            }
            currentValue = gridColumn[firstDiffIndex]
            index = firstDiffIndex
        }
        return nil
    }

    public func testColumn(at column: Int, grid: BoardGrid) -> UInt? {
        return nil
    }

    public func testPrimaryDiagonal(start: Int, grid: BoardGrid) -> UInt? {
        return nil
    }

    public func testSecondaryDiagonal(start: Int, grid: BoardGrid) -> UInt? {
        return nil
    }
}
