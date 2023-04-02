//
//  GomokuStartView.swift
//  Gomoku
//
//  Created by Robert on 26/03/2023.
//

import SwiftUI
import GomokuBot

public struct GomokuStartView: View {

    @EnvironmentObject var gomoku: Gomoku

    @ViewBuilder
    public var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Row: ")
                    Counter(value: $gomoku.row)
                }

                HStack {
                    Text("Column: ")
                    Counter(value: $gomoku.column)
                }

                Spacer().frame(height: 24)

                Toggle("Play with AI", isOn: $gomoku.isPlayingWithBot)
                    .toggleStyle(CheckToggleStyle())

                Spacer().frame(height: 40)

                Button {
                    gomoku.startNewGame()
                } label: {
                    Text("Start")
                }
                .buttonStyle(GrowingButton())
            }
        }
    }
}

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            if #available(iOS 14.0, *) {
                Label {
                    configuration.label
                } icon: {
                    buildIcon(configuration: configuration)
                }
            } else {
                HStack(spacing: 8) {
                    buildIcon(configuration: configuration)
                    
                    configuration.label
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    @ViewBuilder
    func buildIcon(configuration: Configuration) -> some View {
        Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
            .foregroundColor(configuration.isOn ? .accentColor : .secondary)
            .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
            .imageScale(.large)
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
                .padding(.vertical, 16)
                .foregroundColor(.white)
        }
        .frame(minWidth: 100)
        .background(Color.blue)
        .clipShape(Capsule())
        .scaleEffect(configuration.isPressed ? 1.2 : 1)
        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
 
struct GomokuStartView_Previews: PreviewProvider {
    static var previews: some View {
        GomokuStartView()
            .environmentObject(Gomoku())
    }
}
