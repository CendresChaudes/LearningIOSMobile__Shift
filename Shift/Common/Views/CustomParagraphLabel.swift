//
//  CustomScreenTitle.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import UIKit

final class CustomParagraphLabel: UILabel {

    init(title: String) {
        super.init(frame: .zero)

        self.text = title
        self.font = .systemFont(ofSize: 24, weight: .regular)
        self.textColor = .black
    }

    @available(
        *,
        unavailable,
        message: "This initializer is not available. Use init(title:) instead."
    )
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
