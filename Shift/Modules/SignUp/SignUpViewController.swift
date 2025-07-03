//
//  SignUpViewController.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import SnapKit
import UIKit

final class SignUpViewController: UIViewController {

    private var nameTextField: UITextField!
    private var surnameTextField: UITextField!
    private var dateOfBirthTextField: UITextField!
    private var passwordTextField: UITextField!
    private var confirmPasswordTextField: UITextField!

    private var signUpButton: UIButton!

    private var nameTextFieldErrorLabel: UILabel!
    private var surnameTextFieldErrorLabel: UILabel!
    private var dateOfBirthTextFieldErrorLabel: UILabel!
    private var passwordTextFieldErrorLabel: UILabel!
    private var confirmPasswordTextFieldErrorLabel: UILabel!

    private let validator = SignUpValidator.self

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldDelegates()
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .white

        let container = CustomScreenContainerView()
        view.addSubview(container)

        container.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        let screenTitleLabel = CustomScreenTitleLabel(title: "Регистрация")
        container.addSubview(screenTitleLabel)

        screenTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(container.layoutMarginsGuide.snp.top)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        signUpButton = createSignUpButton()
        container.addSubview(signUpButton)

        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(container.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        let scrollView = UIScrollView()
        container.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(screenTitleLabel.snp.bottom).offset(40)
            make.bottom.equalTo(signUpButton.snp.top).offset(-40)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        let fieldsStackView = createFieldsStackView()
        scrollView.addSubview(fieldsStackView)

        fieldsStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
}

// MARK: - UI components implementation

extension SignUpViewController {

    private func createFieldsStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            createNameTextFieldStackView(),
            createSurnameTextFieldStackView(),
            createDateOfBirthTextFieldStackView(),
            createPasswordTextFieldStackView(),
            createConfirmPasswordTextFieldStackView(),
        ])

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 28

        return stackView
    }

    private func createNameTextFieldStackView() -> UIStackView {
        nameTextField = CustomTextField(
            placeholder: "Имя",
        )

        nameTextField.textContentType = .name
        nameTextField.returnKeyType = .next

        nameTextFieldErrorLabel = CustomErrorLabel()
        nameTextFieldErrorLabel.isHidden = false

        return createFieldStackView(for: [nameTextField, nameTextFieldErrorLabel])
    }

    private func createSurnameTextFieldStackView() -> UIStackView {
        surnameTextField = CustomTextField(
            placeholder: "Фамилия",
        )

        surnameTextField.textContentType = .familyName
        surnameTextField.returnKeyType = .next

        surnameTextFieldErrorLabel = CustomErrorLabel()
        surnameTextFieldErrorLabel.isHidden = false

        return createFieldStackView(for: [surnameTextField, surnameTextFieldErrorLabel])
    }

    private func createDateOfBirthTextFieldStackView() -> UIStackView {
        dateOfBirthTextField = CustomTextField(
            placeholder: "Дата рождения",
        )

        dateOfBirthTextField.textContentType = nil
        dateOfBirthTextField.returnKeyType = .next

        dateOfBirthTextField.setDatePickerAsInputViewFor(
            target: self,
            selector: #selector(dateSelected)
        )

        dateOfBirthTextFieldErrorLabel = CustomErrorLabel()
        dateOfBirthTextFieldErrorLabel.isHidden = false

        return createFieldStackView(for: [dateOfBirthTextField, dateOfBirthTextFieldErrorLabel])
    }

    private func createPasswordTextFieldStackView() -> UIStackView {
        passwordTextField = CustomTextField(
            placeholder: "Пароль"
        )

        passwordTextField.textContentType = .password
        passwordTextField.returnKeyType = .next
        passwordTextField.isSecureTextEntry = true

        passwordTextFieldErrorLabel = CustomErrorLabel()
        passwordTextFieldErrorLabel.isHidden = false

        return createFieldStackView(for: [passwordTextField, passwordTextFieldErrorLabel])
    }

    private func createConfirmPasswordTextFieldStackView() -> UIStackView {
        confirmPasswordTextField = CustomTextField(
            placeholder: "Подтвердите пароль",
        )

        passwordTextField.textContentType = .password
        confirmPasswordTextField.returnKeyType = .done
        confirmPasswordTextField.isSecureTextEntry = true

        confirmPasswordTextFieldErrorLabel = CustomErrorLabel()
        confirmPasswordTextFieldErrorLabel.isHidden = false

        return createFieldStackView(for: [
            confirmPasswordTextField, confirmPasswordTextFieldErrorLabel,
        ])
    }

    private func createSignUpButton() -> UIButton {
        let button = CustomButton(
            title: "Зарегистрироваться"
        )

        button.isEnabled = false

        button.addTarget(
            self,
            action: #selector(handleSignUpButtonTouchedUpInside),
            for: .touchUpInside
        )

        return button
    }

    @objc
    private func handleSignUpButtonTouchedUpInside() {
        validateFields()
    }
}

// MARK: - Validation

extension SignUpViewController {

    private func validateFields() {
        validateNameTextField()
        validateSurnameTextField()
        validateDateOfBirthTextField()
        validatePasswordTextField()
        validateConfirmPasswordTextField()
    }

    private func validateNameTextField() {
        guard let nameValue = nameTextField.text, !nameValue.isEmpty else { return }

        nameTextFieldErrorLabel.text = validator.validateNameTextField(name: nameValue)
        nameTextFieldErrorLabel.isHidden = nameTextFieldErrorLabel.text == nil
    }

    private func validateSurnameTextField() {
        guard let surnameValue = surnameTextField.text, !surnameValue.isEmpty else { return }

        surnameTextFieldErrorLabel.text = validator.validateSurnameTextField(surname: surnameValue)
        surnameTextFieldErrorLabel.isHidden = surnameTextFieldErrorLabel.text == nil
    }

    private func validateDateOfBirthTextField() {
        guard let dateOfBirthValue = dateOfBirthTextField.text, !dateOfBirthValue.isEmpty else {
            return
        }

        dateOfBirthTextFieldErrorLabel.text = validator.validateDateOfBirthTextField(
            dateOfBirth: dateOfBirthValue
        )

        dateOfBirthTextFieldErrorLabel.isHidden = dateOfBirthTextFieldErrorLabel.text == nil
    }

    private func validatePasswordTextField() {
        guard let passwordValue = passwordTextField.text, !passwordValue.isEmpty else { return }

        passwordTextFieldErrorLabel.text = validator.validatePasswordTextField(
            password: passwordValue
        )

        passwordTextFieldErrorLabel.isHidden = passwordTextFieldErrorLabel.text == nil
    }

    private func validateConfirmPasswordTextField() {
        guard
            let passwordValue = surnameTextField.text, !passwordValue.isEmpty,
            let confirmPasswordValue = passwordTextField.text, !confirmPasswordValue.isEmpty
        else { return }

        confirmPasswordTextFieldErrorLabel.text = validator.validateConfirmPasswordTextField(
            password: passwordValue,
            confirmPassword: confirmPasswordValue
        )

        confirmPasswordTextFieldErrorLabel.isHidden = confirmPasswordTextFieldErrorLabel.text == nil
    }

    private func setupTextFieldDelegates() {
        [
            nameTextField,
            surnameTextField,
            dateOfBirthTextField,
            passwordTextField,
            confirmPasswordTextField,
        ].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }

    @objc
    private func textFieldDidChange() {
        if let nameValue = nameTextField.text, !nameValue.isEmpty,
            let surnameValue = surnameTextField.text, !surnameValue.isEmpty,
            let dateOfBirthValue = dateOfBirthTextField.text, !dateOfBirthValue.isEmpty,
            let passwordValue = passwordTextField.text, !passwordValue.isEmpty,
            let confirmPasswordValue = confirmPasswordTextField.text, !confirmPasswordValue.isEmpty
        {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
}

// MARK: - UI components bases

extension SignUpViewController {

    private func createFieldStackView(for arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8

        return stackView
    }

    @objc
    func dateSelected() {
        guard
            let field = dateOfBirthTextField,
            let datePicker = field.inputView as? UIDatePicker
        else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        field.text = dateFormatter.string(from: datePicker.date)
        field.resignFirstResponder()
    }
}
