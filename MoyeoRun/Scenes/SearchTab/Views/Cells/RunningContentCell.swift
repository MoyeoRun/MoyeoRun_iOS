//
//  RunContentCell.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/15.
//

import Foundation
import UIKit

class RunningContentCell: UICollectionViewCell {
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var blueTimeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfPartyLabel: UILabel!

    func setUI() {
        setLabel()
        func setLabel() {
            let blueTimeLabelCGRect = CGRect(x: 0, y: -2, width: 12, height: 12)
            let numberOfPartyCGRect = CGRect(x: 0, y: 0, width: 13, height: 13)
            cellContentView.layer.cornerRadius = 4
            blueTimeLabel.layer.cornerRadius = 4
            blueTimeLabel.setImageInLabelText(image: "pace", imageCGRect: blueTimeLabelCGRect, text: " 5분 후 시작")
            numberOfPartyLabel.setImageInLabelText(image: "참가자", imageCGRect: numberOfPartyCGRect, text: " 3/5")
        }
    }
}
