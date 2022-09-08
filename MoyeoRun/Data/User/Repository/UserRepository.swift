//
//  UserRepository.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

protocol UserRepositable: AnyObject {
    init(remoteDataSource: UserRemoteDataSourceable)

    func checkNicknameDuplication(
        request: DuplicateRequest,
        completion: @escaping (Result<DuplicateResponse, Error>) -> Void
    )

    func inquiryUser(
        request: UserRequset,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    )
}

final class UserRepository: UserRepositable {
    let remoteDataSource: UserRemoteDataSourceable

    init(remoteDataSource: UserRemoteDataSourceable = UserRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }

    func checkNicknameDuplication(
        request: DuplicateRequest,
        completion: @escaping (Result<DuplicateResponse, Error>) -> Void
    ) {
        remoteDataSource.checkNicknameDuplication(request: request) { remoteResult in
            switch remoteResult {
            case let .success(success):
                return completion(.success(success.data))
            case let .failure(failure):
                return completion(.failure(NetworkError.responseFailure(case: failure.case)))
            }
        }
    }

    func inquiryUser(
        request: UserRequset,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    ) {
        remoteDataSource.inquiryUser(request: request) { remoteResult in
            switch remoteResult {
            case let .success(success):
                return completion(.success(success.data))
            case let .failure(failure):
                return completion(.failure(NetworkError.responseFailure(case: failure.case)))
            }
        }
    }
}
