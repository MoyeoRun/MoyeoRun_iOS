//
//  NicknameInputView.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/09/04.
//

import UIKit

enum NicknameInputState {
    case normal
    case valid
    case invalid

    var backgroundColor: UIColor? {
        switch self {
        case .normal, .valid:
            return .white
        case .invalid:
            return UIColor(named: "Error Background Color")
        }
    }

    var borderColor: UIColor? {
        switch self {
        case .normal, .valid:
            return UIColor(named: "BorderColor1")
        case .invalid:
            return UIColor(named: "Error Color")
        }
    }

    var isErrorLabelHidden: Bool {
        switch self {
        case .normal, .valid:
            return true
        case .invalid:
            return false
        }
    }

    var feedbackImage: UIImage? {
        switch self {
        case .normal, .invalid:
            return nil
        case .valid:
            return UIImage(named: "feedback.check")
        }
    }
}

@objc protocol NicknameInputViewDelegate: AnyObject {
    func nicknameInputViewEditingChanged(_ nicknameInputView: NicknameInputView)
}

class NicknameInputView: XibView, Debouncable {
    @IBOutlet weak var nicknameTextField: NicknameTextField!
    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet weak var delegate: NicknameInputViewDelegate?

    var nickname: String? {
        get {
            return nicknameTextField.text
        }
        set {
            nicknameTextField.text = newValue
        }
    }

    var state: NicknameInputState = .normal {
        didSet {
            updateState()
        }
    }

    var workItem = DispatchWorkItem {}

    private let feedbackImageRect = CGRect(x: 0, y: 0, width: 24, height: 24)

    override func awakeFromNib() {
        super.awakeFromNib()

        commonInit()
    }

    @IBAction private func inputNickname(_ sender: UITextField) {
        debounce(for: 0.2) { [weak self] in
            guard let self = self else { return }

            self.delegate?.nicknameInputViewEditingChanged(self)
        }
    }

    private func commonInit() {
        nicknameTextField.text = ""
        nicknameTextField.rightViewMode = .always
    }

    private func updateState() {
        let imageView = UIImageView(image: state.feedbackImage)
        nicknameTextField.rightView = imageView
        nicknameTextField.backgroundColor = state.backgroundColor
        nicknameTextField.borderColor = state.borderColor
        errorLabel.isHidden = state.isErrorLabelHidden
    }
}
