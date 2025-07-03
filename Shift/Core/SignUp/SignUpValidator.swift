//
//  SignUpValidation.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import Foundation

final class SignUpValidator {

    private static let onlyLettersAndSpacesRegex = "^[A-Za-zА-Яа-яЁё\\s]+$"

    private static let passwordRegex =
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]+$"

    static func validateNameTextField(name: String) -> String? {
        let trimmedValue = trimWhitespaces(from: name)

        let regex = onlyLettersAndSpacesRegex
        let predicate = createPredicate(for: regex)
        let isValidByRegex = predicate.evaluate(with: trimmedValue)

        let minLength = 2
        let maxLength = 20

        var errorMessage: String?

        if trimmedValue.count < minLength {
            errorMessage = "Имя должно содержать не менее \(minLength) символов"
        } else if trimmedValue.count > maxLength {
            errorMessage = "Имя должно содержать не более \(maxLength) символов"
        } else if !isValidByRegex {
            errorMessage = "Имя должно содержать только буквы и пробелы"
        } else {
            errorMessage = nil
        }

        return errorMessage
    }

    static func validateSurnameTextField(surname: String) -> String? {
        let trimmedValue = trimWhitespaces(from: surname)

        let regex = onlyLettersAndSpacesRegex
        let predicate = createPredicate(for: regex)
        let isValidByRegex = predicate.evaluate(with: trimmedValue)

        let minLength = 2
        let maxLength = 30

        var errorMessage: String?

        if trimmedValue.count < minLength {
            errorMessage = "Фамилия должна содержать не менее \(minLength) символов"
        } else if trimmedValue.count > maxLength {
            errorMessage = "Фамилия должна содержать не более \(maxLength) символов"
        } else if !isValidByRegex {
            errorMessage = "Фамилия должна содержать только буквы и пробелы"
        } else {
            errorMessage = nil
        }

        return errorMessage
    }

    static func validateDateOfBirthTextField(dateOfBirth: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium

        guard let date = dateFormatter.date(from: dateOfBirth) else {
            return "Некорректный формат даты. Выберите дату из календаря"
        }

        let actualAge = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0

        let minAge = 18
        let maxAge = 130

        var errorMessage: String?

        switch actualAge {
        case ..<minAge:
            errorMessage = "Вам должно быть не меньше \(minAge) лет"
        case (maxAge + 1)...:
            errorMessage = "Вы не можете быть старше \(maxAge) лет"
        default:
            errorMessage = nil
        }

        return errorMessage
    }

    static func validatePasswordTextField(password: String) -> String? {
        let trimmedValue = trimWhitespaces(from: password)

        let regex = passwordRegex
        let predicate = createPredicate(for: regex)
        let isValidByRegex = predicate.evaluate(with: trimmedValue)

        let minLength = 8
        let maxLength = 30

        var errorMessage: String?

        if trimmedValue.count < minLength {
            errorMessage = "Пароль должен содержать не менее \(minLength) символов"
        } else if trimmedValue.count > maxLength {
            errorMessage = "Пароль должен содержать не более \(maxLength) символов"
        } else if !isValidByRegex {
            errorMessage =
                "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"
        } else {
            errorMessage = nil
        }

        return errorMessage
    }

    static func validateConfirmPasswordTextField(password: String, confirmPassword: String)
        -> String?
    {
        password == confirmPassword ? nil : "Пароли не совпадают"
    }

    private static func trimWhitespaces(from string: String) -> String {
        string.trimmingCharacters(in: .whitespaces)
    }

    private static func createPredicate(for regex: String) -> NSPredicate {
        NSPredicate(format: "SELF MATCHES %@", regex)
    }
}
