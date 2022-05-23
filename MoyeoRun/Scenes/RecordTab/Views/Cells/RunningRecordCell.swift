//
//  RunningRecordCell.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/23.
//

import Foundation
import UIKit

class RunningRecordCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    func setUI() {
        imageView.layer.cornerRadius = 4
        self.layer.cornerRadius = 4
    }
}
