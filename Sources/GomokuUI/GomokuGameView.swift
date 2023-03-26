//
//  GomokuGameView.swift
//  Gomoku
//
//  Created by Robert on 26/03/2023.
//

import SwiftUI
import GomokuBot

public struct GomokuGameView: View {

    @EnvironmentObject var game: Game

    @ViewBuilder
    public var body: some View {
        ScrollView {
            ForEach(0..<game.board.row, id: \.self) { row in
                if #available(iOS 14.0, macOS 11.0, *) {
                    LazyHGrid(rows: Array(repeating: GridItem(.fixed(50 * CGFloat(game.board.row))), count: game.board.row)) {
                        ForEach(0..<game.board.column, id: \.self) { column in
                            cellAt(row: row, column: column)
                        }
                    }
                    .frame(height: 50)
                } else {
                    HStack {
                        VStack {
                            ForEach(0..<game.board.column, id: \.self) { column in
                                cellAt(row: row, column: column)
                            }
                        }
                    }
                    .frame(height: 50)
                }
            }
        }
    }

    @ViewBuilder
    func cellAt(row: Int, column: Int) -> some View {
        Button {
            
        } label: {
            Text("")
        }
    }
}
