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
                .frame(idealHeight: CGFloat(gomoku.row) * cellSize, maxHeight: reader.size.height * 2/3)
                .background(Color.white)
            }
            if gomoku.isWaitingForOpponent {
                Text("Waiting for opponent...")
            }
        }
        .background(Color.red)
    }

    @ViewBuilder
    func cellAt(row: Int, column: Int) -> some View {
        let symbol = gomoku.symbol(row: row, column: column)
        switch symbol {
        case .x, .o, .empty:
            Button(symbol.rawValue) {
                gomoku.tryMarkMove(row: row, column: column)
            }
            .frame(width: .infinity, height: .infinity)
        case .block:
            Color.gray.frame(width: .infinity, height: .infinity)
        }
    }
}

struct GomokuGameView_Previews: PreviewProvider {
    static var previews: some View {
        GomokuGameView()
            .environmentObject(Gomoku(row: 5, column: 5))
    }
}
