//
//  SplashViewController.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/31.
//

import UIKit

class SplashViewController: UIViewController {
    private let repository: AuthRepositable

    init?(coder: NSCoder, repository: AuthRepositable) {
        self.repository = repository

        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
    }

    private func commonInit() {
        repository.refreshToken { [weak self] result in
            let nextViewController: UIViewController

            switch result {
            case .success:
                let viewController: MainTabBarController = .instantiate(container: .tabBar)
                nextViewController = viewController
            case .failure:
                let viewController: SignInViewController = .instantiate { coder in
                    SignInViewController(coder: coder, repository: AuthRepository())
                }
                nextViewController = viewController
            }

            DispatchQueue.main.async {
                self?.present(nextViewController, animated: true)
            }
        }
    }
}
