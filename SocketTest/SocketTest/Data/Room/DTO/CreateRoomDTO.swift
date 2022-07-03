//
//  CreateRoomDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/05/22.
//

import Foundation

struct CreateRoomRequest: Codable {
    var name: String
}



struct CrateRoomResponse: Codable {
    var id: Int
}
