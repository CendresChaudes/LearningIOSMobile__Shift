//
//  ProductNetworkManager.swift
//  Shift
//
//  Created by Роман on 05.07.2025.
//

import Foundation

@MainActor
final class ProductNetworkManager {

    static let shared = ProductNetworkManager()

    private let networkManager = NetworkManager.shared

    private init() {}

    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        networkManager.execute(
            url: URL(string: "https://fakestoreapi.com/products")!,
            method: .get
        ) { (result: Result<[Product], Error>) in
            switch result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
