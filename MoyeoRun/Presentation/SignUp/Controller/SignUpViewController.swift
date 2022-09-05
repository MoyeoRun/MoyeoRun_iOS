//
//  SignUpViewController.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/31.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cameraSymbolButton: UIButton!
    @IBOutlet weak var nicknameInputView: NicknameInputView!
    @IBOutlet weak var genderSelectorView: GenderSelectorView!
    @IBOutlet weak var nextButton: UIButton!

    private let credential: SignInRequest
    private let authRepository: AuthRepositable
    private let userRepository: UserRepositable

    init?(coder: NSCoder, credential: SignInRequest, authRepository: AuthRepositable, userRepository: UserRepositable) {
        self.credential = credential
        self.authRepository = authRepository
        self.userRepository = userRepository

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

    @IBAction func signUpNext(_ sender: UIButton) {
        guard
            // TODO: Image mulipartData, API 구현 완료되는 대로 작업 시작
            let nickname = nicknameInputView.nickname,
            let name = nicknameInputView.nickname,
            let gender = genderSelectorView.gender
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
        authRepository.signUp(request: request) { [weak self] result in
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

    private func checkValidation() {
        guard
            nicknameInputView.state == .valid,
            genderSelectorView.gender != nil
        else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor(named: "Disabled Color")
            return
        }

        nextButton.isEnabled = true
        nextButton.backgroundColor = UIColor(named: "RunBlue")
    }
}

extension SignUpViewController: NicknameInputViewDelegate {
    func nicknameInputViewEditingChanged(_ nicknameInputView: NicknameInputView) {
        guard let nickname = nicknameInputView.nickname, !nickname.isEmpty else {
            return updateNicknameInputState(.normal)
        }

        let request = DuplicateRequest(nickName: nickname)
        userRepository.checkNicknameDuplication(request: request) { [weak self] result in
            let state: NicknameInputState

            switch result {
            case let .success(response):
                state = response.isDuplicate ? .invalid : .valid
            case .failure:
                state = .invalid
            }

            self?.updateNicknameInputState(state)
        }
    }

    private func updateNicknameInputState(_ state: NicknameInputState) {
        nicknameInputView.state = state
        checkValidation()
    }
}

extension SignUpViewController: GenderSelectorDelegate {
    func genderSelectorViewGenderChanged(_ genderSelectorView: GenderSelectorView) {
        checkValidation()
    }
}
