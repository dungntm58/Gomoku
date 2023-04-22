//
//  Bot.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import SwiftUI
import GomokuBot
import Combine

public struct GomokuView: View {
    public init() {}

    @ViewBuilder
    public var body: some View {
        if #available(iOS 14.0, macOS 11.0, *) {
            NewGomokuView()
        } else {
            LegacyGomokuView()
        }
    }
}

@available(iOS 14.0, macOS 11.0, *)
private struct NewGomokuView: View {
    @StateObject var gomoku: Gomoku = .init()

    @ViewBuilder
    var body: some View {
        makeBody(with: gomoku)
    }
}

@available(iOS, obsoleted: 14)
@available(macOS, obsoleted: 11)
private struct LegacyGomokuView: View {
    @LegacyStateObject var gomoku: Gomoku = .init()

    @ViewBuilder
    var body: some View {
        makeBody(with: gomoku)
    }
}

@ViewBuilder
private func makeBody(with gomoku: Gomoku) -> some View {
    makeNavigationStack(with: gomoku)
        .edgesIgnoringSafeArea(.all)
}

@ViewBuilder
private func makeNavigationStack(with gomoku: Gomoku) -> some View {
    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) {
        NavigationStack {
            GomokuStartView()
                .edgesIgnoringSafeArea(.all)
        }
        .environmentObject(gomoku)
    } else {
        NavigationView {
            GomokuStartView()
                .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(.stack)
        .environmentObject(gomoku)
    }
}

@available(iOS 14.0, macOS 11.0, *)
struct GomokuView_Previews: PreviewProvider {
    static var previews: some View {
        GomokuView()
    }
}
