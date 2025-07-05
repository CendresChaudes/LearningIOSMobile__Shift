//
//  CustomScreenTitle.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import UIKit

final class CustomParagraphLabel: UILabel {

    init(
        text: String,
        fontSize: CGFloat,
        textColor: UIColor = .black,
        fontWeight: UIFont.Weight = .regular
    ) {
        super.init(frame: .zero)

        self.text = text
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor
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
