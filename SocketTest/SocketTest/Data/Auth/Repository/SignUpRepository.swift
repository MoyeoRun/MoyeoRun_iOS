//
//  SignUpRepository.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/07.
//

import Foundation

protocol SignUpRepositable: AnyObject {
    init(remoteDataSource: SignUpDataSourceable)
    
    func inquirySignUp(
        request: SignUpRequest,
        completion: @escaping (Result<SignUpResponse, Error>) -> Void
    )
}

final class SignUpRepository: SignUpRepositable {
    let remoteDataSource: SignUpDataSourceable
    
    init(remoteDataSource: SignUpDataSourceable = SignUpDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func inquirySignUp(
        request: SignUpRequest,
        completion: @escaping (Result<SignUpResponse, Error>) -> Void
    ) {
        remoteDataSource.inquirySignUp(request: request, completion: completion)
    }
}
