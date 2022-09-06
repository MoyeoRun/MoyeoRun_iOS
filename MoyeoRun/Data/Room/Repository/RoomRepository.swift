//
//  RoomRepository.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/09/06.
//

import Foundation

protocol RoomRepositable: AnyObject {
    init(remoteDataSource: RoomRemoteDataSourceable)

    func inquiryMakeRoom(
        request: MakeRoomRequest,
        completion: @escaping (Result<MakeRoomResponse, Error>) -> Void
    )
}

final class RoomRepository: RoomRepositable {
    let remoteDataSource: RoomRemoteDataSourceable

    init(remoteDataSource: RoomRemoteDataSourceable = RoomRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }

    func inquiryMakeRoom(
        request: MakeRoomRequest,
        completion: @escaping (Result<MakeRoomResponse, Error>) -> Void
    ) {
        remoteDataSource.inquiryMakeRoom(request: request) { remoteResult in
            switch remoteResult {
            case let .success(success):
                return completion(.success(success.data))
            case let .failure(failure):
                return completion(.failure(NetworkError.responseFailure(case: failure.case)))
            }
        }
    }
}
