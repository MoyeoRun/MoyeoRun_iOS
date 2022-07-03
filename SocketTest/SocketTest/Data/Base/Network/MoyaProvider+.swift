//
//  MoyaProvider+.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/03.
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
