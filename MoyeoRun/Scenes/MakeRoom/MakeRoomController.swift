//
//  ViewController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/03/22.
//

import UIKit

class MakeRoomController: UIViewController {
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var peopleButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var paceButton: UIButton!
    @IBOutlet weak var limitTimeButton: UIButton!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var setNameLength: UILabel!
    @IBOutlet weak var timeInfoView: UIView!
    var namePlaceHolder = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        namePlaceHolder = nameTextView.text
    }

    @IBAction func showPopup(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "MakeRoom", bundle: nil)
        guard
            let viewController = storyBoard.instantiateViewController(
                withIdentifier: "PopupViewController"
            ) as? PopupViewController
        else {
            return
        }
        viewController.dataDelegate = self
        if sender == peopleButton {
            viewController.index = 0
        } else if sender == distanceButton {
            viewController.index = 1
        } else {
            viewController.index = 2
        }
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: true, completion: nil)
    }

    @IBAction func showStartTimePopup(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "MakeRoom", bundle: nil)
        guard
            let viewController = storyBoard.instantiateViewController(
                withIdentifier: "StartTimePopUpViewController"
            ) as? StartTimePopUpViewController
        else {
            return
        }
        viewController.dataDelegate = self
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: true, completion: nil)
    }

    @IBAction func touchInfo(_ sender: UIButton) {
        timeInfoView.isHidden.toggle()
    }
}

extension MakeRoomController: SendDataDelegate {
    func sendPeopleNum(peopleNum: Int) {
        self.peopleButton.setTitle("\(peopleNum)명", for: .normal)
    }

    func sendDistance(distance: Int) {
        self.distanceButton.setTitle("\(distance)km", for: .normal)
    }

    func sendPace(pace: String) {
        self.paceButton.setTitle("\(pace)", for: .normal)
    }

    func sendStartTime(startTime: String) {
        self.startTimeButton.setTitle(startTime, for: .normal)
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
            textView.text = namePlaceHolder
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
