//
//  AuthDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

enum ProviderTypeRequest: String, Codable {
    case google = "GOOGLE"
    case apple = "APPLE"
}

enum GenderRequset: String, Codable {
    case male = "MALE"
    case female = "FEMAIL"
}

struct TokenResponse: Codable {
    var accessToken: String
    let refreshToken: String
}
