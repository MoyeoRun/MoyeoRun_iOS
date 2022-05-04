//
//  UserRepository.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

protocol UserRepositable {
    init(remoteDataSource: UserRemoteDataSourceable)

    func checkNicknameDuplication(
        requset: DuplicateRequest,
        completion: @escaping (Result<Response<DuplicateResponse>, Error>) -> Void
    )

    func inquiryUser(
        requset: UserRequset,
        completion: @escaping (Result<Response<UserResponse>, Error>) -> Void
    )
}

final class UserRepository: UserRepositable {
    let remoteDataSource: UserRemoteDataSourceable

    init(remoteDataSource: UserRemoteDataSourceable = UserRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }

    func checkNicknameDuplication(
        requset: DuplicateRequest,
        completion: @escaping (Result<Response<DuplicateResponse>, Error>) -> Void
    ) {
        remoteDataSource.checkNicknameDuplication(requset: requset, completion: completion)
    }

    func inquiryUser(
        requset: UserRequset,
        completion: @escaping (Result<Response<UserResponse>, Error>) -> Void
    ) {
        remoteDataSource.inquiryUser(requset: requset, completion: completion)
    }
}
