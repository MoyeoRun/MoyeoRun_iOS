//
//  LogoutDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

struct LogoutRequset: Codable {
    let refreshToken: String
}

struct LogoutResponse: Codable {
    let message: String
}
