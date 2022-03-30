//
//  PopupViewController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/03/22.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendPeopleNum(peopleNum: Int)
    func sendStartTime(startTime: String)
    func sendDistance(distance: Int)
    func sendLimitTime(limitTime: Int)
}

class PopupViewController: UIViewController {
    var index = 0
    var availablePN = [Int](0...10)
    var selectedPN = 0
    var selectedKM = 0
    var availableKM: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var availableM = [Int](0...99)
    @IBOutlet var myView: UIView!
    @IBOutlet var selectButton: UIButton!
    @IBOutlet var cnacelButton: UIButton!
    @IBOutlet var navigationTitle: UINavigationItem!
    weak var dataDelegate: SendDataDelegate?
    let peopleNumPicker: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 30, y: 60, width: 250, height: 160))
        return pickerView
    }()
    let startTimePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 60, width: 100, height: 60))
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.minuteInterval = 5
        return datePicker
    }()
    let distancePicker: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 30, y: 60, width: 250, height: 160))
        return pickerView
    }()
    let limitTimePicker: UIDatePicker = {
        let timePicker = UIDatePicker(frame: CGRect(x: 0, y: 60, width: 270, height: 160))
        timePicker.datePickerMode = .countDownTimer
        timePicker.locale = Locale(identifier: "ko-KR")
        timePicker.minuteInterval = 10
        return timePicker
    }()
    let label: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.sizeToFit()
        label.frame = CGRect(x: 170, y: 130, width: 30, height: 20)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        if index == 0 {
            navigationTitle.title = "인원 수"
            myView.addSubview(peopleNumPicker)
            peopleNumPicker.delegate = self
            peopleNumPicker.dataSource = self
            label.text = "명"
            myView.addSubview(label)
        } else if index == 1 {
            navigationTitle.title = "시작시간 선택"
            myView.addSubview(startTimePicker)
        } else if index == 2 {
            navigationTitle.title = "목표거리 선택"
            myView.addSubview(distancePicker)
            distancePicker.delegate = self
            distancePicker.dataSource = self
            label.text = "KM"
            myView.addSubview(label)
        } else {
            navigationTitle.title = "제한시간 선택"
            myView.addSubview(limitTimePicker)
        }
        myView.clipsToBounds = true
        myView.layer.cornerRadius = 20.0
    }

    @IBAction func cancelPopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func selected(_ sender: Any) {
        if index == 0 {
            self.dataDelegate?.sendPeopleNum(peopleNum: selectedPN)
        } else if index == 1 {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "a hh:mm"
            formatter.locale = Locale(identifier: "ko_KR")
            let temp = formatter.string(from: startTimePicker.date)
            self.dataDelegate?.sendStartTime(startTime: temp)
        } else if index == 2 {
            self.dataDelegate?.sendDistance(distance: selectedKM)
        } else {
            self.dataDelegate?.sendLimitTime(limitTime: Int(limitTimePicker.countDownDuration / 60))
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension PopupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == distancePicker {
            return availableKM.count
        } else {
            return availablePN.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == distancePicker {
            return "\(availableKM[row])"
        } else {
            return "\(availablePN[row])"
        }
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == distancePicker {
            selectedKM = availableKM[row]
        } else {
            selectedPN = availablePN[row]
        }
    }
}
