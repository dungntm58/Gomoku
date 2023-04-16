//
//  LegacyStateObject.swift
//  Gomoku
//
//  Created by Robert on 16/04/2023.
//

import Combine
import SwiftUI

@available(iOS, obsoleted: 14)
@available(macOS, obsoleted: 11)
@propertyWrapper struct LegacyStateObject<Wrapped>: DynamicProperty where Wrapped: ObservableObject {
    private final class Wrapper: ObservableObject {
        private var subject = PassthroughSubject<Void, Never>()

        var value: Wrapped? {
            didSet {
                cancellable = nil
                cancellable = value?.objectWillChange
                    .sink { [subject] _ in subject.send() }
            }
        }

        private var cancellable: AnyCancellable?

        var objectWillChange: AnyPublisher<Void, Never> {
            subject.eraseToAnyPublisher()
        }
    }

    @State private var state = Wrapper()

    @ObservedObject private var observedObject = Wrapper()

    private var thunk: () -> Wrapped

    public var wrappedValue: Wrapped {
        if let object = state.value {
            return object
        } else {
            let object = thunk()
            state.value = object
            return object
        }
    }

    public var projectedValue: ObservedObject<Wrapped>.Wrapper {
        ObservedObject(wrappedValue: wrappedValue).projectedValue
    }

    public init(wrappedValue thunk: @autoclosure @escaping () -> Wrapped) {
        self.thunk = thunk
    }

    public mutating func update() {
        if state.value == nil {
            state.value = thunk()
        }
        if observedObject.value !== state.value {
            observedObject.value = state.value
        }
    }
}
