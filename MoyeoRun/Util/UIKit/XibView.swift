//
//  XibView.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/09/04.
//

import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension UIView: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol Loadable {
    static var nib: UINib { get }
}

extension UIView: Loadable {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
}

@IBDesignable
class XibView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    private func commonInit() {
        guard let view = loadViewFromNib() else { return }

        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func loadViewFromNib() -> UIView? {
        return Self.nib.instantiate(withOwner: self).first as? UIView
    }
}
