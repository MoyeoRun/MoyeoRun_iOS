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
        let sb = UIStoryboard(name: "SearchTab", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchTab")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
