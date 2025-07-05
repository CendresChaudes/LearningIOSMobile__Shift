//
//  NetworkManager.swift
//  Shift
//
//  Created by Роман on 05.07.2025.
//

import Alamofire
import Foundation

@MainActor
final class NetworkManager {

    private init() {}
}

// MARK: - NetworkManagerProtocol

extension NetworkManager: NetworkManagerProtocol {

    static let shared = NetworkManager()

    func execute<T>(
        url: URL,
        method: HTTPMethod,
        completion: @escaping (Result<T, Error>) -> Void
    ) where T: Codable & Sendable {
        AF
            .request(url, method: AlamofireAdapter.getHTTPMethod(from: method))
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
