//
//  SignUpViewModel.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import Foundation

@MainActor
final class MainViewModel {

    private let productNetworkManager = ProductNetworkManager.shared

    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        productNetworkManager.getProducts { result in
            switch result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
