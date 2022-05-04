//
//  AuthRepository.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

protocol AuthRepositable {
    init(remoteDataSource: AuthRemoteDataSourceable, localDataSource: AuthLocalDataSourceable)

    func signIn(
        request: SignInRequest,
        completion: @escaping (Result<Response<SignInResponse>, Error>) -> Void
    )

    func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<Response<SignUpResponse>, Error>) -> Void
    )

    func refreshToken(
        request: RefreshRequest,
        completion: @escaping (Result<Response<RefreshResponse>, Error>) -> Void
    )

    func logout(
        request: LogoutRequset,
        completion: @escaping (Result<Response<LogoutResponse>, Error>) -> Void
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
        completion: @escaping (Result<Response<SignInResponse>, Error>) -> Void
    ) {
        remoteDataSource.signIn(requset: request) { remoteResult in
            switch remoteResult {
            case let .success(response):
                let localResult = self.localDataSource.storeToken(token: response.data.token)

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
        completion: @escaping (Result<Response<SignUpResponse>, Error>) -> Void
    ) {
        remoteDataSource.signUp(requset: request) { remoteResult in
            switch remoteResult {
            case let .success(response):
                let localResult = self.localDataSource.storeToken(token: response.data.token)

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
        completion: @escaping (Result<Response<RefreshResponse>, Error>) -> Void
    ) {
        remoteDataSource.refreshToken(requset: request) { remoteResult in
            switch remoteResult {
            case let .success(response):
                let localResult = self.localDataSource.refreshAccessToken(
                    accessToken: response.data.accessToken
                )

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
        completion: @escaping (Result<Response<LogoutResponse>, Error>) -> Void
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