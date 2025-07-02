//
//  UITextField+DatePicker.swift
//  Shift
//
//  Created by Роман on 02.07.2025.
//

import SnapKit
import UIKit

extension UITextField {

    func setDatePickerAsInputViewFor(target: Any, selector: Selector) {
        let datePicker = UIDatePicker()
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker

        let toolBar = UIToolbar()

        toolBar.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width)
        }

        let cancel = UIBarButtonItem(
            title: "Отменить",
            style: .plain,
            target: self,
            action: #selector(tapCancel)
        )

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let done = UIBarButtonItem(
            title: "Подтвердить",
            style: .done,
            target: nil,
            action: selector
        )

        toolBar.setItems([cancel, flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolBar
    }

    @objc
    func tapCancel() {
        self.resignFirstResponder()
    }
}
