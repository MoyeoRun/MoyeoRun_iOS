//
//  JoinRoomDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/13.
//

import Foundation

struct JoinRoomRequest: Codable {
    let accessToken: String
    let roomId: Int
}

struct JoinRoomResponse: Codable {
    var message: String
}
