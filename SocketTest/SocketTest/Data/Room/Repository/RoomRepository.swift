//
//  CreateRoomRepository.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/08.
//

import Foundation

protocol RoomRepositable: AnyObject {
    init(remoteDataSource: RoomDataSourceable)
    
    func inquiryCreateRoom(
        requset: CreateRoomRequest,
        completion: @escaping (Result<CreateRoomResponse, Error>) -> Void
    )
    
    func inquiryRoomList(
        request: RoomListRequest,
        completion: @escaping (Result<RoomListResponse, Error>) -> Void
    )
    
    func inquiryRoomDetail(
        request: RoomDetailRequest,
        completion: @escaping (Result<RoomDetailResponse, Error>) -> Void
    )
    
    func inquiryJoinRoom(
        request: JoinRoomRequest,
        completion: @escaping (Result<JoinRoomResponse, Error>) -> Void
    )
}

final class RoomRepository {
    let remoteDataSource: RoomDataSourceable
    
    init(remoteDataSource: RoomDataSource = .init()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func inquiryCreateRoom(
        request: CreateRoomRequest,
        completion: @escaping (Result<CreateRoomResponse, Error>) -> Void
    ) {
        remoteDataSource.inquiryCreateRoom(request: request, completion: completion)
    }
    
    func inquiryRoomList(
        request: RoomListRequest,
        completion: @escaping (Result<RoomListResponse, Error>) -> Void
    ) {
        remoteDataSource.inquiryRoomList(request: request, completion: completion)
    }
    
    func inquiryRoomDetail(
        request: RoomDetailRequest,
        completion: @escaping (Result<RoomDetailResponse, Error>) -> Void
    ) {
        remoteDataSource.inquiryRoomDetail(request: request, completion: completion)
    }
    
    func inquiryJoinRoom(
        request: JoinRoomRequest,
        completion: @escaping (Result<JoinRoomResponse, Error>) -> Void
    ) {
        remoteDataSource.inquiryJoinRoom(request: request, completion: completion)
    }
}
