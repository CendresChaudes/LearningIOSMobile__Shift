//
//  CustomScreenTitle.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import UIKit

final class CustomScreenTitleLabel: UILabel {

    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .customRed

        return view
    }()

    init(title: String) {
        super.init(frame: .zero)

        self.text = title
        self.font = .systemFont(ofSize: 32, weight: .bold)
        self.textColor = .black
        self.textAlignment = .center

        self.addSubview(underlineView)
    }

    @available(
        *,
        unavailable,
        message: "This initializer is not available. Use init(title:) instead."
    )
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let OFFSET: CGFloat = 50

        underlineView.frame = CGRect(
            x: OFFSET,
            y: self.bounds.height + 5,
            width: self.bounds.width - OFFSET * 2,
            height: 6
        )
    }
}
