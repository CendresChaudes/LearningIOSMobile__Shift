//
//  StorageManager.swift
//  Shift
//
//  Created by Роман on 04.07.2025.
//

import CoreData
import UIKit

@MainActor
final class StorageManager: NSObject {

    var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    private var appDelegate: AppDelegate {
        (UIApplication.shared.delegate as? AppDelegate)!
    }

    override private init() {}

    private func saveContext() throws {
        try appDelegate.saveContext()
    }
}

// MARK: - DataManagerProtocol

extension StorageManager: StorageManagerProtocol {

    static let shared = StorageManager()

    func insert<T>(_ object: T) throws {
        guard let managedObject = object as? NSManagedObject else {
            throw NSError(
                domain: "CoreDataManagerError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Object must be an NSManagedObject"]
            )
        }

        try context.performAndWait {
            context.insert(managedObject)
            try saveContext()
        }
    }

    func fetch<T>(_ request: Any) throws -> [T]? {
        guard let request = request as? NSFetchRequest<NSFetchRequestResult> else {
            throw NSError(
                domain: "CoreDataManagerError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Request must be NSFetchRequest"]
            )
        }

        return try context.fetch(request) as? [T]
    }
}
