//
//  StartTimePopUpViewController.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/08/29.
//

import UIKit

class StartTimePopUpViewController: UIViewController {
    weak var dataDelegate: SendDataDelegate?

    override func viewDidLoad() {
    }

    @IBAction func cancelPopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selected(_ sender: Any) {
        //            let formatter = DateFormatter()
        //            formatter.dateStyle = .medium
        //            formatter.timeStyle = .none
        //            formatter.dateFormat = "a hh:mm"
        //            formatter.locale = Locale(identifier: "ko_KR")
        //            let temp = formatter.string(from: startTimePicker.date)
        //            self.dataDelegate?.sendStartTime(startTime: temp)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
