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
    
    func pushController() {
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        let pushVC = storyboard.instantiateViewController(withIdentifier: "homeId")
        
        let dismissCompletion = { () -> Void in
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = pushVC
        }
        self.view.window?.rootViewController?.dismiss(animated: true, completion: dismissCompletion)
    }
    
    @IBAction func clickComplete(_ sender: Any) {
        let request: SignUpRequest = SignUpRequest(email: emailText, password: pwdText)
        let repository: SignUpRepository = SignUpRepository()
        
        repository.inquirySignUp(request: request) { result in
            switch result {
            case .success(let response):
                UserDefaults.standard.set(response.accessToken, forKey: "accessToken")
                self.getUserData()
                self.pushController()
            case .failure(_):
                GlobalFunc.showToast(view: self.view, message: "로그인에 실패하였습니다.")
            }
        }
    }

}
