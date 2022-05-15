//
//  Extensions.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/03/27.
//

import Foundation
import UIKit

extension CALayer {
    /// Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}

/// label에 사람 모양에다 파티원 넣는 경우에 쓰는거. "참가자.png" 참고하면 이해가 빠름.
extension UILabel {
    func setImageInLabelText(image: String, text: String) {
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: image.description + ".png")
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 13, height: 13)

        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: text))

        self.attributedText = attributedString
        self.sizeToFit()
    }
}

/// 탭바 그림자.
extension UITabBar {
    // 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

/// 버튼 cornerradius를 우측 메뉴에서 조정할 수 있게해줌.
@IBDesignable extension UIButton {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
