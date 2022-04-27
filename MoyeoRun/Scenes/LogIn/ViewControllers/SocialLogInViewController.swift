//
//  SocialLogInViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/04/26.
//

import UIKit

class SocialLogInViewController: UIViewController {

    @IBOutlet weak var SignInWithGoogleButton: UIButton!
    @IBOutlet weak var AppleSymbolImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
        setSignInWithGoogleButton()
        
        func setSignInWithAppleButton(){
            AppleSymbolImageView.layer.cornerRadius = 4
        }
        func setSignInWithGoogleButton(){
            let roboto = UIFont(name: "Roboto-Regular", size: 18)
            
            SignInWithGoogleButton.titleLabel?.font = roboto
        }
    }
}
