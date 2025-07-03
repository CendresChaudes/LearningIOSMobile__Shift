//
//  CustomButton.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import SnapKit
import UIKit

final class CustomButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }

    private let buttonHeight: CGFloat = 44

    init(title: String) {
        super.init(frame: .zero)

        self.layer.cornerRadius = buttonHeight / 2
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.lightGray, for: .disabled)

        self.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
        }
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
