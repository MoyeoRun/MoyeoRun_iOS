//
//  ViewController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/03/22.
//

import UIKit

struct MyRoom {
    var image: String = "IMAGE2"
    var name: String?
    var userCount: Int?
    var distance: Int?
    var pace: Int?
    var limitTiime: Int?
    var startTime: String?
}

class MakeRoomController: UIViewController {
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var peopleButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var paceButton: UIButton!
    @IBOutlet weak var limitTimeButton: UIButton!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var setNameLength: UILabel!
    @IBOutlet weak var timeInfoView: UIView!
    @IBOutlet weak var completeButton: UIButton!
    var myRoom = MyRoom()
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
        myRoom.name = nameTextView.text
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

    @IBAction func showImageController(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "SelectPhoto", bundle: nil)
        guard
            let viewController = storyBoard.instantiateViewController(
                withIdentifier: "selectPhotoController"
            ) as? SelectPhotoController
        else {
            return
        }
        viewController.dataDelegate = self
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: nil)
    }
    @IBAction func touchInfo(_ sender: UIButton) {
        timeInfoView.isHidden.toggle()
    }

    @IBAction func touchCompleteButton(_ sender: UIButton) {
        guard
            let name = myRoom.name,
            let limitUserCount = myRoom.userCount,
            let startTime = myRoom.startTime,
            let pace = myRoom.pace,
            let distance = myRoom.distance,
            let limitTime = myRoom.limitTiime
        else {
            return
        }

        let request = MakeRoomRequest(
            name: name,
            thumbnailImage: myRoom.image,
            startTime: Date(),
            targetPace: "6’ 30”",
            targetDistance: distance,
            limitTime: limitTime,
            limitUserCount: limitUserCount
        )
        makeRoom(with: request)
    }

    func isAllInput() {
        if myRoom.name != nil && myRoom.userCount != nil && myRoom.distance != nil &&
            myRoom.pace != nil && myRoom.startTime != nil {
            completeButton.isEnabled = true
        }
    }

    func calculateLimitTime() {
        guard
            let tempPace = myRoom.pace,
            let tempDistacne = myRoom.distance
        else {
            return
        }
        let tempLimitTime = tempDistacne * (tempPace + 10)
        let (minuteLimit, secondLimit) = (tempLimitTime / 60, tempLimitTime % 60)
        let secondLimitString = String(secondLimit).paddingLeft(toLength: 2, withPad: "0", startingAt: 0)
        limitTimeButton.setTitle("\(minuteLimit)분 \(secondLimitString)초", for: .normal)
        myRoom.limitTiime = tempLimitTime
    }

    private func makeRoom(with request: MakeRoomRequest) {
        repository?.inquiryMakeRoom(request: request) { [weak self] result in
            print(result)
            switch result {
            case .success:
                print("success")
                DispatchQueue.main.async {
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
