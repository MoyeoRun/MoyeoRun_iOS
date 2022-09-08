//
//  NicknameTextField.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/09/06.
//

import UIKit

class NicknameTextField: InsettedTextField {
    private let feedbackImagePadding: (top: CGFloat, right: CGFloat) = (1, 13)

    private var feedbackImageInsets: UIEdgeInsets {
        let rightInsetByRightView = feedbackImagePadding.right + (rightView?.frame.width ?? 0)

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightInsetByRightView)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.rightViewRect(forBounds: bounds)
        padding.origin.x -= feedbackImagePadding.right
        padding.origin.y -= feedbackImagePadding.top

        return padding
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds).inset(by: feedbackImageInsets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return super.placeholderRect(forBounds: bounds).inset(by: feedbackImageInsets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).inset(by: feedbackImageInsets)
    }
}
