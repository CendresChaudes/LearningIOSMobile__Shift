//
//  CustomButton.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import UIKit

final class CustomButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }

    init(title: String, cornerRadius: CGFloat = 0, isEnabled: Bool = true) {
        super.init(frame: .zero)

        self.layer.cornerRadius = cornerRadius
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.lightGray, for: .disabled)
        self.isEnabled = isEnabled
    }

    @available(
        *,
        unavailable,
        message:
            "This initializer is not available. Use init(title:cornerRadius:isEnabled:) instead."
    )
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateAppearance() {
        self.backgroundColor = isEnabled ? .systemBlue : .gray
    }
}
