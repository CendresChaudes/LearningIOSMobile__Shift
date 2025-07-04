//
//  AppDelegate.swift
//  Shift
//
//  Created by Роман on 01.07.2025.
//

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Core Data

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Shift")

        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            } else {
                #if DEBUG
                print("[Core Data] - Database url: \(description.url?.absoluteString)")
                #endif
            }
        }

        return container
    }()

    func saveContext() throws {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            try context.save()
        }
    }
}
