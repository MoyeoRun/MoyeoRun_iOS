//
//  HomeViewControllers.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/03/27.
//

import UIKit

// 고정 높이 320
class HomeTabViewController: UIViewController {
    let fixedHeight: CGFloat = 335
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    var screenHeightForSetting: CGFloat = 0 // 이름 고치기
    var multiplier: CGFloat = 0
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nowPopularContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var newMissionContainerHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI() {
        setHeightConstraint()
        setProfileImageView()
    }

    func setHeightConstraint() {
        multiplier = (UIScreen.main.bounds.height > 800) ? 1 : 1.1
        screenHeightForSetting = screenHeight * multiplier
        scrollViewHeightConstraint.constant = screenHeightForSetting + fixedHeight
        nowPopularContainerHeightConstraint.constant = screenHeightForSetting * 0.25
        newMissionContainerHeightConstraint.constant = screenHeightForSetting * 0.5 + 110
    }

    func setProfileImageView() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.profileImageView.layer.masksToBounds = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showMyPage))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGesture)
    }

    @objc func showMyPage(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let storyBoard = UIStoryboard(name: "MyPage", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "MyPage")
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
}
