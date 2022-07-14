//
//  ReadyRoomDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/14.
//

import Foundation

struct ReadyRoomRequest: Codable {
    let type: String
    let senderId: CLong
}

struct ReadyoomResponse: Codable {
    var message: String
}
