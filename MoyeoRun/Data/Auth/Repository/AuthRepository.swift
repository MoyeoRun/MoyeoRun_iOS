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

    func getAccessToken(
        completion: @escaping (Result<String, Error>) -> Void
    )

    func refreshToken(
        completion: @escaping (Result<RefreshResponse, Error>) -> Void
    )

    func logout(
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
        remoteDataSource.signIn(requset: request) { [weak self] remoteResult in
            switch remoteResult {
            case let .success(response):
                guard let token = response.token else {
                    return completion(.success(response))
                }

                let localResult = self?.localDataSource.storeToken(token: token)
                guard case let .failure(error) = localResult else {
                    return completion(.success(response))
                }
                return completion(.failure(error))
            case let .failure(error):
                let localResult = self?.localDataSource.clearToken()

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
        remoteDataSource.signUp(requset: request) { [weak self] remoteResult in
            switch remoteResult {
            case let .success(response):
                let localResult = self?.localDataSource.storeToken(token: response.token)

                guard case let .failure(error) = localResult else {
                    return completion(.success(response))
                }

                return completion(.failure(error))
            case let .failure(error):
                let localResult = self?.localDataSource.clearToken()

                guard case let .failure(error) = localResult else {
                    return completion(.failure(error))
                }

                return completion(.failure(error))
            }
        }
    }

    func getAccessToken(completion: @escaping (Result<String, Error>) -> Void) {
        return completion(localDataSource.getAccessToken())
    }

    func refreshToken(
        completion: @escaping (Result<RefreshResponse, Error>) -> Void
    ) {
        let result = localDataSource.getRefreshToken()

        guard case let .success(refreshToken) = result else {
            return completion(.failure(KeychainError.notFound))
        }

        let request = RefreshRequest(refreshToken: refreshToken)

        remoteDataSource.refreshToken(requset: request) { [weak self] remoteResult in
            switch remoteResult {
            case let .success(response):
                let localResult = self?.localDataSource.refreshAccessToken(accessToken: response.accessToken)

                guard case let .failure(error) = localResult else {
                    return completion(.success(response))
                }

                return completion(.failure(error))
            case let .failure(error):
                let localResult = self?.localDataSource.clearToken()

                guard case let .failure(error) = localResult else {
                    return completion(.failure(error))
                }

                return completion(.failure(error))
            }
        }
    }

    func logout(
        completion: @escaping (Result<LogoutResponse, Error>) -> Void
    ) {
        let result = localDataSource.getAccessToken()

        guard case let .success(accessToken) = result else {
            return completion(.failure(KeychainError.notFound))
        }

        let request = LogoutRequset(accessToken: accessToken)

        remoteDataSource.logout(requset: request) { [weak self] remoteResult in
            switch remoteResult {
            case let .success(response):
                let localResult = self?.localDataSource.clearToken()

                guard case let .failure(error) = localResult else {
                    return completion(.success(response))
                }

                return completion(.failure(error))
            case let .failure(error):
                let localResult = self?.localDataSource.clearToken()

                guard case let .failure(error) = localResult else {
                    return completion(.failure(error))
                }

                return completion(.failure(error))
            }
        }
    }
}
