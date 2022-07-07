//
//  SignInDataSource.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/01.
//

import Foundation
import Moya

protocol SignInDataSourceable: AnyObject {
    init(provider: MoyaProvider<SignInAPI>)
    
    func inquirySignIn(
        request: SignInRequest,
        completion: @escaping (Result<SignInResponse, Error>) -> Void
    )
}

final class SignInDataSource: SignInDataSourceable {
    let provider: MoyaProvider<SignInAPI>
    
    init(provider: MoyaProvider<SignInAPI> = .init(plugins: [NetworkLoggerPlugin()])) {
        self.provider = provider
    }
    
    func inquirySignIn(request: SignInRequest, completion: @escaping (Result<SignInResponse, Error>) -> Void) {
        provider.request(.signIn(request: request), completion: completion)
    }
}

enum SignInAPI {
    case signIn(request: SignInRequest)
}

extension SignInAPI: TargetType {
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case let .signIn(request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var path: String {
        return "/api/member"
    }
}
