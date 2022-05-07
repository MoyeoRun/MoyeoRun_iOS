//
//  SignUpCompleteViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/07.
//

import UIKit

class SignUpCompleteViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTapStartButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "HomeTab", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "HomeTab")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}
