//
//  RoomTableViewCell.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/11.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    static let id = "roomCell"
    
    //room 초기화 하는 방법 물어보기!
    var roomInfo: Room = Room(roomId: 0, roomName: "", adminId: 0, memberCount: 0)
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setData(data: Room){
        roomInfo.roomName = data.roomName
        roomInfo.memberCount = data.memberCount
        roomInfo.adminId = data.adminId
        roomInfo.roomId = data.roomId
        
        print(roomInfo)
        
        nameLabel.text = roomInfo.roomName
        nameLabel.sizeToFit()
        addSubview(nameLabel)
        configurationLayout()
    }
    
    func configurationLayout() {
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

//    func setViewLayout() {
//        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
////        self.layer.addBorder([.bottom], color: UIColor.darkGray, width: 1)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
