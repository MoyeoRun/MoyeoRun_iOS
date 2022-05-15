//
//  SignUpDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

struct SignUpRequest: Codable {
    let idToken: String
    let providerType: ProviderTypeDTO
    let nickName: String
    let name: String
    let gender: GenderDTO
    let image: String
}

struct SignUpResponse: Codable {
    let token: TokenDTO
    let userId: Int
}
