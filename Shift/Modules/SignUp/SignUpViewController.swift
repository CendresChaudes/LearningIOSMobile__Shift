//
//  SignUpViewController.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import SnapKit
import UIKit

final class SignUpViewController: UIViewController {

    private var dateOfBirthTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .white

        let container = createContainer()
        view.addSubview(container)

        container.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        let titleLabel = createTitleLabel(text: "Регистрация")
        container.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(container.layoutMarginsGuide.snp.top)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        let scrollView = UIScrollView()
        container.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.bottom.equalTo(container.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        let stackView = createStackView()
        scrollView.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        let nameTextField = createTextField(
            placeholder: "Имя",
            textContentType: .name
        )
        stackView.addArrangedSubview(nameTextField)

        let surnameTextField = createTextField(
            placeholder: "Фамилия",
            textContentType: .familyName
        )

        stackView.addArrangedSubview(surnameTextField)

        dateOfBirthTextField = createTextField(
            placeholder: "Дата рождения",
            textContentType: nil
        )

        dateOfBirthTextField?.setDatePickerAsInputViewFor(
            target: self,
            selector: #selector(dateSelected)
        )

        stackView.addArrangedSubview(dateOfBirthTextField!)

        let passwordTextField = createTextField(
            placeholder: "Пароль",
            textContentType: .password,
            autoCapitalization: .none,
            autocorrectionType: .no,
            isSecure: true
        )

        stackView.addArrangedSubview(passwordTextField)

        let acceptPasswordTextField = createTextField(
            placeholder: "Подтвердите пароль",
            textContentType: .password,
            autoCapitalization: .none,
            autocorrectionType: .no,
            returnKeyType: .done,
            isSecure: true
        )

        stackView.addArrangedSubview(acceptPasswordTextField)

        let buttonHeight: CGFloat = 40

        let signUpButton = createButton(
            title: "Зарегистрироваться",
            cornerRadius: buttonHeight / 2
        )

        container.addSubview(signUpButton)

        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.bottom.equalTo(container.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }
    }

}

// MARK: - UI components

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

    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20

        return stackView
    }

    private func createTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center

        return label
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

        textField.font = UIFont.systemFont(ofSize: 16)
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

        return textField
    }

    private func createButton(title: String, cornerRadius: CGFloat = 0) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = cornerRadius

        return button
    }

    @objc
    func dateSelected() {
        guard
            let field = self.dateOfBirthTextField,
            let datePicker = field.inputView as? UIDatePicker
        else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium

        field.text = dateFormatter.string(
            from: datePicker.date
        )

        field.resignFirstResponder()
    }
}
