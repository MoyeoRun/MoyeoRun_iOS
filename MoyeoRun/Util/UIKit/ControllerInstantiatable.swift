//
//  ControllerInstantiatable.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/31.
//

import UIKit

protocol ControllerInstantiatable {
    associatedtype Container

    static func instantiate<ViewController>(
        container: Container?,
        creator: ((NSCoder) -> ViewController?)?
    ) -> ViewController where ViewController: UIViewController
}

extension UIViewController: ControllerInstantiatable {
    enum Container: String {
        case navigation = "Navigation"
        case tabBar = "TabBar"
    }

    static func instantiate<ViewController>(
        container: Container? = nil,
        creator: ((NSCoder) -> ViewController?)? = nil
    ) -> ViewController where ViewController: UIViewController {
        let identifier = String(describing: ViewController.self)
        let controller = (container?.rawValue ?? "View") + "Controller"
        let name = identifier.replacingOccurrences(of: controller, with: "", options: [.backwards])
        let storyboard = UIStoryboard(name: name, bundle: .main)

        return storyboard.instantiateViewController(
            identifier: identifier,
            creator: creator
        )
    }
}
