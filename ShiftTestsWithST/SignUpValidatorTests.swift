//
//  SignUpValidator.swift
//  ShiftTestsWithST
//
//  Created by Роман on 06.07.2025.
//

import Foundation
import Testing

@testable import Shift

struct SignUpValidatorTests {

    // MARK: - validateNameTextField

    @Suite("Method: validateNameTextField")
    private struct ValidateNameTextField {

        private let smut = SignUpValidator.self.validateNameTextField

        @Test
        func nameLengthLessThanTwoSymbolsShouldReturnErrorMessage() {
            let name = String(repeating: "a", count: 1)
            let result = smut(name)
            let expect = "Имя должно содержать не менее 2 символов"

            #expect(result == expect)
        }

        @Test
        func nameLengthEqualToTwoSymbolsShouldReturnNil() {
            let name = String(repeating: "a", count: 2)
            let result = smut(name)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func nameLengthEqualToTwentySymbolsShouldReturnNil() {
            let name = String(repeating: "a", count: 20)
            let result = smut(name)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func nameLengthMoreThanTwentySymbolsShouldReturnErrorMessage() {
            let name = String(repeating: "a", count: 21)
            let result = smut(name)
            let expect = "Имя должно содержать не более 20 символов"

            #expect(result == expect)
        }

        @Test
        func nameContainOnlyLettersAndSpacesShouldReturnNil() {
            let name = String(repeating: "a", count: 10)
            let result = smut(name)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func nameNotContainOnlyLettersAndSpacesShouldReturnErrorMessage() {
            let name = String(repeating: "a", count: 10) + "1!"
            let result = smut(name)
            let expect = "Имя должно содержать только буквы и пробелы"

            #expect(result == expect)
        }
    }

    // MARK: - validateSurnameTextField

    @Suite("Method: validateSurnameTextField")
    struct ValidateSurnameTextField {

        private let smut = SignUpValidator.self.validateSurnameTextField

        @Test
        func surnameLengthLessThanTwoSymbolsShouldReturnErrorMessage() {
            let surname = String(repeating: "a", count: 1)
            let result = smut(surname)
            let expect = "Фамилия должна содержать не менее 2 символов"

            #expect(result == expect)
        }

        @Test
        func surnameLengthEqualToTwoSymbolsShouldReturnNil() {
            let surname = String(repeating: "a", count: 2)
            let result = smut(surname)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func surnameLengthEqualToThirtySymbolsShouldReturnNil() {
            let surname = String(repeating: "a", count: 30)
            let result = smut(surname)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func surnameLengthMoreThanThirtySymbolsShouldReturnErrorMessage() {
            let surname = String(repeating: "a", count: 31)
            let result = smut(surname)
            let expect = "Фамилия должна содержать не более 30 символов"

            #expect(result == expect)
        }

        @Test
        func surnameContainOnlyLettersAndSpacesShouldReturnNil() {
            let surname = String(repeating: "a", count: 10)
            let result = smut(surname)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func surnameNotContainOnlyLettersAndSpacesShouldReturnErrorMessage() {
            let surname = String(repeating: "a", count: 10) + "1!"
            let result = smut(surname)
            let expect = "Фамилия должна содержать только буквы и пробелы"

            #expect(result == expect)
        }
    }

    // MARK: - validateDateOfBirthTextField

    @Suite("Method: validateDateOfBirthTextField")
    struct ValidateDateOfBirthTextField {

        private let smut = SignUpValidator.self.validateDateOfBirthTextField

        @Test
        func dateOfBirthLessThanEighteenShouldReturnErrorMessageMessage() {
            let dateOfBirth = dateWithYearsOffset(17)
            let result = smut(dateOfBirth)
            let expect = "Вам должно быть не меньше 18 лет"

            #expect(result == expect)
        }

        @Test
        func dateOfBirthEqualToEighteenShouldReturnNil() {
            let dateOfBirth = dateWithYearsOffset(18)
            let result = smut(dateOfBirth)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func dateOfBirthEqualToOneHundredThirtyShouldReturnNil() {
            let dateOfBirth = dateWithYearsOffset(130)
            let result = smut(dateOfBirth)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func dateOfBirthMoreThanOneHundredThirtyShouldReturnErrorMessage() {
            let dateOfBirth = dateWithYearsOffset(131)
            let result = smut(dateOfBirth)
            let expect = "Вы не можете быть старше 130 лет"

            #expect(result == expect)
        }

        @Test
        func invalidDateFormatShouldReturnErrorMessage() {
            let dateOfBirth = "01-01-2000"
            let result = smut(dateOfBirth)
            let expect = "Некорректный формат даты. Выберите дату из календаря"

            #expect(result == expect)
        }

        func dateWithYearsOffset(_ years: Int) -> String {
            let currentDate = Date()
            
            var dateComponents = Calendar.current.dateComponents(
                [.day, .month, .year],
                from: currentDate
            )
            
            dateComponents.year = (dateComponents.year ?? 0) - years

            guard let newDate = Calendar.current.date(from: dateComponents) else {
                return ""
            }

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateStyle = .medium

            return dateFormatter.string(from: newDate)
        }
    }

    // MARK: - validatePasswordTextField

    @Suite("Method: validatePasswordTextField")
    struct ValidatePasswordTextField {

        private let smut = SignUpValidator.self.validatePasswordTextField

        @Test
        func correctPasswordShouldReturnNil() {
            let password = "Password1!"
            let result = smut(password)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func passwordLengthLessThanEightSymbolsShouldReturnErrorMessage() {
            let password = String(repeating: "a", count: 7)
            let result = smut(password)
            let expect = "Пароль должен содержать не менее 8 символов"

            #expect(result == expect)
        }

        @Test
        func passwordLengthMoreThanThirtySymbolsShouldReturnErrorMessage() {
            let password = String(repeating: "a", count: 31)
            let result = smut(password)
            let expect = "Пароль должен содержать не более 30 символов"

            #expect(result == expect)
        }

        @Test
        func passwordShouldContainAtLeastOneUppercaseReturnErrorMessage() {
            let password = "password1!"
            let result = smut(password)
            let expect =
                "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"

            #expect(result == expect)
        }

        @Test
        func passwordShouldContainAtLeastOneLowercaseReturnErrorMessage() {
            let password = "PASSWORD1!"
            let result = smut(password)
            let expect =
                "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"

            #expect(result == expect)
        }

        @Test
        func passwordShouldContainAtLeastOneDigitReturnErrorMessage() {
            let password = "Password!"
            let result = smut(password)
            let expect =
                "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"

            #expect(result == expect)
        }

        @Test
        func passwordShouldContainAtLeastOneSpecialCharacterReturnErrorMessage() {
            let password = "Password1"
            let result = smut(password)
            let expect =
                "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"

            #expect(result == expect)
        }
    }

    // MARK: - validateConfirmPasswordTextField

    @Suite("Method: validateConfirmPasswordTextField")
    struct ValidateConfirmPasswordTextField {

        private let smut = SignUpValidator.self.validateConfirmPasswordTextField

        @Test
        func confirmPasswordEqualToPasswordShouldReturnNil() {
            let password = "Password1!"
            let confirmPassword = "Password1!"
            let result = smut(password, confirmPassword)
            let expect: String? = nil

            #expect(result == expect)
        }

        @Test
        func confirmPasswordNotEqualToPasswordShouldReturnErrorMessage() {
            let password = "Password1!"
            let confirmPassword = "Password12345!"
            let result = smut(password, confirmPassword)
            let expect = "Пароли не совпадают"

            #expect(result == expect)
        }
    }
}
