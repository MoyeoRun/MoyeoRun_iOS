//
//  ToastMessage.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import Foundation
import UIKit

struct GlobalFunc {
    static func showToast(view: UIView, message : String) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
