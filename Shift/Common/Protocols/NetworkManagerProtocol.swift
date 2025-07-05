//
//  NetworkManagerProtocol.swift
//  Shift
//
//  Created by Роман on 05.07.2025.
//

import Foundation

@MainActor
protocol NetworkManagerProtocol {

    static var shared: Self { get }

    func execute<T: Codable & Sendable>(
        url: URL,
        method: HTTPMethod,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

enum HTTPMethod: String {
    case post = "POST"

    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"

    case put = "PUT"
    case patch = "PATCH"

    case delete = "DELETE"

    case trace = "TRACE"
    case connect = "CONNECT"
}
