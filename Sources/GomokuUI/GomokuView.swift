//
//  Bot.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import SwiftUI
import GomokuBot
import Combine

@available(iOS 14.0, macOS 11.0, *)
public struct GomokuView: View {

    @StateObject var gomoku: Gomoku = .init()

    @ViewBuilder
    public var body: some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) {
            NavigationStack {
                GomokuStartView()
            }
            .environmentObject(gomoku)
        } else {
            NavigationView {
                GomokuStartView()
            }
            .environmentObject(gomoku)
        }
    }
}

@available(iOS 14.0, macOS 11.0, *)
struct GomokuView_Previews: PreviewProvider {
    static var previews: some View {
        GomokuView()
    }
}
