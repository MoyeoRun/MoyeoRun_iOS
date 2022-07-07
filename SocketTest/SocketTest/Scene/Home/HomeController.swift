//
//  HomeController.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet var makeRoomButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func makeRoom(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        let pushVC = storyboard.instantiateViewController(withIdentifier: "makeRoomId")
        self.navigationController?.pushViewController(pushVC, animated: true)
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
