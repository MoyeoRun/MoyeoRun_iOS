//
//  HomeTabLastRecordCell.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/03/29.
//

import UIKit

class HomeTabLastRecordCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rankingTitleLabel: UILabel!
    @IBOutlet weak var rankingRankLabel: UILabel!

    func setUI(forIndex: Int) {
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "HomeTabLastRecord\(forIndex).png")
    }
}
