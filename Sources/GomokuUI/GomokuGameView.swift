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

    public init() {}

    @ViewBuilder
    public var body: some View {
        VStack {
            GeometryReader { reader in
                BoardView(
                    row: gomoku.row,
                    column: gomoku.column,
                    cellSize: cellSize,
                    cellContent: cellAt)
                .frame(height: reader.size.height * 2/3)
            }
            if gomoku.isWaitingForOpponent {
                Text("Waiting for opponent...")
            }
        }
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
            .environmentObject(Gomoku(row: 10, column: 10))
    }
}
