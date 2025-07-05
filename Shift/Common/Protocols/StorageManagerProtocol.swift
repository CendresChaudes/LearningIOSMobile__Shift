//
//  DataManagerProtocol.swift
//  Shift
//
//  Created by Роман on 04.07.2025.
//

@MainActor
protocol StorageManagerProtocol {

    static var shared: Self { get }

    func insert<T>(_ object: T) throws

    func fetch<T>(_ request: Any) throws -> [T]?
}
