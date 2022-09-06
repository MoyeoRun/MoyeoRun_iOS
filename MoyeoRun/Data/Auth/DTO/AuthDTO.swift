//
//  AuthDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

enum ProviderTypeDTO: String, Codable {
    case google = "GOOGLE"
    case apple = "APPLE"
}

enum GenderDTO: String, Codable {
    case male = "MALE"
    case female = "FEMALE"
}

struct TokenDTO: Codable {
    var accessToken: String
    let refreshToken: String
}
