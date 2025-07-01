//
//  ViewController.swift
//  Shift
//
//  Created by Роман on 01.07.2025.
//

import UIKit

class TestViewController: UIViewController {

    private weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
            self.view.backgroundColor = UIColor.white

            let label = UILabel()
            label.text = "Hello, World!"
            label.textColor = .green
            label.font = .systemFont(ofSize: 36)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(label)
            self.label = label

            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
}
