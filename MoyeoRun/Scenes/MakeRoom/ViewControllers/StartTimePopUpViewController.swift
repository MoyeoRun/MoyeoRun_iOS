//
//  StartTimePopUpViewController.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/08/29.
//

import UIKit

class StartTimePopUpViewController: UIViewController {
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var tomorrowLabel: UILabel!
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var tomorrowDateLabel: UILabel!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var tomorrowView: UIView!
    weak var dataDelegate: SendDataDelegate?
    let formatter = DateFormatter()
    let todayDate = Date()
    var isToday = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        addEvent()
    }

    func setLabel() {
        guard let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: todayDate) else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        formatter.locale = Locale(identifier: "ko_KR")
        todayDateLabel.text = formatter.string(from: todayDate)
        tomorrowDateLabel.text = formatter.string(from: tomorrowDate)
    }

    func addEvent() {
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.clickedTodayView(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.clickedTomorrowView(_:)))
        todayView.addGestureRecognizer(tap1)
        tomorrowView.addGestureRecognizer(tap2)
    }

    @objc func clickedTodayView(_ sender: UITapGestureRecognizer) {
        isToday = true
        todayLabel.textColor = UIColor(hexString: "#1162FF")
        todayDateLabel.textColor = UIColor(hexString: "#1162FF")
        tomorrowLabel.textColor = UIColor(hexString: "#C4C4C4")
        tomorrowDateLabel.textColor = UIColor(hexString: "#C4C4C4")
    }

    @objc func clickedTomorrowView(_ sender: UITapGestureRecognizer) {
        isToday = false
        tomorrowLabel.textColor = UIColor(hexString: "#1162FF")
        tomorrowDateLabel.textColor = UIColor(hexString: "#1162FF")
        todayLabel.textColor = UIColor(hexString: "#C4C4C4")
        todayDateLabel.textColor = UIColor(hexString: "#C4C4C4")
    }

    @IBAction func changePicker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh : mm"
        formatter.locale = Locale(identifier: "ko_KR")
    }

    @IBAction func cancelPopUp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func selected(_ sender: UIButton) {
        guard
            let todayYear = Calendar.current.dateComponents([.year], from: todayDate).year,
            let todayDate = todayDateLabel.text,
            let tomorrowDate = tomorrowLabel.text
        else { return }
        let formatter = DateFormatter()
        if isToday {
            formatter.dateFormat = "\(todayYear) \(todayDate) a hh : mm"
        } else {
            formatter.dateFormat = "\(todayYear) \(tomorrowDate) a hh : mm"
        }
        formatter.locale = Locale(identifier: "ko_KR")
        self.dataDelegate?.sendStartTime(startTime: formatter.string(from: timePicker.date))
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
