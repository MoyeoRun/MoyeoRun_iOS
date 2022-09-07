//
//  PhotoCell.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/04/18.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet var photo: UIImageView!

    func setData(with data: String) {
        photo.image = UIImage(named: data)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
