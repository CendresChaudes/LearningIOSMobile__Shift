//
//  CustomContainer.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import UIKit

class CustomScreenContainerView: UIView {

    private let verticalSpacing: CGFloat = 20
    private let horizontalSpacing: CGFloat = 16

    init() {
        super.init(frame: .zero)

        self.layoutMargins = UIEdgeInsets(
            top: verticalSpacing,
            left: horizontalSpacing,
            bottom: verticalSpacing,
            right: horizontalSpacing
        )
    }

    @available(
        *,
        unavailable,
        message: "This initializer is not available. Use init() instead."
    )
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
