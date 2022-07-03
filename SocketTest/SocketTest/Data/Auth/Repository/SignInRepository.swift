//
//  SignInRepository.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/01.
//

import Foundation

protocol SignInRepositable: AnyObject {
    init(remoteDataSource: SignInDataSourceable)
    
    func inquirySignIn(
        request: SignInRequest,
        completion: @escaping (Result<SignInResponse, Error>) -> Void
    )
}

final class SignInRepository: SignInRepositable {
    let remoteDataSource: SignInDataSourceable
    
    init(remoteDataSource: SignInDataSourceable = SignInDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func inquirySignIn(
        request: SignInRequest,
        completion: @escaping (Result<SignInResponse, Error>) -> Void
    ) {
        remoteDataSource.inquirySignIn(request: request, completion: completion)
    }
}
