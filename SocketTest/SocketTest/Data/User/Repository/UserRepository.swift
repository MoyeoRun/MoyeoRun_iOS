//
//  UserRepository.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import Foundation

protocol UserRepositable: AnyObject {
    init(remoteDataSource: UserDataSourceable)

    func inquiryUser(
        requset: UserRequest,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    )
}

final class UserRepository {
    let remoteDataSource: UserDataSourceable

    init(remoteDataSource: UserDataSource = .init()) {
        self.remoteDataSource = remoteDataSource
    }

    func inquiryUser(
        request: UserRequest,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    ) {
        remoteDataSource.inquiryUser(request: request, completion: completion)
    }
}
