//
//  GenderSelectorView.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/09/04.
//

import UIKit

enum GenderSelectorState {
    case selected
    case unselected

    var backgroundColor: UIColor? {
        switch self {
        case .selected:
            return UIColor(named: "RunBlue")
        case .unselected:
            return .white
        }
    }

    var borderColor: UIColor? {
        switch self {
        case .selected:
            return UIColor(named: "RunBlue")
        case .unselected:
            return UIColor(named: "BorderColor1")
        }
    }

    func findGenderImage(_ gender: GenderDTO) -> UIImage? {
        switch self {
        case .selected:
            switch gender {
            case .male:
                return UIImage(named: "male.selected")
            case .female:
                return UIImage(named: "female.selected")
            }
        case .unselected:
            switch gender {
            case .male:
                return UIImage(named: "male.normal")
            case .female:
                return UIImage(named: "female.normal")
            }
        }
    }
}

@objc protocol GenderSelectorDelegate: AnyObject {
    func genderSelectorViewGenderChanged(_ genderSelectorView: GenderSelectorView)
}

class GenderSelectorView: XibView {
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!

    @IBOutlet weak var delegate: GenderSelectorDelegate?

    var gender: GenderDTO? {
        didSet {
            updateGender()
        }
    }

    @IBAction func selectGender(_ sender: UIButton) {
        switch sender {
        case maleButton:
            gender = .male
        case femaleButton:
            gender = .female
        default:
            return
        }
    }

    private func updateGender() {
        guard let gender = self.gender else { return }

        switch gender {
        case .male:
            updateButton(.male, for: .selected)
            updateButton(.female, for: .unselected)
        case .female:
            updateButton(.male, for: .unselected)
            updateButton(.female, for: .selected)
        }

        delegate?.genderSelectorViewGenderChanged(self)
    }

    private func updateButton(_ gender: GenderDTO, for state: GenderSelectorState) {
        let button: UIButton? = gender == .male ? maleButton : femaleButton

        button?.backgroundColor = state.backgroundColor
        button?.borderColor = state.borderColor
        button?.setImage(state.findGenderImage(gender), for: .normal)
    }
}
