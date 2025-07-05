//
//  GreetingModal.swift
//  Shift
//
//  Created by Роман on 04.07.2025.
//

import UIKit

final class GreetingViewController: UIViewController {

    private var greetingLabel: UILabel!
    private var userLoadingSpinner: UIActivityIndicatorView!

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
        do {
            showUserLoadingSpinner()
            let user = try viewModel.getUser()
            userName = user.name
            dismissUserLoadingSpinner()
        } catch {
            dismissUserLoadingSpinner()

            showAlert(
                title: "Ошибка",
                message: "Не удалось загрузить данные. Попробуйте еще раз"
            )
        }
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

        let container = CustomScreenContainerView()
        view.addSubview(container)

        container.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        let screenTitleLabel = CustomScreenTitleLabel(title: "Приветствие")
        container.addSubview(screenTitleLabel)

        screenTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(container.layoutMarginsGuide.snp.top)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        let buttonsStackView = createButtonsStackView()
        container.addSubview(buttonsStackView)

        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(container.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        let greetingLabelContainerView = UIView()
        container.addSubview(greetingLabelContainerView)

        greetingLabelContainerView.snp.makeConstraints { make in
            make.top.equalTo(screenTitleLabel.snp.bottom).offset(50)
            make.bottom.equalTo(buttonsStackView.snp.top).offset(-40)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        greetingLabel = CustomParagraphLabel(text: "", fontSize: 24)
        setGreetingLabelText()
        greetingLabelContainerView.addSubview(greetingLabel)

        greetingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(greetingLabelContainerView)
            make.centerY.equalTo(greetingLabelContainerView)
        }

        userLoadingSpinner = CustomSpinner()
        greetingLabelContainerView.addSubview(userLoadingSpinner)

        userLoadingSpinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
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

    private func showUserLoadingSpinner() {
        userLoadingSpinner.startAnimating()
        greetingLabel.layer.opacity = 0.3
    }

    private func dismissUserLoadingSpinner() {
        userLoadingSpinner.stopAnimating()
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
