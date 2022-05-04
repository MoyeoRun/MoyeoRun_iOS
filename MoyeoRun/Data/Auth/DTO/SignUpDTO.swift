//
//  SignUpDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

struct SignUpRequest: Codable {
    let idToken: String
    let providerType: ProviderTypeRequest
    let nickName: String
    let name: String
    let gender: GenderRequset
    let image: String
}

struct SignUpResponse: Codable {
    let token: TokenResponse
    let userId: Int
}
