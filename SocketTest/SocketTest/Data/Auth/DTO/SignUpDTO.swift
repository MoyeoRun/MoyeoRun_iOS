//
//  SignUpDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import Foundation

struct SignUpRequest: Codable {
    let email: String
    let password: String
}

struct SignUpResponse: Codable {
    let accessToken: String
}
