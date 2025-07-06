//
//  CustomScreenContainer.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import UIKit

final class CustomScreenContainer: UIView {

    private let VERTICAL_SPACING: CGFloat = 20
    private let HORIZONTAL_SPACING: CGFloat = 16

    init() {
        super.init(frame: .zero)

        self.layoutMargins = UIEdgeInsets(
            top: VERTICAL_SPACING,
            left: HORIZONTAL_SPACING,
            bottom: VERTICAL_SPACING,
            right: HORIZONTAL_SPACING
        )
    }

    @available(
        *,
        unavailable,
        message: "This initializer is not available. Use init() instead."
    )
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
