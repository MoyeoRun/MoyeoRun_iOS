//
//  RefreshDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

struct RefreshRequest: Codable {
    let refreshToken: String
}

struct RefreshResponse: Codable {
    let accessToken: String
}
