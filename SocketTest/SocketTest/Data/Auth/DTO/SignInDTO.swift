//
//  SignInDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/01.
//

import Foundation

struct SignInRequest: Codable {
    let userId: String
    let password: String
    let email: String
}

struct SignInResponse: Codable {
    let message: String
}
