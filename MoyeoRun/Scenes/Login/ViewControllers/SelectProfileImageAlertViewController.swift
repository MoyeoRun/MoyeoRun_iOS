//
//  SelectProfileImageAlertViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/04/23.
//

import UIKit

class SelectProfileImageAlertViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var profileImageLabel: UILabel!
    @IBOutlet weak var selectOnGalleryButton: UIButton!
    @IBOutlet weak var selectOnExistingImage: UIButton!
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setOnTapAction()
    }

    func setUI() {
        self.stackView.layer.cornerRadius = 12
        self.stackView.layer.masksToBounds = true
    }

    func setOnTapAction() {
        self.profileImageLabel.isUserInteractionEnabled = true
        self.profileImageLabel.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.onTapProfileImageLabel(_:)))
        )

        self.backgroundView.isUserInteractionEnabled = true
        self.backgroundView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        )
    }

    @objc func onTapProfileImageLabel(_ sender: UITapGestureRecognizer) {}

    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false)
    }
}
