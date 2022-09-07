//
//  MakeRoomController+.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/09/07.
//

import Foundation
import UIKit

extension MakeRoomController: SendDataDelegate {
    func sendImage(image: String) {
        myRoom.image = image
        roomImageView.image = UIImage(named: myRoom.image)
    }

    func sendPeopleNum(peopleNum: Int) {
        myRoom.userCount = peopleNum
        if let temp = myRoom.userCount {
            self.peopleButton.setTitle("\(temp)명", for: .normal)
            self.peopleButton.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        } else {
            return
        }
        isAllInput()
    }

    func sendDistance(distance: Int) {
        myRoom.distance = distance
        if let temp = myRoom.distance {
            self.distanceButton.setTitle("\(temp)km", for: .normal)
            self.distanceButton.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        }
        calculateLimitTime()
        isAllInput()
    }

    func sendPace(pace: Int) {
        myRoom.pace = pace
        if let temp = myRoom.pace {
            let minutePace = temp / 60
            let secondPace = temp % 60 == 0 ? "00":"30"
            paceButton.setTitle("\(minutePace)’ \(secondPace)”", for: .normal)
            paceButton.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        }
        calculateLimitTime()
        isAllInput()
    }

    func sendStartTime(startTime: String) {
        myRoom.startTime = startTime
        if let temp = myRoom.startTime {
            startTimeButton.setTitle("\(temp)", for: .normal)
            startTimeButton.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        }
        isAllInput()
    }
}

extension MakeRoomController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = myRoom.name
            textView.textColor = .lightGray
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        setNameLength.text = String(textView.text.count)
        return changedText.count <= 40
    }
}
