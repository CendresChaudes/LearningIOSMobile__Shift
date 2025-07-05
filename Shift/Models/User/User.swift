//
//  User.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import CoreData
import Foundation

@objc(User)
final class User: NSManagedObject {}

extension User {

    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var surname: String
    @NSManaged var dateOfBirth: Date
    @NSManaged var password: String

    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
