//
//  GomokuGameView.swift
//  Gomoku
//
//  Created by Robert on 26/03/2023.
//

import SwiftUI
import GomokuBot

public struct GomokuGameView: View {

    @EnvironmentObject var gomoku: Gomoku

    let cellSize: CGFloat = 50

    @ViewBuilder
    public var body: some View {
        BoardView(row: gomoku.row, column: gomoku.column, cellSize: 50, cellContent: cellAt)
    }

    @ViewBuilder
    func cellAt(row: Int, column: Int) -> some View {
        Button {
            gomoku.tryMarkMove(row: row, column: column)
        } label: {
            Text(gomoku.symbol(row: row, column: column))
        }
    }
}

struct GomokuGameView_Previews: PreviewProvider {
    static var previews: some View {
        GomokuGameView()
            .environmentObject(Gomoku(row: 30, column: 30))
    }
}
