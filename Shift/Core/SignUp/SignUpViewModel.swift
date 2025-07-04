//
//  SignUpViewModel.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import CoreData
import Foundation

@MainActor
final class SignUpViewModel {
    private let userStorageManager = UserStorageManager.shared

    func saveUser(name: String, surname: String, dateOfBirth: Date, password: String) throws {
        try userStorageManager.save(
            name: name,
            surname: surname,
            dateOfBirth: dateOfBirth,
            password: password
        )
    }
}
