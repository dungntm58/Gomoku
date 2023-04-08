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
                GomokuGameView()
            }
            .environmentObject(gomoku)
        } else {
            NavigationView {
                GomokuGameView()
            }
            .environmentObject(gomoku)
        }
    }
}

class Gomoku: ObservableObject {
    var players: [any Player] = []
    var winnerTester: WinnerTestable?

    @Published
    var isPlayingWithBot: Bool = false
    @Published
    var row: Int
    @Published
    var column: Int

    init(players: [any Player] = [], winnerTester: WinnerTestable? = nil, isPlayingWithBot: Bool = false, row: Int = 5, column: Int = 5) {
        self.players = players
        self.winnerTester = winnerTester
        self.isPlayingWithBot = isPlayingWithBot
        self.row = row
        self.column = column
    }

    var currentGame: Game?

    func startNewGame() {
        guard let winnerTester else {
            return
        }
        currentGame = Game(board: .init(row: row, column: column, winnerTester: winnerTester), players: players)
        currentGame?.start()
    }

    func tryMarkMove(row: Int, column: Int) {
        
    }

    func symbol(row: Int, column: Int) -> String {
        "x"
    }
}

@available(iOS 14.0, macOS 11.0, *)
struct GomokuView_Previews: PreviewProvider {
    static var previews: some View {
        GomokuView()
    }
}
