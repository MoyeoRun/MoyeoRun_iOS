//
//  UserDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import Foundation

struct UserRequest: Codable {
    let accessToken: String
}

struct UserResponse: Codable {
    let memberId: Int
    let name: String
    let email: String
}
