//
//  SearchRoomDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/11.
//

import Foundation

struct RoomDetailRequest: Codable {
    let accessToken: String
    let roomId: Int
}

struct RoomDetailResponse: Codable {
    var roomId: Int
    var adminId: Int
    var roomName: String
    var roomMembers: [User]
}
