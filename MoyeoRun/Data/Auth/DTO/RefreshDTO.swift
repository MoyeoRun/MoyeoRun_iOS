//
//  RefreshDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

typealias RefreshRequest = TokenDTO

struct RefreshResponse: Codable {
    let accessToken: String
}
