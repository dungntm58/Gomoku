//
//  BoardView.swift
//  Gomoku
//
//  Created by Robert on 09/04/2023.
//

import SwiftUI

public struct BoardView<Cell>: View where Cell: View {
    let row: Int
    let column: Int
    let cellSize: CGFloat
    let cellContent: (Int, Int) -> Cell

    public init(row: Int, column: Int, cellSize: CGFloat, cellContent: @escaping (Int, Int) -> Cell) {
        self.row = row
        self.column = column
        self.cellSize = cellSize
        self.cellContent = cellContent
    }

    @ViewBuilder
    public var body: some View {
        ScrollView([.horizontal, .vertical]) {
            if #available(iOS 16.0, macOS 13.0, *) {
                _NewFixedBoardView(row: row, column: column, cellSize: cellSize, cellContent: cellContent)
            } else {
                _FixedBoardView(row: row, column: column, cellSize: cellSize, cellContent: cellContent)
            }
        }
    }
}

@available(iOS 16.0, macOS 13.0, *)
private struct _NewFixedBoardView<Cell>: View where Cell: View {
    let row: Int
    let column: Int
    let cellSize: CGFloat
    let cellContent: (Int, Int) -> Cell

    public init(row: Int, column: Int, cellSize: CGFloat, cellContent: @escaping (Int, Int) -> Cell) {
        self.row = row
        self.column = column
        self.cellSize = cellSize
        self.cellContent = cellContent
    }

    @ViewBuilder
    public var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<row, id: \.self) { r in
                GridRow {
                    ForEach(0..<column, id: \.self) { c in
                        HStack(spacing: 0) {
                            cellContent(r, c)
                                .frame(width: cellSize, height: cellSize)
                            if c < column - 1 {
                                Divider()
                            }
                        }
                    }
                }
                if r < row - 1 {
                    Divider()
                }
            }
        }
    }
}

private struct _FixedBoardView<Cell>: View where Cell: View {
    let row: Int
    let column: Int
    let cellSize: CGFloat
    let cellContent: (Int, Int) -> Cell

    init(row: Int, column: Int, cellSize: CGFloat, cellContent: @escaping (Int, Int) -> Cell) {
        self.row = row
        self.column = column
        self.cellSize = cellSize
        self.cellContent = cellContent
    }

    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<row, id: \.self) { r in
                HStack(spacing: 0) {
                    ForEach(0..<column, id: \.self) { c in
                        cellContent(r, c)
                            .frame(width: cellSize)
                        if c < column - 1 {
                            Divider()
                        }
                    }
                }
                .frame(height: cellSize)
                if r < row - 1 {
                    Divider()
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    @ViewBuilder
    static func cellAt(row: Int, column: Int) -> some View {
        Text("\(row) \(column)")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
    }

    static var previews: some View {
        if #available(iOS 16.0, *) {
            ScrollView([.horizontal, .vertical]) {
                _NewFixedBoardView(row: 30, column: 30, cellSize: 50, cellContent: cellAt(row:column:))
            }
        }
        ScrollView([.horizontal, .vertical]) {
            _FixedBoardView(row: 30, column: 30, cellSize: 50, cellContent: cellAt(row:column:))
        }
    }
}
