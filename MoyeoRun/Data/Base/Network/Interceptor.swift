//
//  Interceptor.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/24.
//

import Alamofire

class Interceptor: RequestInterceptor {
    private let manager: NetworkReachabilityManager?
    private let repository: AuthRepositable

    private let retryLimit = 3
    private let retryDelay: TimeInterval = 5

    init(
        manager: NetworkReachabilityManager? = NetworkReachabilityManager(),
        repository: AuthRepositable = AuthRepository()
    ) {
        self.manager = manager
        self.repository = repository
    }

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest
        let result = repository.getAccessToken()

        if case let .success(accessToken) = result {
            urlRequest.headers.add(.authorization(bearerToken: accessToken))
        }

        return completion(.success(urlRequest))
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard request.retryCount <= retryLimit else {
            return completion(.doNotRetryWithError(error))
        }

        guard request.response?.statusCode == 401 else {
            return reconnectNetwork(throwed: error, completion: completion)
        }

        return refreshToken(completion: completion)
    }

    private func refreshToken(completion: @escaping (RetryResult) -> Void) {
        let result = repository.getAccessToken()

        if case let .failure(error) = result {
            return completion(.doNotRetryWithError(error))
        }

        repository.refreshToken { [weak self] result in
            switch result {
            case .success:
                completion(.doNotRetry)
            case .failure:
                self?.repository.logout { _ in }
            }
        }
    }

    private func reconnectNetwork(throwed error: Error, completion: @escaping (RetryResult) -> Void) {
        manager?.startListening { [weak self] status in
            guard let retryDelay = self?.retryDelay else {
                return completion(.doNotRetryWithError(error))
            }

            switch status {
            case .reachable:
                return completion(.retry)
            case .notReachable, .unknown:
                return completion(.retryWithDelay(retryDelay))
            }
        }
    }
}
