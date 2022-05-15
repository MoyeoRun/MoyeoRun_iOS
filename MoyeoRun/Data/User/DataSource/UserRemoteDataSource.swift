//
//  UserRemoteDataSource.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation
import Moya

protocol UserRemoteDataSourceable: AnyObject {
    init(provider: MoyaProvider<UserAPI>)

    func checkNicknameDuplication(
        requset: DuplicateRequest,
        completion: @escaping (Result<DuplicateResponse, Error>) -> Void
    )

    func inquiryUser(
        requset: UserRequset,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    )
}

final class UserRemoteDataSource: UserRemoteDataSourceable {
    let provider: MoyaProvider<UserAPI>

    init(provider: MoyaProvider<UserAPI> = .init()) {
        self.provider = provider
    }

    func checkNicknameDuplication(
        requset: DuplicateRequest,
        completion: @escaping (Result<DuplicateResponse, Error>) -> Void
    ) {
        provider.request(.duplicate(request: requset), completion: completion)
    }

    func inquiryUser(
        requset: UserRequset,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    ) {
        provider.request(.user(request: requset), completion: completion)
    }
}

enum UserAPI {
    case duplicate(request: DuplicateRequest)
    case user(request: UserRequset)
}

extension UserAPI: TargetType {
    var path: String {
        switch self {
        case .duplicate:
            return "/api/user/nickname/duplicate"
        case .user:
            return "/api/user"
        }
    }

    var method: Moya.Method {
        switch self {
        case .duplicate:
            return .post
        case .user:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .duplicate(request):
            return .requestJSONEncodable(request)
        case .user:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .duplicate:
            return nil
        case let .user(request):
            return ["Authorization": "Bearer " + request.accessToken]
        }
    }
}
