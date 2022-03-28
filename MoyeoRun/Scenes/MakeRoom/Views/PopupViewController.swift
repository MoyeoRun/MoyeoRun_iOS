//
//  PopupViewController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/03/22.
//

import UIKit

protocol SendPeopleNumbDelegate: AnyObject {
    func sendPeopleNum(peopleNum: Int)
}

protocol SendStartTimeDelegate: AnyObject {
    func sendStartTime(startTime: String)
}

protocol SendDistanceDelegate: AnyObject {
    func sendDistance(distance: Int)
}

protocol SendLimitTimeDelegate: AnyObject {
    func sendLimitTime(limitTime: String)
}

class PopupViewController: UIViewController {
    var index: Int!
    var selectedPN = 0
    var selectedKM = 0
    @IBOutlet var myView: UIView!
    @IBOutlet var selectB: UIButton!
    @IBOutlet var cancelB: UIButton!
    @IBOutlet var navigationTitle: UINavigationItem!
    weak var pnDelegate: SendPeopleNumbDelegate?
    weak var stDelegate: SendStartTimeDelegate?
    weak var dDeleagte: SendDistanceDelegate?
    weak var slDelegate: SendLimitTimeDelegate?
    let peopleNumPicker: PeopleNumPicker = {
        let pickerView = PeopleNumPicker(frame: CGRect(x: 30, y: 60, width: 250, height: 160))
        return pickerView
    }()
    let startTimePicker: UIDatePicker = {
        // x,y는 적용되는데, width랑 height는 적용이 안되는듯
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 60, width: 100, height: 60))
        // datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.minuteInterval = 5
        return datePicker
    }()
    let distancePicker: DistancePicker = {
        let pickerView = DistancePicker(frame: CGRect(x: 30, y: 60, width: 250, height: 160))
        return pickerView
    }()
    let limitTimePicker: UIDatePicker = {
        let timePicker = UIDatePicker(frame: CGRect(x: 0, y: 60, width: 270, height: 160))
        // timePicker.preferredDatePickerStyle = .wheels
        timePicker.datePickerMode = .countDownTimer
        timePicker.locale = Locale(identifier: "ko-KR")
        timePicker.minuteInterval = 10
        return timePicker
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        if index == 0 {
            navigationTitle.title = "인원 수"
            myView.addSubview(peopleNumPicker)
            peopleNumPicker.delegate = peopleNumPicker
            peopleNumPicker.dataSource = peopleNumPicker
        } else if index == 1 {
            navigationTitle.title = "시작시간 선택"
            myView.addSubview(startTimePicker)
        } else if index == 2 {
            navigationTitle.title = "목표거리 선택"
            myView.addSubview(distancePicker)
            distancePicker.delegate = distancePicker
            distancePicker.dataSource = distancePicker
//            distancePicker.setPickerLabelsWith(labels:["KM"])
        } else {
            navigationTitle.title = "제한시간 선택"
            myView.addSubview(limitTimePicker)
        }
        // Do any additional setup after loading the view.
        myView.clipsToBounds = true
        myView.layer.cornerRadius = 20.0
    }

    @IBAction func cancelPopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func selected(_ sender: Any) {
        if index == 0 {
            self.pnDelegate?.sendPeopleNum(peopleNum: peopleNumPicker.selectedPN)
        } else if index == 1 {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "a hh:mm"
            formatter.locale = Locale(identifier: "ko_KR")
            let temp = formatter.string(from: startTimePicker.date)
            self.stDelegate?.sendStartTime(startTime: temp)
        } else if index == 2 {
            self.dDeleagte?.sendDistance(distance: distancePicker.selectedKM)
        } else {
            self.slDelegate?.sendLimitTime(limitTime: String(Int(limitTimePicker.countDownDuration / 60)))
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
// extension PopupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 2
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch component {
//        case 0:
//            return availableKM.count
//        case 1:
//            return availableM.count
//        default:
//            return 0
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch component {
//        case 0:
//            if availableKM[row]<10 {
//                return "0\(availableKM[row])"
//            } else {
//            return "\(availableKM[row])"
//            }
//        case 1:
//            if availableM[row]<10 {
//                return "0\(availableM[row])"
//            }
//            return "\(availableM[row])"
//        default:
//            return ""
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        switch component {
//        case 0:
//            return 48
//        case 1:
//            return 48
//        default:
//            return 100
//        }
//
//     }
//
//    /// 피커뷰에서 선택된 행을 처리할 수 있는 메서드
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        switch component {
//        case 0:
//            selectedKM = availableKM[row]
//        case 1:
//            selectedM = availableM[row]
//        default:
//            break
//        }
//    }
// }
