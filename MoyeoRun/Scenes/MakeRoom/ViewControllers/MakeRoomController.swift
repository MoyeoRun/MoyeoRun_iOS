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
    @IBOutlet weak var completeButton: UIButton!

    var name: String?
    var userCount: Int?
    var distance: Int?
    var pace: Int?
    var limitTiime: Int?
    var startTime: Date?
    private var repository: RoomRepositable?

    init(repository: RoomRepositable) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        name = nameTextView.text
        print(Date())
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

    @IBAction func touchCompleteButton(_ sender: UIButton) {
//        print("hi")
//        guard
//            let startTime = startTimeButton.titleLabel?.text,
//            let pace = paceButton.titleLabel?.text,
//            let distance = distanceButton.titleLabel?.text,
//            let limitTime = limitTimeButton.titleLabel?.text,
//            let limitUserCount = peopleButton.titleLabel?.text
//        else {
//            return
//        }
//
//        let request = MakeRoomRequest(
//            idToken: <#T##String#>,
//            name: nameTextView.text,
//            thumbnailImage: "IMAGE1",
//            startTime: startTime,
//            targetPace: pace,
//            targetDistance: Int(distance),
//            limitTime: Int(limitTime) ?? 0,
//            limitUserCount: Int(limitUserCount) ?? 0
//        )
//
//        makeRoom(with: request)
    }

    private func isAllInput() {
        if name != nil && userCount != nil && distance != nil && pace != nil && startTime != nil {
            completeButton.isEnabled = true
        }
    }

    private func calculateLimitTime() {
        guard
            let tempPace = pace,
            let tempDistacne = distance
        else { return }
        limitTiime = (tempDistacne * tempPace) + (tempDistacne * 10)
        guard let tempLimitTime = limitTiime else { return }
        let minuteLimit = tempLimitTime / 60
        let secondLimit = tempLimitTime % 60 == 0 ? "00" : String(tempLimitTime % 60)
        limitTimeButton.setTitle("\(minuteLimit)분 \(secondLimit)초", for: .normal)
    }

    private func makeRoom(with request: MakeRoomRequest) {
        repository?.inquiryMakeRoom(request: request) { [weak self] result in
            switch result {
            case .success:
                let storyBoard = UIStoryboard(name: "Room", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "SignUpComplete")
                viewController.modalPresentationStyle = .fullScreen

                DispatchQueue.main.async {
                    self?.present(viewController, animated: true)
                }
            case .failure:
                debugPrint("Failed to make Room")
            }
        }
    }
}

extension MakeRoomController: SendDataDelegate {
    func sendPeopleNum(peopleNum: Int) {
        self.userCount = peopleNum
        if let temp = self.userCount {
            self.peopleButton.setTitle("\(temp)명", for: .normal)
            self.peopleButton.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        } else {
            return
        }
        self.isAllInput()
    }

    func sendDistance(distance: Int) {
        self.distance = distance
        if let temp = self.distance {
            self.distanceButton.setTitle("\(temp)km", for: .normal)
            self.distanceButton.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        }
        calculateLimitTime()
        isAllInput()
    }

    func sendPace(pace: Int) {
        self.pace = pace
        if let temp = self.pace {
            let minutePace = temp / 60
            let secondPace = temp % 60 == 0 ? "00":"30"
            paceButton.setTitle("\(minutePace)’ \(secondPace)”", for: .normal)
            paceButton.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        }
        calculateLimitTime()
        isAllInput()
    }

    func sendStartTime(startTime: Date) {
        self.startTime = startTime
        if let temp = self.startTime {
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
            textView.text = name
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
