//
//  SignInController.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/01.
//

import UIKit
import Moya

class SignInController: UIViewController {

    @IBOutlet var completeButton: UIButton!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwdTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    var idText: String = ""
    var pwdText: String = ""
    var emailText: String = ""
    
    @IBAction func inputText(_ sender: UITextField) {
        if sender == idTextField {
            idText = idTextField.text!
        } else if sender == pwdTextField {
            pwdText = pwdTextField.text!
        } else {
            emailText = emailTextField.text!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func popController() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickComplete(_ sender: Any) {
        let request: SignInRequest = SignInRequest(name: idText, password: pwdText, email: emailText)
        let repository: SignInRepository = SignInRepository()
        
        repository.inquirySignIn(request: request) { result in
            switch result {
            case .success(_):
                GlobalFunc.showToast(view: self.view, message: "회원가입에 성공하였습니다.")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.popController()
                }
            case . failure(_):
                GlobalFunc.showToast(view: self.view, message: "회원가입에 실패하였습니다.")
            }
        }
    }
}
