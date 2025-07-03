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

        let container = createContainer()
        view.addSubview(container)

        container.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        let screenTitleLabel = createScreenTitleLabel()
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

        let fieldsStackView = createFieldStackView()
        scrollView.addSubview(fieldsStackView)

        fieldsStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
}

// MARK: - UI components implementation

extension SignUpViewController {

    private func createFieldStackView() -> UIStackView {
        return createStackView(
            spacing: 28,
            items: [
                createNameTextFieldStackView(),
                createSurnameTextFieldStackView(),
                createDateOfBirthTextFieldStackView(),
                createPasswordTextFieldStackView(),
                createConfirmPasswordTextFieldStackView(),
            ]
        )
    }

    private func createScreenTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Регистрация"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        
        return label
    }

    private func createErrorLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .red
        label.numberOfLines = 0

        return label
    }

    private func createNameTextFieldStackView() -> UIStackView {
        let stackView = createStackView(spacing: 8)

        nameTextField = createTextField(
            placeholder: "Имя",
            textContentType: .name
        )

        nameTextFieldErrorLabel = createErrorLabel(text: "")
        nameTextFieldErrorLabel.isHidden = false

        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(nameTextFieldErrorLabel)

        return stackView
    }

    private func createSurnameTextFieldStackView() -> UIStackView {
        let stackView = createStackView(spacing: 8)

        surnameTextField = createTextField(
            placeholder: "Фамилия",
            textContentType: .familyName
        )

        surnameTextFieldErrorLabel = createErrorLabel(text: "")
        surnameTextFieldErrorLabel.isHidden = false

        stackView.addArrangedSubview(surnameTextField)
        stackView.addArrangedSubview(surnameTextFieldErrorLabel)

        return stackView
    }

    private func createDateOfBirthTextFieldStackView() -> UIStackView {
        let stackView = createStackView(spacing: 8)

        dateOfBirthTextField = createTextField(
            placeholder: "Дата рождения",
            textContentType: nil
        )

        dateOfBirthTextField.setDatePickerAsInputViewFor(
            target: self,
            selector: #selector(dateSelected)
        )

        dateOfBirthTextFieldErrorLabel = createErrorLabel(text: "")
        dateOfBirthTextFieldErrorLabel.isHidden = false

        stackView.addArrangedSubview(dateOfBirthTextField)
        stackView.addArrangedSubview(dateOfBirthTextFieldErrorLabel)

        return stackView
    }

    private func createPasswordTextFieldStackView() -> UIStackView {
        let stackView = createStackView(spacing: 8)

        passwordTextField = createTextField(
            placeholder: "Пароль",
            textContentType: .password,
            autoCapitalization: .none,
            autocorrectionType: .no,
            isSecure: true
        )

        passwordTextFieldErrorLabel = createErrorLabel(text: "")
        passwordTextFieldErrorLabel.isHidden = false

        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordTextFieldErrorLabel)

        return stackView
    }

    private func createConfirmPasswordTextFieldStackView() -> UIStackView {
        let stackView = createStackView(spacing: 8)

        confirmPasswordTextField = createTextField(
            placeholder: "Подтвердите пароль",
            textContentType: .password,
            autoCapitalization: .none,
            autocorrectionType: .no,
            returnKeyType: .done,
            isSecure: true
        )

        confirmPasswordTextFieldErrorLabel = createErrorLabel(text: "")
        confirmPasswordTextFieldErrorLabel.isHidden = false

        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(confirmPasswordTextFieldErrorLabel)

        return stackView
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
        guard
            let nameValue = nameTextField.text, !nameValue.isEmpty,
            let surnameValue = surnameTextField.text, !surnameValue.isEmpty,
            let dateOfBirthValue = dateOfBirthTextField.text, !dateOfBirthValue.isEmpty,
            let passwordValue = passwordTextField.text, !passwordValue.isEmpty,
            let confirmPasswordValue = confirmPasswordTextField.text, !confirmPasswordValue.isEmpty
        else {
            return
        }

        nameTextFieldErrorLabel.text = validator.validateNameTextField(name: nameValue)
        nameTextFieldErrorLabel.isHidden = false

        surnameTextFieldErrorLabel.text = validator.validateSurnameTextField(surname: surnameValue)
        surnameTextFieldErrorLabel.isHidden = false

        dateOfBirthTextFieldErrorLabel.text = validator.validateDateOfBirthTextField(
            dateOfBirth: dateOfBirthValue
        )

        dateOfBirthTextFieldErrorLabel.isHidden = false

        passwordTextFieldErrorLabel.text = validator.validatePasswordValidTextField(
            password: passwordValue
        )

        passwordTextFieldErrorLabel.isHidden = false

        confirmPasswordTextFieldErrorLabel.text = validator.validateConfirmPasswordValid(
            password: passwordValue,
            confirmPassword: confirmPasswordValue
        )

        confirmPasswordTextFieldErrorLabel.isHidden = false
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

    private func createContainer() -> UIView {
        let container = UIView()
        let verticalSpacing: CGFloat = 20
        let horizontalSpacing: CGFloat = 16

        container.layoutMargins = UIEdgeInsets(
            top: verticalSpacing,
            left: horizontalSpacing,
            bottom: verticalSpacing,
            right: horizontalSpacing
        )

        return container
    }

    private func createStackView(spacing: CGFloat, items: [UIView] = []) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: items)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = spacing

        return stackView
    }

    private func createTextField(
        placeholder: String,
        textContentType: UITextContentType?,
        autoCapitalization: UITextAutocapitalizationType = .words,
        autocorrectionType: UITextAutocorrectionType = .yes,
        keyboardType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .next,
        isSecure: Bool = false
    ) -> UITextField {
        let textField = UITextField()

        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.red.cgColor
        textField.backgroundColor = .white

        textField.font = UIFont.systemFont(ofSize: 18)
        textField.autocapitalizationType = autoCapitalization
        textField.autocorrectionType = autocorrectionType
        textField.textContentType = isSecure ? .none : textContentType
        textField.textColor = .black

        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ]
        )

        textField.clearButtonMode = .always
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.isSecureTextEntry = isSecure

        textField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }

        return textField
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
