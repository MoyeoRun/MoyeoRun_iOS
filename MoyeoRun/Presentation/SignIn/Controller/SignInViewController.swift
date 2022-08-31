//
//  SignInViewController.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/31.
//

import GoogleSignIn
import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var signInWithGoogleButton: UIButton!
    @IBOutlet weak var appleSymbolImageView: UIImageView!

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

        setUI()
    }

    func setUI() {
        setSignInWithGoogleButton()

        func setSignInWithAppleButton() {
            appleSymbolImageView.layer.cornerRadius = 4
        }
        func setSignInWithGoogleButton() {
        }
    }

    @IBAction func onTapSignInWithAppleButton(_ sender: Any) {
    }

    @IBAction func onTapSignInWithGoogleButton(_ sender: Any) {
        let signInConfig = GIDConfiguration(
            clientID: Configuration.clientId.toString,
            serverClientID: Configuration.serverClientId.toString
        )

        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { [weak self] user, error in
            guard
                error == nil,
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }

            let request = SignInRequest(idToken: idToken, providerType: .google)

            self?.signIn(with: request)
        }
    }

    private func signIn(with request: SignInRequest) {
        repository.signIn(request: request) { [weak self] result in
            let nextViewController: UIViewController

            switch result {
            case .success:
                let viewController: MainTabBarController = .instantiate(container: .tabBar)
                nextViewController = viewController
            case .failure:
                let viewController: SignUpViewController = .instantiate { coder in
                    SignUpViewController(coder: coder, credential: request, repository: AuthRepository())
                }
                nextViewController = viewController
            }

            DispatchQueue.main.async {
                self?.present(nextViewController, animated: true)
            }
        }
    }
}
