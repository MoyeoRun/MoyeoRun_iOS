//
//  AuthLocalDataSource.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

protocol AuthLocalDataSourceable: AnyObject {
    init(store: KeychainStorable)

    @discardableResult
    func storeToken(token: TokenDTO) -> Result<Void, Error>

    @discardableResult
    func refreshToken(token: TokenDTO) -> Result<Void, Error>

    @discardableResult
    func clearToken() -> Result<Void, Error>
}

enum AuthKey: String, KeychainKeyType {
    case accessToken
    case refreshToken
}

final class AuthLocalDataSource: AuthLocalDataSourceable {
    let store: KeychainStorable

    required init(store: KeychainStorable = KeychainStore()) {
        self.store = store
    }

    func storeToken(token: TokenDTO) -> Result<Void, Error> {
        do {
            try store.create(value: token.accessToken, forKey: AuthKey.accessToken)
            try store.create(value: token.refreshToken, forKey: AuthKey.refreshToken)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func refreshToken(token: TokenDTO) -> Result<Void, Error> {
        do {
            try store.update(value: token.accessToken, forKey: AuthKey.accessToken)
            try store.update(value: token.refreshToken, forKey: AuthKey.refreshToken)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func clearToken() -> Result<Void, Error> {
        do {
            try store.delete(forKey: AuthKey.accessToken)
            try store.delete(forKey: AuthKey.refreshToken)
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
