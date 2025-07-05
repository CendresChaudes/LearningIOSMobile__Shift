//
//  MainViewController.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import SnapKit
import UIKit

final class MainViewController: UIViewController {

    private var viewModel: MainViewModel!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()

        setupUI()
    }

    // MARK: - Setup view model

    private func setupViewModel() {
        viewModel = MainViewModel()
    }
}

// MARK: - Setup UI

extension MainViewController {

    private func setupUI() {
        view.backgroundColor = .systemBackground

        let container = CustomScreenContainerView()
        view.addSubview(container)

        container.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        let productsTableView = createProductsTable()

        let screenTitleLabel = CustomScreenTitleLabel(title: "Главный экран")
        container.addSubview(screenTitleLabel)

        screenTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(container.layoutMarginsGuide.snp.top)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        let greetingButton = createGreetingButton()
        container.addSubview(greetingButton)

        greetingButton.snp.makeConstraints { make in
            make.bottom.equalTo(container.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }
    }

    // MARK: - UI components impls

    private func createProductsTable() {
        viewModel.getProducts { [unowned self] result in
            switch result {
            case .success(let products):
                print(products)
            case .failure:
                self.showAlert(
                    title: "Ошибка",
                    message: "Не удалось загрузить товары. Попробуйте еще раз"
                )
            }
        }
    }

    private func createGreetingButton() -> UIButton {
        let button = CustomButton(
            title: "Приветствие"
        )

        button.addTarget(
            self,
            action: #selector(handleGreetingButtonTouchedUpInside),
            for: .touchUpInside
        )

        return button
    }

    @objc
    private func handleGreetingButtonTouchedUpInside() {
        do {
            let user = try viewModel.getUser()
            openGreetingModal(for: user.name)
        } catch {
            showAlert(
                title: "Ошибка",
                message: "Не удалось загрузить данные. Попробуйте еще раз"
            )
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
}

// MARK: - Navigation

extension MainViewController {

    private func openGreetingModal(for userName: String) {
        let greetingVC = GreetingViewController()
        greetingVC.modalPresentationStyle = .pageSheet
        greetingVC.userName = userName
        present(greetingVC, animated: true)
    }
}
