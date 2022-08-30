//
//  SearchRoomDTO.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/08/25.
//

import Foundation

struct CurrentRoomListRequest: Codable {
    let idToken: String
}

struct CurrentRoomListResponse: Codable {
    let roomId: CLong
    let name: String
    let thumbnailImage: String
    // Date여야 함
    let startTime: String
    let distance: Int
    // Date여야 함
    let limitTime: String
    let pace: String
    let limitUserCount: Int
    let currentUserCount: Int
}
