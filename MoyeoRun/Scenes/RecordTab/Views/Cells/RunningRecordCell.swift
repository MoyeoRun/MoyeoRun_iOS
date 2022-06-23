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
    @IBOutlet var hostProfileImageView: UIImageView!
    @IBOutlet var profileImageView1: UIImageView!
    @IBOutlet var profileImageView2: UIImageView!
    @IBOutlet var profileImageView3: UIImageView!
    @IBOutlet var profileImageView4: UIImageView!
    @IBOutlet var profileImageView5: UIImageView!

    func setUI() {
        imageView.layer.cornerRadius = 4
        profileImageView1.layer.cornerRadius = profileImageView1.bounds.width * 0.5
        profileImageView2.layer.cornerRadius = profileImageView2.bounds.width * 0.5
        profileImageView3.layer.cornerRadius = profileImageView3.bounds.width * 0.5
        profileImageView4.layer.cornerRadius = profileImageView4.bounds.width * 0.5
        profileImageView5.layer.cornerRadius = profileImageView5.bounds.width * 0.5

        hostProfileImageView.layer.cornerRadius = hostProfileImageView.layer.bounds.width * 0.5
        self.layer.cornerRadius = 4
    }
}
