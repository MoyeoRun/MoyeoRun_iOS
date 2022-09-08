//
//  NetworkService.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/31.
//

import Alamofire

protocol NetworkServiceable {
    init(session: Session)

    func request<Data: Codable>(router: Routable, completion: @escaping (Response<Data>) -> Void)
}

final class NetworkService: NetworkServiceable {
    private let session: Session

    init(session: Session = Session.default) {
        self.session = session
    }

    func request<Data: Codable>(router: Routable, completion: @escaping (Response<Data>) -> Void) {
        let request = session.request(router, interceptor: Interceptor())

        return performRequest(request, completion: completion)
    }

    private func performRequest<Data: Codable>(_ request: DataRequest, completion: @escaping (Response<Data>) -> Void) {
        request.responseDecodable(of: Response<Data>.self) { response in
            guard case let .success(data) = response.result else {
                assert(true, "Failed to decoding response: \(response.result)")

                return completion(.failure(.init(case: .unknownError)))
            }

            return completion(data)
        }
    }
}
