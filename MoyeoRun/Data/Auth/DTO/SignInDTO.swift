//
//  SignInDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

struct SignInRequest: Codable {
    let idToken: String
    let providerType: ProviderTypeRequest
}

struct SignInResponse: Codable {
    let token: TokenResponse
    let userId: Int
    let newUser: Bool
}
