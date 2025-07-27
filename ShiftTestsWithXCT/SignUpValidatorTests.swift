//
//  ShiftTestsWithXCT.swift
//  ShiftTestsWithXCT
//
//  Created by Роман on 27.07.2025.
//

import XCTest

@testable import Shift

final class SignUpValidatorTests: XCTestCase {

    private var sut: SignUpValidator.Type!

    override func setUpWithError() throws {
        sut = SignUpValidator.self
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - validateNameTextField

    func testNameLengthLessThanTwoSymbolsShouldReturnErrorMessage() {
        let name = String(repeating: "a", count: 1)
        let result = sut.validateNameTextField(name: name)
        let expect = "Имя должно содержать не менее 2 символов"

        XCTAssertEqual(result, expect)
    }

    func testNameLengthEqualToTwoSymbolsShouldReturnNil() {
        let name = String(repeating: "a", count: 2)
        let result = sut.validateNameTextField(name: name)
        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testNameLengthEqualToTwentySymbolsShouldReturnNil() {
        let name = String(repeating: "a", count: 20)
        let result = sut.validateNameTextField(name: name)
        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testNameLengthMoreThanTwentySymbolsShouldReturnErrorMessage() {
        let name = String(repeating: "a", count: 21)
        let result = sut.validateNameTextField(name: name)
        let expect = "Имя должно содержать не более 20 символов"

        XCTAssertEqual(result, expect)
    }

    func testNameContainOnlyLettersAndSpacesShouldReturnNil() {
        let name = String(repeating: "a", count: 10)
        let result = sut.validateNameTextField(name: name)
        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testNameNotContainOnlyLettersAndSpacesShouldReturnErrorMessage() {
        let name = String(repeating: "a", count: 10) + "1!"
        let result = sut.validateNameTextField(name: name)
        let expect = "Имя должно содержать только буквы и пробелы"

        XCTAssertEqual(result, expect)
    }

    // MARK: - validateSurnameTextField

    func testSurnameLengthLessThanTwoSymbolsShouldReturnErrorMessage() {
        let surname = String(repeating: "a", count: 1)
        let result = sut.validateSurnameTextField(surname: surname)
        let expect = "Фамилия должна содержать не менее 2 символов"

        XCTAssertEqual(result, expect)
    }

    func testSurnameLengthEqualToTwoSymbolsShouldReturnNil() {
        let surname = String(repeating: "a", count: 2)
        let result = sut.validateSurnameTextField(surname: surname)
        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testSurnameLengthEqualToThirtySymbolsShouldReturnNil() {
        let surname = String(repeating: "a", count: 30)
        let result = sut.validateSurnameTextField(surname: surname)
        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testSurnameLengthMoreThanThirtySymbolsShouldReturnErrorMessage() {
        let surname = String(repeating: "a", count: 31)
        let result = sut.validateSurnameTextField(surname: surname)
        let expect = "Фамилия должна содержать не более 30 символов"

        XCTAssertEqual(result, expect)
    }

    func testSurnameContainOnlyLettersAndSpacesShouldReturnNil() {
        let surname = String(repeating: "a", count: 10)
        let result = sut.validateSurnameTextField(surname: surname)
        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testSurnameNotContainOnlyLettersAndSpacesShouldReturnErrorMessage() {
        let surname = String(repeating: "a", count: 10) + "1!"
        let result = sut.validateSurnameTextField(surname: surname)
        let expect = "Фамилия должна содержать только буквы и пробелы"

        XCTAssertEqual(result, expect)
    }

    // MARK: - validateDateOfBirthTextField

    func testDateOfBirthLessThanEighteenShouldReturnErrorMessage() {
        let dateOfBirth = dateWithYearsOffset(17)
        let result = sut.validateDateOfBirthTextField(dateOfBirth: dateOfBirth)
        let expect = "Вам должно быть не меньше 18 лет"

        XCTAssertEqual(result, expect)
    }

    func testDateOfBirthEqualToEighteenShouldReturnNil() {
        let dateOfBirth = dateWithYearsOffset(18)
        let result = sut.validateDateOfBirthTextField(dateOfBirth: dateOfBirth)
        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testDateOfBirthEqualToOneHundredThirtyShouldReturnNil() {
        let dateOfBirth = dateWithYearsOffset(130)
        let result = sut.validateDateOfBirthTextField(dateOfBirth: dateOfBirth)
        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testDateOfBirthMoreThanOneHundredThirtyShouldReturnErrorMessage() {
        let dateOfBirth = dateWithYearsOffset(131)
        let result = sut.validateDateOfBirthTextField(dateOfBirth: dateOfBirth)
        let expect = "Вы не можете быть старше 130 лет"

        XCTAssertEqual(result, expect)
    }

    func testInvalidDateFormatShouldReturnErrorMessage() {
        let dateOfBirth = "01-01-2000"
        let result = sut.validateDateOfBirthTextField(dateOfBirth: dateOfBirth)
        let expect = "Некорректный формат даты. Выберите дату из календаря"

        XCTAssertEqual(result, expect)
    }

    private func dateWithYearsOffset(_ years: Int) -> String {
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

    // MARK: - validatePasswordTextField

    func testCorrectPasswordShouldReturnNil() {
        let password = "Password1!"
        let result = sut.validatePasswordTextField(password: password)
        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testPasswordLengthLessThanEightSymbolsShouldReturnErrorMessage() {
        let password = String(repeating: "a", count: 7)
        let result = sut.validatePasswordTextField(password: password)
        let expect = "Пароль должен содержать не менее 8 символов"

        XCTAssertEqual(result, expect)
    }

    func testPasswordLengthMoreThanThirtySymbolsShouldReturnErrorMessage() {
        let password = String(repeating: "a", count: 31)
        let result = sut.validatePasswordTextField(password: password)
        let expect = "Пароль должен содержать не более 30 символов"

        XCTAssertEqual(result, expect)
    }

    func testPasswordShouldContainAtLeastOneUppercaseReturnErrorMessage() {
        let password = "password1!"
        let result = sut.validatePasswordTextField(password: password)
        let expect =
            "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"

        XCTAssertEqual(result, expect)
    }

    func testPasswordShouldContainAtLeastOneLowercaseReturnErrorMessage() {
        let password = "PASSWORD1!"
        let result = sut.validatePasswordTextField(password: password)
        let expect =
            "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"

        XCTAssertEqual(result, expect)
    }

    func testPasswordShouldContainAtLeastOneDigitReturnErrorMessage() {
        let password = "Password!"
        let result = sut.validatePasswordTextField(password: password)
        let expect =
            "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"

        XCTAssertEqual(result, expect)
    }

    func testPasswordShouldContainAtLeastOneSpecialCharacterReturnErrorMessage() {
        let password = "Password1"
        let result = sut.validatePasswordTextField(password: password)
        let expect =
            "Пароль должен содержать хотя бы одну заглавную букву, одну строчную букву, одну цифру и один специальный символ"

        XCTAssertEqual(result, expect)
    }

    // MARK: - validateConfirmPasswordTextField

    func testConfirmPasswordEqualToPasswordShouldReturnNil() {
        let password = "Password1!"
        let confirmPassword = "Password1!"

        let result = sut.validateConfirmPasswordTextField(
            password: password,
            confirmPassword: confirmPassword
        )

        let expect: String? = nil

        XCTAssertEqual(result, expect)
    }

    func testConfirmPasswordNotEqualToPasswordShouldReturnErrorMessage() {
        let password = "Password1!"
        let confirmPassword = "Password12345!"

        let result = sut.validateConfirmPasswordTextField(
            password: password,
            confirmPassword: confirmPassword
        )

        let expect = "Пароли не совпадают"

        XCTAssertEqual(result, expect)
    }
}
