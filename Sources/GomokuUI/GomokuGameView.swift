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

    @ViewBuilder
    public var body: some View {
        ScrollView {
            ForEach(0..<gomoku.row, id: \.self) { row in
                if #available(iOS 14.0, macOS 11.0, *) {
                    LazyHGrid(rows: Array(repeating: GridItem(.fixed(50 * CGFloat(gomoku.row))), count: gomoku.row)) {
                        ForEach(0..<gomoku.column, id: \.self) { column in
                            cellAt(row: row, column: column)
                        }
                    }
                    .frame(height: 50)
                } else {
                    HStack {
                        VStack {
                            ForEach(0..<gomoku.column, id: \.self) { column in
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

struct GomokuGameView_Previews: PreviewProvider {
    static var previews: some View {
        GomokuGameView()
            .environmentObject(Gomoku(row: 5, column: 5))
    }
}
