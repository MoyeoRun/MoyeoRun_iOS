//
//  SignController.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import UIKit

class SignController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickSignIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "signIn")
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true)
    }
    
    @IBAction func clickSignUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "signUp")
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true)
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
