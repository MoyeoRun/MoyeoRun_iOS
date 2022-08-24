//
//  SignInDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

struct SignInRequest: Codable {
    let idToken: String
    let providerType: ProviderTypeDTO
}

struct SignInResponse: Codable {
    let token: TokenDTO?
    let userId: Int?
    let isNewUser: Bool
}
