//
//  SignUpValidation.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import Foundation

final class SignUpValidator {

    private static let ONLY_LETTERS_AND_SPACES_REGEX = "^[A-Za-zА-Яа-яЁё\\s]+$"

    static func validateNameTextField(name: String) -> String? {
        let trimmedValue = trimWhitespaces(from: name)
        let regex = ONLY_LETTERS_AND_SPACES_REGEX
        let predicate = createPredicate(for: regex)
        let isValidByRegex = predicate.evaluate(with: trimmedValue)

        let MIN_LENGTH = 2
        let MAX_LENGTH = 20

        var errorMessage: String?

        if trimmedValue.count < MIN_LENGTH {
            errorMessage = "Имя должно содержать не менее \(MIN_LENGTH) символов"
        } else if trimmedValue.count > MAX_LENGTH {
            errorMessage = "Имя должно содержать не более \(MAX_LENGTH) символов"
        } else if !isValidByRegex {
            errorMessage = "Имя должно содержать только буквы и пробелы"
        } else {
            errorMessage = nil
        }

        return errorMessage
    }

    static func validateSurnameTextField(surname: String) -> String? {
        let trimmedValue = trimWhitespaces(from: surname)
        let regex = ONLY_LETTERS_AND_SPACES_REGEX
        let predicate = createPredicate(for: regex)
        let isValidByRegex = predicate.evaluate(with: trimmedValue)

        let MIN_LENGTH = 2
        let MAX_LENGTH = 30

        var errorMessage: String?

        if trimmedValue.count < MIN_LENGTH {
            errorMessage = "Фамилия должна содержать не менее \(MIN_LENGTH) символов"
        } else if trimmedValue.count > MAX_LENGTH {
            errorMessage = "Фамилия должна содержать не более \(MAX_LENGTH) символов"
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

        let MIN_AGE = 18
        let MAX_AGE = 130
        let actualAge = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0

        var errorMessage: String?

        switch actualAge {
        case ..<MIN_AGE:
            errorMessage = "Вам должно быть не меньше \(MIN_AGE) лет"
        case (MAX_AGE + 1)...:
            errorMessage = "Вы не можете быть старше \(MAX_AGE) лет"
        default:
            errorMessage = nil
        }

        return errorMessage
    }

    static func validatePasswordTextField(password: String) -> String? {
        let PASSWORD_REGEX =
            "^(?=.*[a-zA-Zа-яА-Я])(?=.*[A-ZА-Я])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-zа-яА-Я\\d$@$!%*?&#]+$"

        let trimmedValue = trimWhitespaces(from: password)
        let regex = PASSWORD_REGEX
        let predicate = createPredicate(for: regex)
        let isValidByRegex = predicate.evaluate(with: trimmedValue)

        let MIN_LENGTH = 8
        let MAX_LENGTH = 30

        var errorMessage: String?

        if trimmedValue.count < MIN_LENGTH {
            errorMessage = "Пароль должен содержать не менее \(MIN_LENGTH) символов"
        } else if trimmedValue.count > MAX_LENGTH {
            errorMessage = "Пароль должен содержать не более \(MAX_LENGTH) символов"
        } else if !isValidByRegex {
            errorMessage =
                "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"
        } else {
            errorMessage = nil
        }

        return errorMessage
    }

    static func validateConfirmPasswordTextField(password: String, confirmPassword: String)
        -> String? {
        password == confirmPassword ? nil : "Пароли не совпадают"
    }

    private static func trimWhitespaces(from string: String) -> String {
        string.trimmingCharacters(in: .whitespaces)
    }

    private static func createPredicate(for regex: String) -> NSPredicate {
        NSPredicate(format: "SELF MATCHES %@", regex)
    }
}
