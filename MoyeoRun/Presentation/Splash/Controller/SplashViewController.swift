//
//  SplashViewController.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/31.
//

import UIKit

class SplashViewController: UIViewController {
    private let repository: AuthRepositable

    init?(coder: NSCoder, repository: AuthRepositable = AuthRepository()) {
        self.repository = repository

        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        repository.getAccessToken { result in
            let initialViewController: UIViewController

            switch result {
            case .success:
                let viewController: MainTabBarController = .instantiate(container: .tabBar)
                initialViewController = viewController
            case .failure:
                let viewController: AuthViewController = .instantiate(container: .none)
                initialViewController = viewController
            }

            self.present(initialViewController, animated: true)
        }
    }
}
