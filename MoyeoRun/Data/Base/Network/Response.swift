//
//  Response.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/31.
//

import Foundation

enum Response<Data: Codable>: Codable {
    case success(Success<Data>)
    case failure(Failure)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        do {
            self = .success(try container.decode(Success<Data>.self))
        } catch {
            self = .failure(try container.decode(Failure.self))
        }
    }
}

struct Success<Data: Codable>: Codable {
    let data: Data
}

struct Failure: Codable {
    enum Case: Int, Codable {
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

        case unknownError = 999
    }

    let `case`: Case
}

enum NetworkError: Error, Equatable {
    case responseFailure(`case`: Failure.Case)
    case responseWashout
}
