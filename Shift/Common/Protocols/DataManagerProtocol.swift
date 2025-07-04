//
//  DataManagerProtocol.swift
//  Shift
//
//  Created by Роман on 04.07.2025.
//

@MainActor
protocol DataManagerProtocol {
    func insert(_ object: Any) throws

    func fetch(_ request: Any) throws -> [Any]
}
