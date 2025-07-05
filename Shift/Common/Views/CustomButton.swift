//
//  CustomButton.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import SnapKit
import UIKit

final class CustomButton: UIButton {

    enum ButtonVariant {
        case primary
        case ok
        case cancel
    }

    private var variant: ButtonVariant
    private let BUTTON_HEIGHT: CGFloat = 44

    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }

    init(title: String, variant: ButtonVariant) {
        self.variant = variant

        super.init(frame: .zero)

        self.layer.cornerRadius = BUTTON_HEIGHT / 2
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.lightGray, for: .disabled)
        self.isEnabled = true

        self.snp.makeConstraints { make in
            make.height.equalTo(BUTTON_HEIGHT)
        }
    }

    @available(
        *,
        unavailable,
        message: "This initializer is not available. Use init(title:) instead."
    )
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateAppearance() {
        guard isEnabled else {
            backgroundColor = .gray
            return
        }

        switch variant {
        case .primary:
            backgroundColor = .customBlue
        case .ok:
            backgroundColor = .customGreen
        case .cancel:
            backgroundColor = .customRed
        }
    }
}
