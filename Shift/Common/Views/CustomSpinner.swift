//
//  CustomSpinner.swift
//  Shift
//
//  Created by Роман on 05.07.2025.
//

import UIKit

final class CustomSpinner: UIActivityIndicatorView {

    init() {
        super.init(frame: .zero)

        self.style = .large
        self.color = .magenta
        self.hidesWhenStopped = true
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
