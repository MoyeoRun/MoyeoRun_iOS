//
//  AuthRepository.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

protocol AuthRepositable: AnyObject {
    init(remoteDataSource: AuthRemoteDataSourceable, localDataSource: AuthLocalDataSourceable)

    func signIn(
        request: SignInRequest,
        completion: @escaping (Result<SignInResponse, Error>) -> Void
    )

    func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<SignUpResponse, Error>) -> Void
    )

    func refreshToken(
        request: RefreshRequest,
        completion: @escaping (Result<RefreshResponse, Error>) -> Void
    )

    func logout(
        request: LogoutRequset,
        completion: @escaping (Result<LogoutResponse, Error>) -> Void
    )
}

final class AuthRepository: AuthRepositable {
    let remoteDataSource: AuthRemoteDataSourceable
    let localDataSource: AuthLocalDataSourceable

    required init(
        remoteDataSource: AuthRemoteDataSourceable = AuthRemoteDataSource(),
        localDataSource: AuthLocalDataSourceable = AuthLocalDataSource()
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func signIn(
        request: SignInRequest,
        completion: @escaping (Result<SignInResponse, Error>) -> Void
    ) {
        remoteDataSource.signIn(requset: request) { remoteResult in
            switch remoteResult {
            case let .success(response):
                guard let token = response.token else {
                    return completion(.success(response))
                }

                let localResult = self.localDataSource.storeToken(token: token)
                guard case let .failure(error) = localResult else {
                    return completion(.success(response))
                }
                return completion(.failure(error))
            case let .failure(error):
                let localResult = self.localDataSource.clearToken()

                guard case let .failure(error) = localResult else {
                    return completion(.failure(error))
                }
                return completion(.failure(error))
            }
        }
    }

    func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<SignUpResponse, Error>) -> Void
    ) {
        remoteDataSource.signUp(requset: request) { remoteResult in
            switch remoteResult {
            case let .success(response):
                let localResult = self.localDataSource.storeToken(token: response.token)

                guard case let .failure(error) = localResult else {
                    return completion(.success(response))
                }
                return completion(.failure(error))
            case let .failure(error):
                let localResult = self.localDataSource.clearToken()

                guard case let .failure(error) = localResult else {
                    return completion(.failure(error))
                }
                return completion(.failure(error))
            }
        }
    }

    func refreshToken(
        request: RefreshRequest,
        completion: @escaping (Result<RefreshResponse, Error>) -> Void
    ) {
        remoteDataSource.refreshToken(requset: request) { remoteResult in
            switch remoteResult {
            case let .success(response):
                let localResult = self.localDataSource.refreshToken(token: request)

                guard case let .failure(error) = localResult else {
                    return completion(.success(response))
                }
                return completion(.failure(error))
            case let .failure(error):
                let localResult = self.localDataSource.clearToken()

                guard case let .failure(error) = localResult else {
                    return completion(.failure(error))
                }
                return completion(.failure(error))
            }
        }
    }

    func logout(
        request: LogoutRequset,
        completion: @escaping (Result<LogoutResponse, Error>) -> Void
    ) {
        remoteDataSource.logout(requset: request) { remoteResult in
            switch remoteResult {
            case let .success(response):
                let localResult = self.localDataSource.clearToken()

                guard case let .failure(error) = localResult else {
                    return completion(.success(response))
                }
                return completion(.failure(error))
            case let .failure(error):
                let localResult = self.localDataSource.clearToken()

                guard case let .failure(error) = localResult else {
                    return completion(.failure(error))
                }
                return completion(.failure(error))
            }
        }
    }
}
