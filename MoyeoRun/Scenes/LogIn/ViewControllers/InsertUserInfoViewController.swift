//
//  InsertUserInfoViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/07.
//
import UIKit

class InsertUserInfoViewController: UIViewController {
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
        setNameTextFieldBorderColor()
        setNickNameTextFieldBorderColor()

        func setNameTextFieldBorderColor() {
            nameTextField.borderStyle = .none
            nameTextField.layer.borderWidth = 1
            nameTextField.layer.cornerRadius = 4
            nameTextField.layer.borderColor = UIColor(named: "BorderColor1")?.cgColor
        }

        func setNickNameTextFieldBorderColor() {
            nickNameTextField.borderStyle = .none
            nickNameTextField.layer.borderWidth = 1
            nickNameTextField.layer.cornerRadius = 4
            nickNameTextField.layer.borderColor = UIColor(named: "BorderColor1")?.cgColor
        }

        func setProfileImageView() {
            self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width * 0.5
            self.profileImageView.layer.masksToBounds = true
        }

        func setCameraSymbolButton() {
            self.cameraSymbolButton.layer.cornerRadius = self.cameraSymbolButton.frame.width * 0.5
            self.cameraSymbolButton.layer.masksToBounds = true
            self.cameraSymbolButton.layer.borderWidth = 0
            cameraSymbolButton.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
        }
    }

    @IBAction func onTapCameraSymbolButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProfileImageMenu", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileImageMenu")
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
            genderMaleButton.backgroundColor = UIColor(named: "RunBlue")
            genderMaleButton.borderColor = UIColor(named: "RunBlue")
        }
        func setFemaleButtonColor() {
            genderFemaleButton.tintColor = .white
            genderFemaleButton.backgroundColor = UIColor(named: "RunBlue")
            genderFemaleButton.borderColor = UIColor(named: "RunBlue")
        }
        func unsetBothButtonColor() {
            unsetMaleButtonColor()
            unsetFemaleButtonColor()
        }
        func unsetMaleButtonColor() {
            genderMaleButton.tintColor = UIColor(named: "BorderColor1")
            genderMaleButton.backgroundColor = .white
            genderMaleButton.borderColor = UIColor(named: "BorderColor1")
        }
        func unsetFemaleButtonColor() {
            genderFemaleButton.tintColor = UIColor(named: "BorderColor1")
            genderFemaleButton.backgroundColor = .white
            genderFemaleButton.borderColor = UIColor(named: "BorderColor1")
        }
    }
}
