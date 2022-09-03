//
//  SignUpViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/07.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cameraSymbolButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var genderSelectorView: GenderSelectorView!

    private let credential: SignInRequest
    private let repository: AuthRepositable

    init?(coder: NSCoder, credential: SignInRequest, repository: AuthRepositable) {
        self.credential = credential
        self.repository = repository

        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    @IBAction func onTapNextButton(_ sender: Any) {
        guard
            let nickname = nickNameTextField.text,
            let name = nameTextField.text,
            let gender = genderSelectorView.gender
            // TODO: Image mulipartData, API 구현 완료되는 대로 작업 시작
        else {
            return
        }

        let request = SignUpRequest(
            idToken: credential.idToken,
            providerType: credential.providerType,
            nickName: nickname,
            name: name,
            gender: gender,
            image: "test"
        )

        signUp(with: request)
    }

    private func signUp(with request: SignUpRequest) {
        repository.signUp(request: request) { [weak self] result in
            switch result {
            case .success:
                let storyBoard = UIStoryboard(name: "SignUpComplete", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "SignUpComplete")
                viewController.modalPresentationStyle = .fullScreen

                DispatchQueue.main.async {
                    self?.present(viewController, animated: true)
                }
            // TODO: Error Handling
            case .failure:
                debugPrint("Failed to sign up")
            }
        }
    }
}
