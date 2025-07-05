//
//  MainViewController.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import SnapKit
import UIKit

final class MainViewController: UIViewController {

    private var productsTableView: UITableView!

    private var viewModel: MainViewModel!

    private let PRODUCTS_TABLE_VIEW_CELL = "PRODUCTS_TABLE_VIEW_CELL"

    private var products: [Product] = [] {
        didSet {
            productsTableView.reloadData()
        }
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()

        setupUI()
    }

    // MARK: - Setup view model

    private func setupViewModel() {
        viewModel = MainViewModel()
        loadProducts()
    }

    private func loadProducts() {
        viewModel.getProducts { [unowned self] result in
            switch result {
            case .success(let products):
                self.products = products
            case .failure:
                self.showAlert(
                    title: "Ошибка",
                    message: "Не удалось загрузить товары. Попробуйте еще раз"
                )
            }
        }
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

        productsTableView = createProductsViewTable()
        view.addSubview(productsTableView)

        productsTableView.snp.makeConstraints { make in
            make.top.equalTo(screenTitleLabel.snp.bottom).offset(20)
            make.bottom.equalTo(greetingButton.snp.top).offset(-40)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }
    }

    // MARK: - UI components impls

    private func createProductsViewTable() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50

        tableView.register(
            ProductsTableViewCell.self,
            forCellReuseIdentifier: PRODUCTS_TABLE_VIEW_CELL
        )

        return tableView
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

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ProductsTableViewHeader()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: PRODUCTS_TABLE_VIEW_CELL, for: indexPath)
            as! ProductsTableViewCell

        let product = products[indexPath.row]
        cell.set(with: product)

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
