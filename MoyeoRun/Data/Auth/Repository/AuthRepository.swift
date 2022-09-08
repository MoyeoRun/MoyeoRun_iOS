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

    func getAccessToken() -> Result<String, Error>

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
        remoteDataSource.signIn(request: request) { [weak self] remoteResult in
            switch remoteResult {
            case let .success(success):
                let localResult = self?.localDataSource.storeToken(token: success.data.token)

                if case let .failure(error) = localResult {
                    return completion(.failure(error))
                }

                return completion(.success(success.data))
            case let .failure(failure):
                return completion(.failure(NetworkError.responseFailure(case: failure.case)))
            }
        }
    }

    func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<SignUpResponse, Error>) -> Void
    ) {
        remoteDataSource.signUp(request: request) { [weak self] remoteResult in
            switch remoteResult {
            case let .success(success):
                let localResult = self?.localDataSource.storeToken(token: success.data.token)

                if case let .failure(error) = localResult {
                    return completion(.failure(error))
                }

                return completion(.success(success.data))
            case let .failure(failure):
                return completion(.failure(NetworkError.responseFailure(case: failure.case)))
            }
        }
    }

    func getAccessToken() -> Result<String, Error> {
        return localDataSource.getAccessToken()
    }

    func refreshToken(
        completion: @escaping (Result<RefreshResponse, Error>) -> Void
    ) {
        let result = localDataSource.getRefreshToken()

        guard case let .success(refreshToken) = result else {
            return completion(.failure(KeychainError.notFound))
        }

        let request = RefreshRequest(refreshToken: refreshToken)

        remoteDataSource.refreshToken(request: request) { [weak self] remoteResult in
            switch remoteResult {
            case let .success(success):
                let localResult = self?.localDataSource.refreshAccessToken(accessToken: success.data.accessToken)

                if case let .failure(error) = localResult {
                    return completion(.failure(error))
                }

                return completion(.success(success.data))
            case let .failure(failure):
                let localResult = self?.localDataSource.clearToken()

                if case let .failure(error) = localResult {
                    return completion(.failure(error))
                }

                return completion(.failure(NetworkError.responseFailure(case: failure.case)))
            }
        }
    }

    func logout(
        completion: @escaping (Result<LogoutResponse, Error>) -> Void
    ) {
        remoteDataSource.logout { [weak self] remoteResult in
            switch remoteResult {
            case let .success(success):
                let localResult = self?.localDataSource.clearToken()

                if case let .failure(error) = localResult {
                    return completion(.failure(error))
                }

                return completion(.success(success.data))
            case let .failure(failure):
                let localResult = self?.localDataSource.clearToken()

                if case let .failure(error) = localResult {
                    return completion(.failure(error))
                }

                return completion(.failure(NetworkError.responseFailure(case: failure.case)))
            }
        }
    }
}
