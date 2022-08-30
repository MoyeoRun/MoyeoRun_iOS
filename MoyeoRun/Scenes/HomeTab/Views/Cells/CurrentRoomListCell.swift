//
//  CurrentRoomListCell.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/08/25.
//

import UIKit

class CurrentRoomListCell: UICollectionViewCell {

    static let cellId = "currentRoomListCellId"
    @IBOutlet weak var roomView: RoomView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(with data: CurrentRoomListResponse) {
        roomView.setData(with: data)
    }
}
