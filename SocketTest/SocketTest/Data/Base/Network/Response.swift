//
//  Response.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/01.
//

import Foundation

struct Success<Data: Codable>: Codable {
    let data: Data
}

struct Failure: Codable {
    enum Case: Int, CaseIterable, Codable {
        case badRequest = 100
        case unauthorized = 101
        case forbidden = 102
        case notFound = 103
        case jwtExpired = 104
        case unsignedUser = 105
        case nicknameDuplicate = 110
        case userDuplicate = 111
        case badMethod = 198
        case internalServerError = 199
    }

    let `case`: Case
}
