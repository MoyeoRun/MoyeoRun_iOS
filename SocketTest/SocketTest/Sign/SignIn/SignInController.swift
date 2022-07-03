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
    

    @IBAction func clickComplete(_ sender: Any) {
        let request: SignInRequest = SignInRequest(userId: idText, password: pwdText, email: emailText)
        let repository: SignInRepository = SignInRepository()
        
        repository.inquirySignIn(request: request) { result in
            switch result {
            case .success(let response):
                print(response)
            case . failure(let error):
                print(error)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
