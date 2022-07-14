//
//  CreateRoomDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/05/22.
//

import Foundation

struct CreateRoomRequest: Codable {
    let accessToken: String
    var name: String
}



struct CreateRoomResponse: Codable {
    var message: String
}
