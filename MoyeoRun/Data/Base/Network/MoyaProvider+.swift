//
//  MoyaProvider+.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation
import Moya

extension MoyaProvider{
    func request<Data: Decodable>(
        _ target : Target,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        self.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try JSONDecoder().decode(Data.self, from: response.data)
                    completion(.success(data))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
