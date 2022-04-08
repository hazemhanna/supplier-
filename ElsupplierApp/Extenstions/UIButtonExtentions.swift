//
//  UIButtonExtentions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UIButton {
    
    @IBInspectable public var isArabicFlip: Bool {
        set {
            if Language.isArabic {
                self.imageView?.flipHorizontal()
            }
        }
        get {
            return false
        }
    }
    
    @IBInspectable public var isEnglishFlip: Bool {
        set {
            if !Language.isArabic {
                self.imageView?.flipHorizontal()
            }
        }
        get {
            return false
        }
    }
    
}

class CustomDashedButton: UIButton {
    
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0

    var dashBorder: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
