//
//  ChatDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/05/20.
//

import Foundation

struct ChatRequest: Codable {
    let message: String
}

struct ChatResponse: Codable {
    let message: String
}
