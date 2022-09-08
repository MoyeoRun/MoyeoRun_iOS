//
//  AppIntroViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/04/26.
//

import UIKit

class AppIntroViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTapStartButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "SocialLogIn", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SocialLogIn")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}
