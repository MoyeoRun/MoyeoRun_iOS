//
//  HomeTabNowPopularCell.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/03/29.
//

import UIKit

class HomeTabNowPopularCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfPartyLabel: UILabel!

    func setUI(forIndex: Int) {
        let cgRect = CGRect(x: 0, y: 0, width: 13, height: 13)
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "HomeTabNowPopular\(forIndex).png")
        titleLabel.text =
        """
        바람 부는 날
        5km 함께 뛰어요
        """
        numberOfPartyLabel.setImageInLabelText(image: "참가자", imageCGRect: cgRect, text: " 3/5")
    }
}
