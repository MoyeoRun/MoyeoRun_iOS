//
//  SocialLogInViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/04/26.
//

import UIKit

class SocialLogInViewController: UIViewController {
    @IBOutlet weak var signInWithGoogleButton: UIButton!
    @IBOutlet weak var appleSymbolImageView: UIImageView!

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
        let storyBoard = UIStoryboard(name: "InsertUserInfo", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "InsertUserInfo")
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true)
    }
}
