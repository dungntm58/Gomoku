//
//  Bot.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import SwiftUI
import GomokuBot

@available(iOS 14.0, macOS 11.0, *)
public struct GomokuView: View {

    @StateObject var gomoku: Gomoku = .init()

    @ViewBuilder
    public var body: some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) {
            NavigationStack {
                
            }
        } else {
            NavigationView {
                
            }
        }
    }
}

class Gomoku: ObservableObject {
    var row: Int = 0
    var column: Int = 0
    var players: [any Player] = []
    var winnerTester: WinnerTestable?

    var currentGame: Game?

    func startNewGame() {
        guard let winnerTester else {
            return
        }
        currentGame = Game(board: .init(row: row, column: column, winnerTester: winnerTester), players: players)
        currentGame?.start()
    }
}
