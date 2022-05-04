//
//  DuplicateDTO.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

struct DuplicateRequest: Codable {
    let nickname: String
}

struct DuplicateResponse: Codable {
    let isDuplicate: Bool
}
