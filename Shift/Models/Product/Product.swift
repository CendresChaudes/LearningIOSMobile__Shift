//
//  Book.swift
//  Shift
//
//  Created by Роман on 05.07.2025.
//

import Foundation

struct Product: Codable {

    var id: Int
    var title: String
    var price: Double
    var rating: Rating
}

struct Rating: Codable {

    var rate: Double
    var count: Int
}
