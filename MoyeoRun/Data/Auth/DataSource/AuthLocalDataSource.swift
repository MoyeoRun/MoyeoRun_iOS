//
//  AuthLocalDataSource.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

protocol AuthLocalDataSourceable: AnyObject {
    init(store: KeychainStorable)

    func getAccessToken() -> Result<String, Error>

    func getRefreshToken() -> Result<String, Error>

    @discardableResult
    func storeToken(token: TokenDTO) -> Result<Void, Error>

    @discardableResult
    func refreshAccessToken(accessToken: String) -> Result<Void, Error>

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

    func getAccessToken() -> Result<String, Error> {
        do {
            let accessToken: String = try store.read(forKey: AuthKey.accessToken)
            return .success(accessToken)
        } catch {
            return .failure(error)
        }
    }

    func getRefreshToken() -> Result<String, Error> {
        do {
            let refreshToken: String = try store.read(forKey: AuthKey.refreshToken)
            return .success(refreshToken)
        } catch {
            return .failure(error)
        }
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

    func refreshAccessToken(accessToken: String) -> Result<Void, Error> {
        do {
            try store.update(value: accessToken, forKey: AuthKey.accessToken)
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
