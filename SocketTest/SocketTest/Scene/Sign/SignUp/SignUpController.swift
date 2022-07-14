//
//  SignUpController.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var pwdTextField: UITextField!
    @IBOutlet var completeButton: UIButton!
    
    var emailText: String = ""
    var pwdText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func inputText(_ sender: UITextField) {
        if sender == emailTextField {
            emailText = sender.text!
        } else {
            pwdText = sender.text!
        }
    }
    
    func getUserData() {
        let request: UserRequest = UserRequest(accessToken: UserDefaults.standard.string(forKey: "accessToken")!)
        let repository: UserRepository = UserRepository()
        
        repository.inquiryUser(request: request) { result in
            switch result {
            case .success(let response):
                UserDefaults.standard.set(response.memberId, forKey: "memberId")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func requestLogin() -> Bool {
        let request: SignUpRequest = SignUpRequest(email: emailText, password: pwdText)
        let repository: SignUpRepository = SignUpRepository()
        
        var isSuccess: Bool = true
        
        repository.inquirySignUp(request: request) { result in
            switch result {
            case .success(let response):
                UserDefaults.standard.set(response.accessToken, forKey: "accessToken")
                self.getUserData()
            case .failure(_):
                isSuccess = false
                GlobalFunc.showToast(view: self.view, message: "로그인에 실패하였습니다.")
            }
        }
        return isSuccess
    }
    
    func presentController () {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "home")
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true)
    }
    
    @IBAction func clickComplete(_ sender: Any) {
        if requestLogin() {
            presentController()
        } else {
            print("로그인 실패")
        }
    }
}
