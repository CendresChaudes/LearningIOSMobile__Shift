//
//  CustomParagraphLabel.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import UIKit

final class CustomParagraphLabel: UILabel {

    init(
        text: String,
        fontSize: CGFloat,
        fontWeight: UIFont.Weight = .regular,
        numberOfLines: Int = 0,
        textColor: UIColor = .black,
    ) {
        super.init(frame: .zero)

        self.text = text
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }

    @available(
        *,
        unavailable,
        message:
            "This initializer is not available. Use init(text:fontSize:textColor:fontWeight:) instead."
    )
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
