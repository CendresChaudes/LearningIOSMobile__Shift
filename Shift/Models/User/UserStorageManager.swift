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
            let users: [User]? = try dataManager.fetch(fetchRequest)

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
