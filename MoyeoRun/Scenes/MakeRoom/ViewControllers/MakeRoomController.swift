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
    var startTime: String?
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

    func isAllInput() {
        if name != nil && userCount != nil && distance != nil && pace != nil && startTime != nil {
            completeButton.isEnabled = true
        }
    }

    func calculateLimitTime() {
        guard
            let tempPace = pace,
            let tempDistacne = distance
        else {
            return
        }
        let tempLimitTime = tempDistacne * (tempPace + 10)
        let (minuteLimit, secondLimit) = (tempLimitTime / 60, tempLimitTime % 60)
        let secondLimitString = String(secondLimit).paddingLeft(toLength: 2, withPad: "0", startingAt: 0)
        limitTimeButton.setTitle("\(minuteLimit)분 \(secondLimitString)초", for: .normal)
        self.limitTiime = tempLimitTime
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

extension String {
    func paddingLeft(toLength: Int, withPad: String, startingAt: Int) -> String {
        return String(String(self.reversed()).padding(toLength: toLength, withPad: "0", startingAt: 0).reversed())
    }
}
