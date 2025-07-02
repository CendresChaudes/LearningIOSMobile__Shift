//
//  SignUpValidation.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import Foundation

final class SignUpValidator {

    static func isNameValid(name: String) -> Bool {
        let nameRegex = "^\\w{2,20}$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValid = validateName.evaluate(with: trimmedString)

        return isValid
    }

    static func isSurnameValid(name: String) -> Bool {
        let nameRegex = "^\\w{2,30}$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValid = validateName.evaluate(with: trimmedString)

        return isValid
    }

    static func isDateOfBirthValid(dateOfBirth: String) -> Bool {
        print(dateOfBirth)
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.dateStyle = .medium
//
//        if let date = dateFormatter.date(from: dateOfBirth) {
//            return date <= Date()
//        }

        return false
    }

    static func isPasswordValid(password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        let isValid = validatePassord.evaluate(with: trimmedString)

        return isValid
    }

    static func isAcceptPasswordValid(password: String, confirmPassword: String) -> Bool {
        password == confirmPassword
    }
}
