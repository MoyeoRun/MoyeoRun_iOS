//
//  UserRemoteDataSource.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation
import Alamofire

protocol UserRemoteDataSourceable: AnyObject {
    init(service: NetworkServiceable)

    func checkNicknameDuplication(
        request: DuplicateRequest,
        completion: @escaping (Response<DuplicateResponse>) -> Void
    )

    func inquiryUser(
        request: UserRequset,
        completion: @escaping (Response<UserResponse>) -> Void
    )
}

final class UserRemoteDataSource: UserRemoteDataSourceable {
    private let service: NetworkServiceable

    required init(service: NetworkServiceable = NetworkService()) {
        self.service = service
    }

    func checkNicknameDuplication(
        request: DuplicateRequest,
        completion: @escaping (Response<DuplicateResponse>) -> Void
    ) {
        service.request(router: UserRouter.duplicate(request: request), completion: completion)
    }

    func inquiryUser(
        request: UserRequset,
        completion: @escaping (Response<UserResponse>) -> Void
    ) {
        service.request(router: UserRouter.user(request: request), completion: completion)
    }
}

enum UserRouter: Routable {
    case duplicate(request: DuplicateRequest)
    case user(request: UserRequset)

    var method: HTTPMethod {
        switch self {
        case .duplicate:
            return .post
        case .user:
            return .get
        }
    }

    var path: String {
        switch self {
        case .duplicate:
            return "/api/user/nickname/duplicate"
        case .user:
            return "/api/user"
        }
    }

    var parameters: Parameters {
        switch self {
        case let .duplicate(request):
            return request.toParameters
        case .user:
            return Parameters()
        }
    }
}
