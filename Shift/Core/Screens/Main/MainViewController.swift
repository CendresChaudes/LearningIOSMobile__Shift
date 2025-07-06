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
    private var productsLoadingSpinner: UIActivityIndicatorView!

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

        setupUI()

        setupViewModel()
        loadProducts()
    }

    // MARK: - Setup view model

    private func setupViewModel() {
        viewModel = MainViewModel()
    }

    private func loadProducts() {
        showProductsLoadingSpinner()

        viewModel.getProducts { [unowned self] result in
            switch result {
            case .success(let products):
                self.products = products
                dismissProductsLoadingSpinner()
            case .failure:
                self.showAlert(
                    title: "Ошибка",
                    message: "Не удалось загрузить товары. Попробуйте еще раз"
                )

                dismissProductsLoadingSpinner()
            }
        }
    }
}

// MARK: - Setup UI

extension MainViewController {

    private func setupUI() {
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

        let productsTableViewContainer = UIView()
        container.addSubview(productsTableViewContainer)

        productsTableViewContainer.snp.makeConstraints { make in
            make.top.equalTo(screenTitleLabel.snp.bottom).offset(40)
            make.bottom.equalTo(greetingButton.snp.top).offset(-40)
            make.leading.equalTo(container.layoutMarginsGuide.snp.leading)
            make.trailing.equalTo(container.layoutMarginsGuide.snp.trailing)
        }

        productsTableView = createProductsViewTable()
        productsTableViewContainer.addSubview(productsTableView)

        productsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        productsLoadingSpinner = CustomSpinner()
        productsTableViewContainer.addSubview(productsLoadingSpinner)

        productsLoadingSpinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - UI components impls

    private func createProductsViewTable() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.sectionHeaderTopPadding = 0

        tableView.register(
            ProductsTableViewCell.self,
            forCellReuseIdentifier: PRODUCTS_TABLE_VIEW_CELL
        )

        return tableView
    }

    private func createGreetingButton() -> UIButton {
        let button = CustomButton(
            title: "Приветствие",
            variant: .primary
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
        openGreetingModal()
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

    private func showProductsLoadingSpinner() {
        productsLoadingSpinner.startAnimating()
        productsTableView.layer.opacity = 0.3
    }

    private func dismissProductsLoadingSpinner() {
        productsLoadingSpinner.stopAnimating()
        productsTableView.layer.opacity = 1
    }
}

// MARK: - Navigation

extension MainViewController {

    private func openGreetingModal() {
        let greetingVC = GreetingViewController()
        greetingVC.modalPresentationStyle = .pageSheet
        present(greetingVC, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ProductsTableViewHeader()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
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

        cell.set(with: products[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
