//
//  UserStorageManager.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import CoreData

@MainActor
final class UserStorageManager {

    static let shared = UserStorageManager()

    private let storageManager = StorageManager.shared

    private init() {}

    func save(name: String, surname: String, dateOfBirth: Date, password: String) throws {
        let user = User(context: storageManager.context)
        user.name = name
        user.surname = surname
        user.dateOfBirth = dateOfBirth
        user.password = password

        try storageManager.insert(user)
    }

    func get() throws -> User {
        do {
            let fetchRequest = User.fetchRequest()
            let users: [User]? = try storageManager.fetch(fetchRequest)

            guard let user = users?.last else {
                throw NSError(
                    domain: "UserStorageManager",
                    code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "Response must exist"]
                )
            }

            return user
        } catch {
            throw error
        }
    }
}
