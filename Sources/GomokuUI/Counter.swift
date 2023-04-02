//
//  Counter.swift
//  Gomoku
//
//  Created by Robert on 02/04/2023.
//

import SwiftUI
import Foundation

struct Counter: View {

    @Binding
    var value: Int

    @ViewBuilder
    var body: some View {
        HStack {
            buildButton(systemImageName: "minus") {
                if value > 5 {
                    value -= 1
                }
            }
            buildTextField()
                .keyboardType(.numberPad)
                .frame(width: 40)
                .multilineTextAlignment(.center)
            buildButton(systemImageName: "plus") {
                value += 1
            }
        }
        .frame(height: 40)
    }

    @ViewBuilder
    func buildButton(systemImageName: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(40 / 3.5)
                .frame(width: 40, height: 40)
                .foregroundColor(Color(UIColor(red: 133 / 255.0, green: 133 / 255.0, blue: 133 / 255.0, alpha: 1)))
                .clipShape(Circle())
        }
        .buttonStyle(
            CounterButtonStyle(
                systemName: systemImageName,
                size: 40
            )
        )
    }

    @ViewBuilder
    func buildTextField() -> some View {
        if #available(iOS 15.0, *) {
            TextField("", value: $value, format: .number)
        } else {
            TextField("", text: Binding(get: {
                "\(value)"
            }, set: { text in
                guard let value = Int(text) else {
                    return
                }
                self.value = value
            }))
        }
    }
}

struct CounterButtonStyle: ButtonStyle {
    let systemName: String
    let size: CGFloat
    let padding: CGFloat

    let foregroundColor = UIColor(red: 43 / 255.0, green: 43 / 255.0, blue: 43 / 255.0, alpha: 1)

    init(systemName: String, size: CGFloat) {
        self.systemName = systemName
        self.size = size
        self.padding = size / 3.5
    }

    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                ZStack {
                    Image(systemName: systemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(padding)
                        .foregroundColor(configuration.isPressed ? .white : Color(foregroundColor))
                        .animation(.linear(duration: 0.1))
                }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color(foregroundColor))
                    .clipShape(Circle())
                    .opacity(configuration.isPressed ? 1 : 0)
                    .animation(.linear(duration: 0.1))
            )
            .font(.system(size: 60, weight: .thin, design: .rounded))
    }
}

struct Counter_Previews: PreviewProvider {
    static var value: Int = 0

    static var previews: some View {
        Counter(value: Binding(get: {
            value
        }, set: {
            value = $0
        }))
    }
}
