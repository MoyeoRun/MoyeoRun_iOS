//
//  HomeTopCell.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/08/25.
//

import UIKit

class HomeTopCell: UICollectionViewCell {
    static let cellId = "homeTopCellId"

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var makeRoomButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
