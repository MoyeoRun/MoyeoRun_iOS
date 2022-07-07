//
//  UserDataSource.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import Foundation
import Moya

protocol UserDataSourceable: AnyObject {
    init(provider: MoyaProvider<UserAPI>)

    func inquiryUser(
        request: UserRequest,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    )
}

final class UserDataSource: UserDataSourceable {
    let provider: MoyaProvider<UserAPI>

    init(provider: MoyaProvider<UserAPI> = .init()) {
        self.provider = provider
    }

    func inquiryUser(
        request: UserRequest,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    ) {
        provider.request(.user(request: request), completion: completion)
    }
}

enum UserAPI {
    case user(request: UserRequest)
}

extension UserAPI: TargetType {
    var path: String {
        switch self {
        case .user:
            return "/api/member/info"
        }
    }

    var method: Moya.Method {
        switch self {
        case .user:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .user:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case let .user(request):
            return ["Authorization": "Bearer " + request.accessToken]
        }
    }
}
