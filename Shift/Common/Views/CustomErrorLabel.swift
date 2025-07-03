//
//  CustomErrorLabel.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import UIKit

class CustomErrorLabel: UILabel {

    init(text: String? = "") {
        super.init(frame: .zero)

        self.text = text
        self.font = .systemFont(ofSize: 16, weight: .regular)
        self.textColor = .red
        self.numberOfLines = 0
    }

    @available(
        *,
        unavailable,
        message: "This initializer is not available. Use init(text:) instead."
    )
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
