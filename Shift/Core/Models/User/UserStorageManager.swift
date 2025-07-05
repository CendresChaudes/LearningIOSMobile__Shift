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

        #if DEBUG
            logData(user, action: "Save")
        #endif

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

            #if DEBUG
                logData(user, action: "Get")
            #endif

            return user
        } catch {
            #if DEBUG
                logError(error)
            #endif

            throw error
        }
    }
}

// MARK: - Setup debug

#if DEBUG
    extension UserStorageManager {

        func logData(_ data: User, action: String) {
            print("[UserStorageManager/\(action)] - Data: \(data)")
        }

        func logError(_ error: Error) {
            print("[UserStorageManager] - Error: \(error)")
        }
    }
#endif
