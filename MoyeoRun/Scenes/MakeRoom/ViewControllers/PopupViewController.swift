//
//  PopupViewController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/03/22.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendPeopleNum(peopleNum: Int)
    func sendDistance(distance: Int)
    func sendPace(pace: String)
    func sendStartTime(startTime: String)
}

class PopupViewController: UIViewController {
    @IBOutlet var myView: UIView!
    @IBOutlet var navigationTitle: UINavigationItem!
    @IBOutlet weak var customPicker: UIPickerView!
    weak var dataDelegate: SendDataDelegate?

    var index = 0
    let availablePeopleNum = [Int](4...8)
    let availableKM = [Int](1...10)
    let availablePaceFront = [Int](1...10)
    let availablePaceBack: [String] = ["00", "30"]
    var selectedPeopleNum = 0
    var selectedKM = 0
    var selectedPaceFront = 0
    var selectedPaceBack = ""

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Apple SD Gothic Neo-Semibold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let label2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Apple SD Gothic Neo-Semibold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setPickerLabel()
    }

    func setPickerLabel() {
        if index == 0 {
            navigationTitle.title = "제한인원"
            label.text = "명"
            myView.addSubview(label)
            label.leadingAnchor.constraint(equalTo: myView.centerXAnchor, constant: 30).isActive = true
            label.centerYAnchor.constraint(equalTo: myView.centerYAnchor).isActive = true
        } else if index == 1 {
            navigationTitle.title = "목표거리"
            label.text = "km"
            myView.addSubview(label)
            label.leadingAnchor.constraint(equalTo: myView.centerXAnchor, constant: 30).isActive = true
            label.centerYAnchor.constraint(equalTo: myView.centerYAnchor).isActive = true
        } else {
            navigationTitle.title = "페이스"
            label.text = "‘"
            label2.text = "“"
            myView.addSubview(label)
            myView.addSubview(label2)
            label.leadingAnchor.constraint(equalTo: myView.centerXAnchor, constant: -20).isActive = true
            label.centerYAnchor.constraint(equalTo: myView.centerYAnchor).isActive = true
            label2.leadingAnchor.constraint(equalTo: myView.centerXAnchor, constant: 50).isActive = true
            label2.centerYAnchor.constraint(equalTo: myView.centerYAnchor).isActive = true
        }
    }

    @IBAction func cancelPopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func selected(_ sender: Any) {
        if index == 0 {
            self.dataDelegate?.sendPeopleNum(peopleNum: selectedPeopleNum)
        } else if index == 1 {
            self.dataDelegate?.sendDistance(distance: selectedKM)
        } else {
            self.dataDelegate?.sendPace(pace: "4/44")
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension PopupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if self.index == 2 {
            return 2
        } else {
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.index == 0 {
            return availablePeopleNum.count
        } else if self.index == 1 {
            return availableKM.count
        } else {
            if component == 0 {
                return availablePaceFront.count
            } else {
                return availablePaceBack.count
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.index == 0 {
            return "\(availablePeopleNum[row])"
        } else if self.index == 1 {
            return "\(availableKM[row])"
        } else {
            if component == 0 {
                return "\(availablePaceFront[row])"
            } else {
                return "\(availablePaceBack[row])"
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.index == 0 {
            selectedPeopleNum = availablePeopleNum[row]
        } else if self.index == 1 {
            selectedKM = availableKM[row]
        } else {
            if component == 0 {
                selectedPaceFront = availablePaceFront[row]
            } else {
                selectedPaceBack = availablePaceBack[row]
            }
        }
    }
}
