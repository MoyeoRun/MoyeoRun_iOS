//
//  EnterUserInfoWhenSignUpViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/04/23.
//

import UIKit

class EnterUserInfoWhenSignUp: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cameraSymbolButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var genderMaleButton: UIButton!
    @IBOutlet weak var genderFemaleButton: UIButton!
    var selectedGender: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI() {
        setProfileImageView()
        setCameraSymbolButton()

        func setProfileImageView() {
            self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width * 0.5
            self.profileImageView.layer.masksToBounds = true
        }

        func setCameraSymbolButton() {
            self.cameraSymbolButton.layer.cornerRadius = self.cameraSymbolButton.frame.width / 2
            self.cameraSymbolButton.layer.masksToBounds = true
            cameraSymbolButton.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
            self.cameraSymbolButton.layer.borderWidth = 1
            self.cameraSymbolButton.borderColor = .systemGray5
        }
    }

    @IBAction func onTapCameraSymbolButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SelectProfileImageAlert", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "SelectProfileImageAlert"
        )
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: false)
    }

    @IBAction func onTapMoveBackwardButton(_ sender: Any) {
        self.dismiss(animated: false)
    }

    @IBAction func onTapGenderMaleButton(_ sender: Any) {
        switch selectedGender {
        case 0: selectedGender = 1
        case 1: selectedGender = 0
        case 2: selectedGender = 1
        default: break
        }
        setGenderButtonColor()
    }

    @IBAction func onTapGenderFemaleButton(_ sender: Any) {
        switch selectedGender {
        case 0: selectedGender = 2
        case 1: selectedGender = 2
        case 2: selectedGender = 0
        default: break
        }
        setGenderButtonColor()
    }

    func setGenderButtonColor() {
        switch selectedGender {
        case 0: unsetBothButtonColor()

        case 1: setMaleButtonColor()
            unsetFemaleButtonColor()

        case 2: setFemaleButtonColor()
            unsetMaleButtonColor()

        default: break
        }

        func setMaleButtonColor() {
            genderMaleButton.tintColor = .white
            genderMaleButton.backgroundColor = UIColor(named: "buttonColor1")
            genderMaleButton.borderColor = UIColor(named: "buttonColor1")
        }
        func setFemaleButtonColor() {
            genderFemaleButton.tintColor = .white
            genderFemaleButton.backgroundColor = UIColor(named: "buttonColor1")
            genderFemaleButton.borderColor = UIColor(named: "buttonColor1")
        }
        func unsetBothButtonColor() {
            unsetMaleButtonColor()
            unsetFemaleButtonColor()
        }
        func unsetMaleButtonColor() {
            genderMaleButton.tintColor = .systemGray5
            genderMaleButton.backgroundColor = .white
            genderMaleButton.borderColor = .systemGray5
        }
        func unsetFemaleButtonColor() {
            genderFemaleButton.tintColor = .systemGray5
            genderFemaleButton.backgroundColor = .white
            genderFemaleButton.borderColor = .systemGray5
        }
    }
}
