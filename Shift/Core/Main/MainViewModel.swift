//
//  SignUpViewModel.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import Foundation

@MainActor
final class MainViewModel {

    private let userStorageManager = UserStorageManager.shared

    func getUser() throws -> User {
        try userStorageManager.get()
    }
}
