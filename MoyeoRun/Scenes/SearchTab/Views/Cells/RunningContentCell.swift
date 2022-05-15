//
//  RunContentCell.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/15.
//

import Foundation
import UIKit

class RunningContentCell: UICollectionViewCell {
    @IBOutlet weak var blueTimeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    func setUI() {
        blueTimeLabel.setImageInLabelText(image: "pace", text: "5분 후 출발")
    }
}
