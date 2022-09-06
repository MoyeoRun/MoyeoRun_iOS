//
//  MakeRoomDTO.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/09/06.
//

import Foundation

struct MakeRoomRequest: Codable {
    let idToken: String
    let name: String
    let thumbnailImage: String
    let startTime: Date
    let targetPace: String
    let targetDistance: Int
    let limitTime: Int
    let limitUserCount: Int
}

struct MakeRoomResponse: Codable {
    let message: String
    let roomId: Int
}
