//
//  UITextFieldExtension.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UITextField {
    var isEmpty: Bool {
        return (self.text?.isEmpty)! || self.text! == String(repeating: " ", count: self.text!.count)
    }
    
     func setPlaceHolderColor(color : UIColor){
        self.attributedPlaceholder = NSAttributedString(string:(self.placeholder ?? "").localized, attributes: [NSAttributedString.Key.foregroundColor: color])

       }
}

extension UITextField {
    private func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    private func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    @IBInspectable var leftPadding: CGFloat {
        set {
            setLeftPaddingPoints(newValue)
        } get {
            if let view = leftView {
                return view.frame.width
            }
            return 0
        }
    }
    @IBInspectable var rightPadding: CGFloat {
        set {
            setRightPaddingPoints(newValue)
        } get {
            if let view = rightView {
                return view.frame.width
            }
            return 0
        }
    }
}



