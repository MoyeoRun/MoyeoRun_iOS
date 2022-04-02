//
//  HomeTabNewMissionCell.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/03/29.
//

import UIKit

class HomeTabNewMissionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    func setUI(forIndex: Int) {
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "HomeTabNewMission\(forIndex).png")
    }
}
