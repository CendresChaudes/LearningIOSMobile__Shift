//
//  CoreDataManager.swift
//  Shift
//
//  Created by Роман on 04.07.2025.
//

import CoreData
import UIKit

@MainActor
final class CoreDataManager: NSObject {

    static let shared = CoreDataManager()

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

extension CoreDataManager: DataManagerProtocol {

    func insert(_ object: Any) throws {
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

    func fetch(_ request: Any) throws -> [Any] {
        guard let fetchRequest = request as? NSFetchRequest<NSFetchRequestResult> else {
            throw NSError(
                domain: "CoreDataManagerError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Request must be NSFetchRequest"]
            )
        }

        return try context.fetch(fetchRequest)
    }
}
