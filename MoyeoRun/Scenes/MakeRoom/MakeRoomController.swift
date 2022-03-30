//
//  ViewController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/03/22.
//

import UIKit

class MakeRoomController: UIViewController {
    @IBOutlet var nameTextView: UITextView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var peopleButton: UIButton!
    @IBOutlet var startTimeButton: UIButton!
    @IBOutlet var distanceButton: UIButton!
    @IBOutlet var limitTimeButton: UIButton!
    @IBOutlet var setNameLength: UILabel!
    @IBOutlet var setDescriptionLength: UILabel!
    var namePlaceHolder = ""
    var descriptionPlaceHolder = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextView.delegate = self
        namePlaceHolder = nameTextView.text
        descriptionTextView.delegate = self
        descriptionPlaceHolder = descriptionTextView.text
        setColorButton(temp: [peopleButton, startTimeButton, distanceButton, limitTimeButton])
        setBorder(temp: [nameTextView, descriptionTextView, peopleButton, startTimeButton, distanceButton, limitTimeButton])
    }
    func setColorButton(temp: [UIButton]) {
        for value in temp {
            value.setTitleColor(.lightGray, for: .normal)
        }
    }
    func setBorder(temp: [AnyObject]) {
        for value in temp {
            value.layer.borderWidth = 1.0
            value.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        }
    }
    @IBAction func showPopup(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "MakeRoom", bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(
            withIdentifier: "PopupViewController") as? PopupViewController else { return }
        popupVC.dataDelegate = self
        if sender == peopleButton {
            popupVC.index = 0
        } else if sender == startTimeButton {
            popupVC.index = 1
        } else if sender == distanceButton {
            popupVC.index = 2
        } else {
            popupVC.index = 3
        }
        popupVC.modalPresentationStyle = .overCurrentContext
        present(popupVC, animated: true, completion: nil)
    }
}


extension MakeRoomController: SendDataDelegate {
    func sendStartTime(startTime: String) {
        self.startTimeButton.setTitle(startTime, for: .normal)
    }
    func sendDistance(distance: Int) {
        self.distanceButton.setTitle("\(distance)KM", for: .normal)
    }
    func sendPeopleNum(peopleNum: Int) {
        self.peopleButton.setTitle("\(peopleNum)명", for: .normal)
    }
    func sendLimitTime(limitTime: Int) {
        if limitTime == 1 {
            let temp = "\(limitTime) * 10)분"
            self.limitTimeButton.setTitle(temp, for: .normal)
        } else if limitTime >= 60 {
            let hour = limitTime / 60
            let minute = limitTime % 60
            let temp = "\(hour)시간 \(minute)분"
            self.limitTimeButton.setTitle(temp, for: .normal)
        } else {
            let temp = "\(limitTime)분"
            self.limitTimeButton.setTitle(temp, for: .normal)
        }
    }
}

extension MakeRoomController: UITextViewDelegate {
    // focus 경우
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = nil
            textView.textColor = .black
        }
    }
    // focus를 잃는 경우
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if textView == nameTextView {
                textView.text = namePlaceHolder
            } else {
                textView.text = descriptionPlaceHolder
            }
            textView.textColor = .lightGray
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        if textView == nameTextView {
            setNameLength.text = String(textView.text.count)
        } else {
            setDescriptionLength.text = String(textView.text.count)
        }
        return changedText.count <= 40
    }
}
