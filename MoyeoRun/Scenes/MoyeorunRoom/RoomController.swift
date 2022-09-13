//
//  RoomController.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/09/04.
//

import UIKit

class RoomController: UIViewController {
    @IBOutlet var roomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.configureRoomView()
        }
        // Do any additional setup after loading the view.
    }
   
    private func configureRoomView() {
        if let customView = Bundle.main.loadNibNamed("AfterRoom", owner: nil, options: nil)?.first as? UIView {
            customView.frame = self.roomView.bounds
            roomView.addSubview(customView)
            self.roomView = customView
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
