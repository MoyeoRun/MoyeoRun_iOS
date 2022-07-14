//
//  SearchRoomDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/05/22.
//

import Foundation

struct Room: Codable {
    var roomId: Int
    var roomName: String
    var adminId: Int
    var memberCount: Int
}

struct RoomListRequest: Codable {
    let accessToken: String
}

struct RoomListResponse: Codable {
    var rooms: [Room]
}
