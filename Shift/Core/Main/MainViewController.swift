//
//  MainViewController.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import SnapKit
import UIKit

final class MainViewController: UIViewController {

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
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

    }
}
