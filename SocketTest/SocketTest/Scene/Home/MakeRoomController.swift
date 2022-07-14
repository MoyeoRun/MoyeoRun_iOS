//
//  MakeRoomController.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import UIKit

class MakeRoomController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    
    var nameText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func inputName(_ sender: Any) {
        nameText = nameTextField.text!
    }
    
    @IBAction func clickComplete(_ sender: Any) {
        let request: CreateRoomRequest = CreateRoomRequest(accessToken: UserDefaults.standard.string(forKey: "accessToken")!, name: nameText)
        let repository: RoomRepository = RoomRepository()
        
        repository.inquiryCreateRoom(request: request) { result in
            switch result {
            case .success(let response):
                print(response)
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
}
