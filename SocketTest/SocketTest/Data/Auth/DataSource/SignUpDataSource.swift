//
//  SignUpDataSource.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import Foundation
import Moya

protocol SignUpDataSourceable: AnyObject {
    init(provider: MoyaProvider<SignUpAPI>)
    
    func inquirySignUp(
        request: SignUpRequest,
        completion: @escaping (Result<SignUpResponse, Error>) -> Void
    )
}

final class SignUpDataSource: SignUpDataSourceable {
    let provider: MoyaProvider<SignUpAPI>
    
    init(provider: MoyaProvider<SignUpAPI> = .init(plugins: [NetworkLoggerPlugin()])) {
        self.provider = provider
    }
    
    func inquirySignUp(request: SignUpRequest, completion: @escaping (Result<SignUpResponse, Error>) -> Void) {
        provider.request(.SignUp(request: request), completion: completion)
    }
}

enum SignUpAPI {
    case SignUp(request: SignUpRequest)
}

extension SignUpAPI: TargetType {
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case let .SignUp(request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var path: String {
        return "/api/member/login"
    }
}
