//
//  SignUpViewController.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import SnapKit
import UIKit

final class SignUpViewController: UIViewController {

    private var viewModel: SignUpViewModel!

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

    private var isFieldsValid: Bool {
        nameTextFieldErrorLabel.text == nil && surnameTextFieldErrorLabel.text == nil
            && dateOfBirthTextFieldErrorLabel.text == nil && passwordTextFieldErrorLabel.text == nil
            && confirmPasswordTextFieldErrorLabel.text == nil
    }

    private let validator = SignUpValidator.self

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()

        setupUI()
        setupTextFieldDelegates()
        setupViewTapGesture()

        setupDebug()
    }

    // MARK: - Setup view model

    private func setupViewModel() {
        viewModel = SignUpViewModel()
    }

    // MARK: - Setup debug

    private func setupDebug() {
        #if DEBUG
            setupFieldsValuesForDebug()
        #endif
    }
}

// MARK: - Setup UI

extension SignUpViewController {

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
    
    // MARK: - UI components impls
    
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
        stackView.spacing = 32

        return stackView
    }

    private func createNameTextFieldStackView() -> UIStackView {
        nameTextField = CustomTextField(
            placeholder: "Имя",
        )

        nameTextField.delegate = self
        nameTextField.returnKeyType = .next
        nameTextField.textContentType = .name

        nameTextFieldErrorLabel = CustomErrorLabel()
        nameTextFieldErrorLabel.isHidden = true

        return createFieldStackView(for: [nameTextField, nameTextFieldErrorLabel])
    }

    private func createSurnameTextFieldStackView() -> UIStackView {
        surnameTextField = CustomTextField(
            placeholder: "Фамилия",
        )

        surnameTextField.delegate = self
        surnameTextField.returnKeyType = .next
        surnameTextField.textContentType = .familyName

        surnameTextFieldErrorLabel = CustomErrorLabel()
        surnameTextFieldErrorLabel.isHidden = true

        return createFieldStackView(for: [surnameTextField, surnameTextFieldErrorLabel])
    }

    private func createDateOfBirthTextFieldStackView() -> UIStackView {
        dateOfBirthTextField = CustomTextField(
            placeholder: "Дата рождения",
        )

        dateOfBirthTextField.textContentType = nil

        dateOfBirthTextField.setDatePickerAsInputViewFor(
            target: self,
            selector: #selector(dateSelected)
        )

        dateOfBirthTextFieldErrorLabel = CustomErrorLabel()
        dateOfBirthTextFieldErrorLabel.isHidden = true

        return createFieldStackView(for: [dateOfBirthTextField, dateOfBirthTextFieldErrorLabel])
    }

    @objc
    private func dateSelected() {
        guard
            let field = dateOfBirthTextField,
            let datePicker = field.inputView as? UIDatePicker
        else { return }

        print(datePicker.date)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        field.text = dateFormatter.string(from: datePicker.date)
        field.resignFirstResponder()
    }

    private func createPasswordTextFieldStackView() -> UIStackView {
        passwordTextField = CustomTextField(
            placeholder: "Пароль"
        )

        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .next
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true

        passwordTextFieldErrorLabel = CustomErrorLabel()
        passwordTextFieldErrorLabel.isHidden = true

        return createFieldStackView(for: [passwordTextField, passwordTextFieldErrorLabel])
    }

    private func createConfirmPasswordTextFieldStackView() -> UIStackView {
        confirmPasswordTextField = CustomTextField(
            placeholder: "Подтвердите пароль",
        )

        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.returnKeyType = .done
        confirmPasswordTextField.textContentType = .password
        confirmPasswordTextField.isSecureTextEntry = true

        confirmPasswordTextFieldErrorLabel = CustomErrorLabel()
        confirmPasswordTextFieldErrorLabel.isHidden = true

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

        if isFieldsValid {
            guard let name = nameTextField.text,
                let surname = surnameTextField.text,
                let dateOfBirth = dateOfBirthTextField.text,
                let password = passwordTextField.text
            else { return }

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateStyle = .medium

            guard let dateOfBirthIso = dateFormatter.date(from: dateOfBirth) else { return }

            do {
                try viewModel.saveUser(
                    name: name,
                    surname: surname,
                    dateOfBirth: dateOfBirthIso,
                    password: password
                )

                openMainScreen()
            } catch {
                showAlert(
                    title: "Ошибка",
                    message: "Не удалось сохранить данные. Попробуйте еще раз"
                )
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "Закрыть", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    // MARK: - UI components bases
    
    private func createFieldStackView(for arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8

        return stackView
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
            let passwordValue = passwordTextField.text, !passwordValue.isEmpty,
            let confirmPasswordValue = confirmPasswordTextField.text, !confirmPasswordValue.isEmpty
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

// MARK: - Gestures

extension SignUpViewController {

    private func setupViewTapGesture() {
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        )
    }

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Navigation

extension SignUpViewController {

    private func openMainScreen() {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            surnameTextField.becomeFirstResponder()
        } else if textField == surnameTextField {
            dateOfBirthTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else {
            confirmPasswordTextField.resignFirstResponder()
        }

        return true
    }
}

// MARK: - Debug

extension SignUpViewController {

    func setupFieldsValuesForDebug() {
        nameTextField.text = "Роман"
        surnameTextField.text = "Пронин"
        dateOfBirthTextField.text = "20 марта 1997 г."
        passwordTextField.text = "qwertyQ1!"
        confirmPasswordTextField.text = "qwertyQ1!"

        textFieldDidChange()
    }
}
