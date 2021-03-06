//
//  AuthRemoteDataSource.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation
import Moya

protocol AuthRemoteDataSourceable: AnyObject {
    init(provider: MoyaProvider<AuthAPI>)

    func signIn(
        requset: SignInRequest,
        completion: @escaping (Result<SignInResponse, Error>) -> Void
    )

    func signUp(
        requset: SignUpRequest,
        completion: @escaping (Result<SignUpResponse, Error>) -> Void
    )

    func refreshToken(
        requset: RefreshRequest,
        completion: @escaping (Result<RefreshResponse, Error>) -> Void
    )

    func logout(
        requset: LogoutRequset,
        completion: @escaping (Result<LogoutResponse, Error>) -> Void
    )
}

final class AuthRemoteDataSource: AuthRemoteDataSourceable {
    let provider: MoyaProvider<AuthAPI>

    required init(provider: MoyaProvider<AuthAPI> = .init()) {
        self.provider = provider
    }

    func signIn(
        requset: SignInRequest,
        completion: @escaping (Result<SignInResponse, Error>) -> Void
    ) {
        provider.request(.signIn(request: requset), completion: completion)
    }

    func signUp(
        requset: SignUpRequest,
        completion: @escaping (Result<SignUpResponse, Error>) -> Void
    ) {
        provider.request(.signUp(request: requset), completion: completion)
    }

    func refreshToken(
        requset: RefreshRequest,
        completion: @escaping (Result<RefreshResponse, Error>) -> Void
    ) {
        provider.request(.refresh(request: requset), completion: completion)
    }

    func logout(
        requset: LogoutRequset,
        completion: @escaping (Result<LogoutResponse, Error>) -> Void
    ) {
        provider.request(.logout(request: requset), completion: completion)
    }
}

enum AuthAPI {
    case signIn(request: SignInRequest)
    case signUp(request: SignUpRequest)
    case refresh(request: RefreshRequest)
    case logout(request: LogoutRequset)
}

extension AuthAPI: TargetType {
    var path: String {
        switch self {
        case .signIn:
            return "/api/auth/sign-in"
        case .signUp:
            return "/api/auth/sign-up"
        case .refresh:
            return "/api/auth/refresh"
        case .logout:
            return "/api/auth/logout"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .refresh:
            return .post
        case .logout:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .signIn(request):
            return .requestJSONEncodable(request)
        case let .signUp(request):
            return .requestJSONEncodable(request)
        case let .refresh(request):
            return .requestJSONEncodable(request)
        case .logout:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .signIn, .signUp, .refresh:
            return nil
        case let .logout(request):
            return ["Authorization": "Bearer " + request.accessToken]
        }
    }
}
