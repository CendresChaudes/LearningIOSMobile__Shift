//
//  CustomTextField.swift
//  Shift
//
//  Created by Роман on 03.07.2025.
//

import SnapKit
import UIKit

final class CustomTextField: UITextField {

    override var textContentType: UITextContentType! {
        didSet {
            if textContentType == UITextContentType.password
                || textContentType == UITextContentType.newPassword
            {
                self.autocapitalizationType = .none
                self.autocorrectionType = .no
            }
        }
    }

    init(placeholder: String, autocapitalizationType: UITextAutocapitalizationType = .words) {
        super.init(frame: .zero)

        self.borderStyle = .roundedRect
        self.backgroundColor = .white

        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ]
        )

        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = .yes
        self.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.textColor = .black

        self.clearButtonMode = .always

        self.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }

    @available(
        *,
        unavailable,
        message:
            "This initializer is not available. Use init(placeholder:autocapitalizationType:) instead."
    )
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
