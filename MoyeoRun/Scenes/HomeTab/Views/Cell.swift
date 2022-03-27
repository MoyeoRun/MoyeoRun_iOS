//
//  Cell.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/03/27.
//

import Foundation
import UIKit

class HomeTabNowPopularCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfPartyLabel: UILabel!
    func setUI() {
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "벚꽃.jpeg")
        titleLabel.text = "바람 부는 날\n5km 함께 뛰어요"
        numberOfPartyLabel.setNumberOfPartyLabel(num: "3/5")
    }
}

class HomeTabNewMissionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    func setUI() {
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "벚꽃.jpeg")
    }
}
class HomeTabLastRecordCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rankingTitleLabel: UILabel!
    @IBOutlet weak var rankingRankLabel: UILabel!
    func setUI() {
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "벚꽃.jpeg")
    }
}
