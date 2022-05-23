//
//  SearchTabExtension.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/19.
//

import UIKit

extension CALayer {
    func addUnderLine(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.frame = CGRect.init(
            x: frame.width * 0.1, y: frame.height - width, width: frame.width * 0.8, height: width
        )
        border.backgroundColor = color.cgColor
        border.name = "underLine"
        // layer name 지어주기
        self.addSublayer(border)
    }

    func removeUnderLine() {
        self.sublayers?.forEach({ layer in
            if layer.name == "underLine" {
                layer.removeFromSuperlayer()
            }
        })
    }

    func addBorder(_ arrEdge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arrEdge {
            let border = CALayer()
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
        default:
            break
        }
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
        }
    }
}
