//
//  KeychainStore.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

protocol KeychainStorable: AnyObject {
    init(keychain: Keychainable)

    func create<Value: Codable>(value: Value, forKey key: KeychainKeyType) throws

    func read<Value: Codable>(forKey key: KeychainKeyType) throws -> Value

    func update<Value: Codable>(value: Value, forKey key: KeychainKeyType) throws

    func delete(forKey key: KeychainKeyType) throws
}

final class KeychainStore: KeychainStorable {
    private let keychain: Keychainable

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    required init(keychain: Keychainable = Keychain()) {
        self.keychain = keychain
    }

    func create<Value: Codable>(value: Value, forKey key: KeychainKeyType) throws {
        do {
            let data = try encoder.encode(value)

            var query = keychain.query
            query[kSecAttrAccount as String] = key.account
            query[kSecValueData as String] = data

            let status = SecItemAdd(query as CFDictionary, nil)

            guard status != errSecDuplicateItem else {
                throw KeychainError.duplicateItem
            }

            guard status == errSecSuccess else {
                throw KeychainError.unhandledError(status: status)
            }
        } catch {
            throw error
        }
    }

    func read<Value: Codable>(forKey key: KeychainKeyType) throws -> Value {
        var query = keychain.query
        query[kSecAttrAccount as String] = key.account
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = true
        query[kSecReturnData as String] = true

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status != errSecItemNotFound else {
            throw KeychainError.notFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }

        guard
            let existingItem = item as? [CFString: Any],
            let data = existingItem[kSecValueData] as? Data
        else {
            throw KeychainError.unexpectedData
        }

        do {
            let value = try decoder.decode(Value.self, from: data)
            return value
        } catch {
            throw error
        }
    }

    func update<Value: Codable>(value: Value, forKey key: KeychainKeyType) throws {
        do {
            let data = try encoder.encode(value)

            var query = keychain.query
            query[kSecAttrAccount as String] = key.account
            let attributes: [String: Any] = [
                kSecAttrAccount as String: key.account,
                kSecValueData as String: data
            ]

            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

            guard status != errSecItemNotFound else {
                throw KeychainError.notFound
            }

            guard status == errSecSuccess else {
                throw KeychainError.unhandledError(status: status)
            }
        } catch {
            throw error
        }
    }

    func delete(forKey key: KeychainKeyType) throws {
        var query = keychain.query
        query[kSecAttrAccount as String] = key.account

        let status = SecItemDelete(query as CFDictionary)

        guard status != errSecItemNotFound else {
            throw KeychainError.notFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
    }
}
