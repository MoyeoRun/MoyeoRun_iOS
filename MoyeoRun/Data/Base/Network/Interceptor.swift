//
//  Interceptor.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/24.
//

import Alamofire

class Interceptor: RequestInterceptor {
    let repository: AuthRepositable

    private let retryLimit = 3
    private let retryDelay: TimeInterval = 5

    init(repository: AuthRepositable = AuthRepository()) {
        self.repository = repository
    }

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest

        repository.getAccessToken { result in
            if case let .success(accessToken) = result {
                urlRequest.headers.add(.authorization(bearerToken: accessToken))
            }
        }

        completion(.success(urlRequest))
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

        if request.response?.statusCode == 401 {
            AuthRepository().refreshToken { result in
                switch result {
                case .success:
                    completion(.doNotRetry)
                case .failure:
                    AuthRepository().logout { _ in }
                }
            }
        } else {
            NetworkReachabilityManager()?.startListening { [weak self] status in
                guard let retryDelay = self?.retryDelay else {
                    return completion(.doNotRetryWithError(error))
                }

                switch status {
                case .reachable:
                    completion(.retry)
                case .notReachable, .unknown:
                    completion(.retryWithDelay(retryDelay))
                }
            }
        }
    }
}
