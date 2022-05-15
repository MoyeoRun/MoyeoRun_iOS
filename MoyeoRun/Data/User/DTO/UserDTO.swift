//
//  UserDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

struct UserRequset: Codable {
    let accessToken: String
}

struct UserResponse: Codable {
    let userId: Int
    let name: String
    let nickName: String
    let email: String
    let height: Int
    let weight: Int
    let image: String
}
