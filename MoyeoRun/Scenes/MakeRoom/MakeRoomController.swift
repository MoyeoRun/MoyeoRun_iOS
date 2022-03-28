//
//  ViewController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/03/22.
//

import UIKit

class MakeRoomController: UIViewController, SendStartTimeDelegate, SendDistanceDelegate, SendLimitTimeDelegate, SendPeopleNumbDelegate {
    func sendPeopleNum(peopleNum: Int) {
        self.peopleB.setTitle("\(peopleNum)명", for: .normal)
    }
    func sendDistance(distance: Int) {
        self.distanceB.setTitle("\(distance)KM", for: .normal)
    }
    func sendLimitTime(limitTime: String) {
        print(limitTime)
        if limitTime == String(1) {
            let temp = "\(Int(limitTime)! * 10)분"
            self.limitTimeB.setTitle(temp, for: .normal)
        } else if Int(limitTime)! >= 60 {
            let hour = Int(limitTime)! / 60
            let minute = (Int(limitTime)! % 60)
            let temp = "\(hour)시간 \(minute)분"
            self.limitTimeB.setTitle(temp, for: .normal)
        } else {
            let temp = "\(limitTime)분"
            self.limitTimeB.setTitle(temp, for: .normal)
        }
    }
    func sendStartTime(startTime: String) {
        self.startTimeB.setTitle(startTime, for: .normal)
    }

    var namePlaceHolder = ""
    var descriptionPlaceHolder = ""
    @IBOutlet var nameTV: UITextView!
    @IBOutlet var descriptionTV: UITextView!
    @IBOutlet var peopleB: UIButton!
    @IBOutlet var startTimeB: UIButton!
    @IBOutlet var distanceB: UIButton!
    @IBOutlet var limitTimeB: UIButton!
    @IBOutlet var setNameLength: UILabel!
    @IBOutlet var setDescriptionLength: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTV.delegate = self
        nameTV.layer.borderWidth = 1.0
        nameTV.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        namePlaceHolder = nameTV.text
        descriptionTV.delegate = self
        descriptionTV.layer.borderWidth = 1.0
        descriptionTV.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        descriptionPlaceHolder = descriptionTV.text
        peopleB.layer.borderWidth = 1.0
        peopleB.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        peopleB.setTitle("1명", for: .normal)
        peopleB.setTitleColor(.lightGray, for: .normal)
        startTimeB.layer.borderWidth = 1.0
        startTimeB.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        startTimeB.setTitle("오후 8시", for: .normal)
        startTimeB.setTitleColor(.lightGray, for: .normal)
        distanceB.layer.borderWidth = 1.0
        distanceB.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        distanceB.setTitle("1KM", for: .normal)
        distanceB.setTitleColor(.lightGray, for: .normal)
        limitTimeB.layer.borderWidth = 1.0
        limitTimeB.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        limitTimeB.setTitle("30분", for: .normal)
        limitTimeB.setTitleColor(.lightGray, for: .normal)
    }
    @IBAction func showPopup(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "MakeRoom", bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: "PopupViewController") as? PopupViewController else { return }
        if sender == peopleB {
            popupVC.pnDelegate = self
            popupVC.index = 0
        } else if sender == startTimeB {
            popupVC.stDelegate = self
            popupVC.index = 1
        } else if sender == distanceB {
            popupVC.dDeleagte = self
            popupVC.index = 2
        } else {
            popupVC.slDelegate = self
            popupVC.index = 3
        }
        popupVC.modalPresentationStyle = .overCurrentContext
        present(popupVC, animated: true, completion: nil)
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
            if textView == nameTV {
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
        if textView == nameTV {
            setNameLength.text = String(textView.text.count)
        } else {
            setDescriptionLength.text = String(textView.text.count)
        }
        return changedText.count <= 40
    }
}
