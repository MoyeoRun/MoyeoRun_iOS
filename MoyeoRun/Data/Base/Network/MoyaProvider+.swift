//
//  MoyaProvider+.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation
import Moya

extension MoyaProvider {
    func request<Data: Codable>(
        _ target: Target,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        self.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let success = try JSONDecoder().decode(Success<Data>.self, from: response.data)
                    completion(.success(success.data))
                } catch {
                    do {
                        let failure = try JSONDecoder().decode(Failure.self, from: response.data)
                        completion(.failure(ClientError.failureRequest(reason: failure.case)))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

enum ClientError: Error {
    case failureRequest(reason: Failure.Case)
}
