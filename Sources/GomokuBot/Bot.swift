//
//  Bot.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import Foundation

public protocol Player: Identifiable where ID == PlayerIdentifier {
    func makeMove() async throws -> Move

    func opponentMoved(_ move: Move) async throws
}

public protocol Bot: Player {
    
}

public struct Move {
    public let row: Int
    public let column: Int
    public let playerID: PlayerIdentifier

    public init(row: Int, column: Int, playerID: PlayerIdentifier) {
        self.row = row
        self.column = column
        self.playerID = playerID
    }
}

public struct PlayerIdentifier: Hashable {
    public let `protocol`: String?
    public let host: String?
    public let port: Int?
    public let id: UInt

    public init(id: UInt) {
        self.`protocol` = nil
        self.host = nil
        self.port = nil
        self.id = id
    }

    public init(protocol: String, host: String, port: Int, id: UInt) {
        self.`protocol` = `protocol`
        self.host = host
        self.port = port
        self.id = id
    }

    public static var random: Self {
        .init(id: .random(in: UInt.min...UInt.max))
    }

    public var description: String {
        if let `protocol`, let host, let port {
            return "\(`protocol`)://\(host):\(port)#\(id)"
        }
        return "\(id)"
    }

    public var debugDescription: String {
        if let `protocol`, let host, let port {
            return "Self.self(\(`protocol`)://\(host):\(port)#\(description))"
        }
        return "\(Self.self)(\(description))"
    }
}
