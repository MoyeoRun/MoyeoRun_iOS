//
//  InsettedTextField .swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/09/05.
//

import UIKit

@IBDesignable
class InsettedTextField: UITextField {
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0

    var insets: UIEdgeInsets {
        UIEdgeInsets(
            top: self.topInset,
            left: self.leftInset,
            bottom: self.bottomInset,
            right: self.rightInset
        )
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
}
