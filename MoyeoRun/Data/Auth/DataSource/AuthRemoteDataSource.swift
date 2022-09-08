//
//  AuthRemoteDataSource.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Alamofire

protocol AuthRemoteDataSourceable: AnyObject {
    init(service: NetworkServiceable)

    func signIn(
        request: SignInRequest,
        completion: @escaping (Response<SignInResponse>) -> Void
    )

    func signUp(
        request: SignUpRequest,
        completion: @escaping (Response<SignUpResponse>) -> Void
    )

    func refreshToken(
        request: RefreshRequest,
        completion: @escaping (Response<RefreshResponse>) -> Void
    )

    func logout(completion: @escaping (Response<LogoutResponse>) -> Void)
}

final class AuthRemoteDataSource: AuthRemoteDataSourceable {
    private let service: NetworkServiceable

    required init(service: NetworkServiceable = NetworkService()) {
        self.service = service
    }

    func signIn(
        request: SignInRequest,
        completion: @escaping (Response<SignInResponse>) -> Void
    ) {
        service.request(router: AuthRouter.signIn(request: request), completion: completion)
    }

    func signUp(
        request: SignUpRequest,
        completion: @escaping (Response<SignUpResponse>) -> Void
    ) {
        service.request(router: AuthRouter.signUp(request: request), completion: completion)
    }

    func refreshToken(
        request: RefreshRequest,
        completion: @escaping (Response<RefreshResponse>) -> Void
    ) {
        service.request(router: AuthRouter.refresh(request: request), completion: completion)
    }

    func logout(completion: @escaping (Response<LogoutResponse>) -> Void) {
        service.request(router: AuthRouter.logout, completion: completion)
    }
}

enum AuthRouter: Routable {
    case signIn(request: SignInRequest)
    case signUp(request: SignUpRequest)
    case refresh(request: RefreshRequest)
    case logout

    var method: HTTPMethod {
        switch self {
        case .signIn, .signUp, .refresh:
            return .post
        case .logout:
            return .get
        }
    }

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

    var parameters: Parameters {
        switch self {
        case let .signIn(request):
            return request.toParameters
        case let .signUp(request):
            return request.toParameters
        case let .refresh(request):
            return request.toParameters
        case .logout:
            return Parameters()
        }
    }
}
