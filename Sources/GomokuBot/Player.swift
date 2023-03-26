//
//  Player.swift
//  Gomoku
//
//  Created by Robert on 25/03/2023.
//

import Foundation
import Combine

public protocol PlayerDelegate: AnyObject {
    func playerMakeMove(move: Move) async
    func playerMakeFailedMove(id: PlayerIdentifier, error: MoveError) async
}

public protocol Player: Identifiable where ID == PlayerIdentifier {
    var delegate: PlayerDelegate? { get set }

    func opponentMoved(_ move: Move, board: Board) async throws
}

extension Player {
    public func opponentMoved(_ move: Move, board: Board) async throws {}
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

public protocol Human: Player {
    func markMove(row: Int, column: Int) async
}

extension Human {
    public func markMove(row: Int, column: Int) async {
        await delegate?.playerMakeMove(move: Move(row: row, column: column, playerID: id))
    }
}
