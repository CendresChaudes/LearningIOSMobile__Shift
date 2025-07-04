//
//  GreetingModal.swift
//  Shift
//
//  Created by Роман on 04.07.2025.
//

import UIKit

final class GreetingViewController: UIViewController {

    var userName: String!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

// MARK: - Setup UI

extension GreetingViewController {

    private func setupUI() {
        view.backgroundColor = .systemBackground

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

        let greetingLabel = CustomParagraphLabel(title: "Привет, \(userName!)!")
        container.addSubview(greetingLabel)

        greetingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(container)
            make.centerY.equalTo(container)
        }

        let buttonsStackView = createButtonsStackView()
        container.addSubview(buttonsStackView)

        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(container.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }
    }

    // MARK: - UI components impls

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
            title: "Привет :)"
        )

        button.backgroundColor = .systemGreen

        button.addTarget(
            self,
            action: #selector(handleGreetingModalScreenDismiss),
            for: .touchUpInside
        )

        return button
    }

    private func createNotHelloButton() -> UIButton {
        let button = CustomButton(
            title: "Не привет :("
        )

        button.backgroundColor = .systemRed

        button.addTarget(
            self,
            action: #selector(handleGreetingModalScreenDismiss),
            for: .touchUpInside
        )

        return button
    }

    // MARK: - UI components bases

    private func createFieldStackView(for arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8

        return stackView
    }

    @objc
    private func handleGreetingModalScreenDismiss() {
        dismiss(animated: true)
    }
}
