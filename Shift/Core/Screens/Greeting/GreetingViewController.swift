//
//  GreetingViewController.swift
//  Shift
//
//  Created by Роман on 04.07.2025.
//

import UIKit

final class GreetingViewController: UIViewController {

    private enum UserError: Error {
        case userMustExist
    }

    private var greetingLabel: UILabel!
    private var getUserLoadingSpinner: UIActivityIndicatorView!

    private var viewModel: GreetingViewModel!

    private var userName: String = "Неизвестный" {
        didSet {
            setGreetingLabelText()
        }
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        setupViewModel()
        loadUser()
    }

    // MARK: - Setup view model

    private func setupViewModel() {
        viewModel = GreetingViewModel()
    }

    private func loadUser() {
        showGetUserLoadingSpinner()

        do {
            guard let user = try viewModel.getUser() else { throw UserError.userMustExist }

            userName = user.name
        } catch {
            showAlert(
                title: "Ошибка",
                message: "Не удалось загрузить данные пользователя. Попробуйте еще раз"
            )
        }

        dismissGetUserLoadingSpinner()
    }
}

// MARK: - Setup UI

extension GreetingViewController {

    private func setupUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.customOrange.cgColor,
            UIColor.customBlueLight.cgColor,
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

        view?.layer.insertSublayer(gradientLayer, at: 0)

        let container = CustomScreenContainer()
        view.addSubview(container)

        container.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        let screenTitleLabel = CustomScreenTitleLabel(title: "Приветствие")
        container.addSubview(screenTitleLabel)

        screenTitleLabel.snp.makeConstraints {
            $0.top.equalTo(container.layoutMarginsGuide.snp.top)
            $0.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            $0.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        let buttonsStackView = createButtonsStackView()
        container.addSubview(buttonsStackView)

        buttonsStackView.snp.makeConstraints {
            $0.bottom.equalTo(container.layoutMarginsGuide.snp.bottom)
            $0.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            $0.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        let greetingLabelContainerView = UIView()
        container.addSubview(greetingLabelContainerView)

        greetingLabelContainerView.snp.makeConstraints {
            $0.top.equalTo(screenTitleLabel.snp.bottom).offset(50)
            $0.bottom.equalTo(buttonsStackView.snp.top).offset(-40)
            $0.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            $0.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        greetingLabel = CustomParagraphLabel(text: "", fontSize: 24)
        setGreetingLabelText()
        greetingLabelContainerView.addSubview(greetingLabel)

        greetingLabel.snp.makeConstraints {
            $0.centerX.equalTo(greetingLabelContainerView)
            $0.centerY.equalTo(greetingLabelContainerView)
        }

        getUserLoadingSpinner = CustomSpinner()
        greetingLabelContainerView.addSubview(getUserLoadingSpinner)

        getUserLoadingSpinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    // MARK: - UI components impls

    private func setGreetingLabelText() {
        greetingLabel.text = "Привет, \(userName)!"
    }

    private func createButtonsStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            createHelloButton(),
            createNotHelloButton(),
        ])

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 24

        return stackView
    }

    private func createHelloButton() -> UIButton {
        let button = CustomButton(
            title: "Привет :)",
            variant: .ok
        )

        button.addTarget(
            self,
            action: #selector(handleGreetingModalScreenDismiss),
            for: .touchUpInside
        )

        return button
    }

    private func createNotHelloButton() -> UIButton {
        let button = CustomButton(
            title: "Не привет :(",
            variant: .cancel
        )

        button.addTarget(
            self,
            action: #selector(handleGreetingModalScreenDismiss),
            for: .touchUpInside
        )

        return button
    }

    @objc
    private func handleGreetingModalScreenDismiss() {
        dismiss(animated: true)
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

    private func showGetUserLoadingSpinner() {
        getUserLoadingSpinner.startAnimating()
        greetingLabel.layer.opacity = 0.3
    }

    private func dismissGetUserLoadingSpinner() {
        getUserLoadingSpinner.stopAnimating()
        greetingLabel.layer.opacity = 1
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
