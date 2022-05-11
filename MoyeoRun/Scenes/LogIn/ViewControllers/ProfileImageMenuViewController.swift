//
//  ProfileImageMenuViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/07.
//

import UIKit
import YPImagePicker

class ProfileImageMenuViewController: UIViewController {
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
            UITapGestureRecognizer(target: self, action: #selector(self.profileImageLabelTapped(_:)))
        )

        self.backgroundView.isUserInteractionEnabled = true
        self.backgroundView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        )
    }

    @IBAction func onTapSelectOnGallery(_ sender: Any) {
        let config = YPImagePickerConfiguration()
        let picker = YPImagePicker(configuration: config)

        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }

    @IBAction func onTapSelectDefaultImage(_ sender: Any) {
    }

    @objc func profileImageLabelTapped(_ sender: UITapGestureRecognizer) {}

    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false)
    }
}
