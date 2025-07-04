//
//  UserStorageManager.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import UIKit

@MainActor
final class UserStorageManager {
    static let shared = UserStorageManager()

    private let dataManager = CoreDataManager.shared

    private init() {}

    func save(name: String, surname: String, dateOfBirth: Date, password: String) throws {
        let user = User(context: dataManager.context)
        user.name = name
        user.surname = surname
        user.dateOfBirth = dateOfBirth
        user.password = password

        try dataManager.insert(user)
    }

    func get() throws -> User {
        do {
            let fetchRequest = User.fetchRequest()
            let user = try dataManager.fetch(fetchRequest).last

            guard let user else {
                throw NSError(
                    domain: "UserStorageManager",
                    code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "Response must be exist"]
                )
            }

            return user as! User
        } catch {
            throw error
        }
    }
}
