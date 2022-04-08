//
//  DateTextField.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class DateTextField: UITextField {
    
    // MARK: - Variables
    @IBInspectable var format: String = "yyyy-MM-dd"
    var datePicker = UIDatePicker()
    var date: Date! {
        didSet {
            text = date.string(format: format)
        }
    }
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.locale = Locale.init(identifier: Language.currentLanguage.rawValue)
        inputView = datePicker
        datePicker.addTarget(self, action: #selector(didSelectDate(_:)), for: .valueChanged)
        if !format.contains("HH") || !format.contains("mm") {
            datePicker.datePickerMode = .date
        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }

    @objc private func didSelectDate(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    
}

