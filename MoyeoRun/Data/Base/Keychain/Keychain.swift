//
//  Keychain.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

protocol Keychainable: AnyObject {
    var query: [String: Any] { get }

    init(service: String, item: KeychainItem)
}

enum KeychainItem {
    case genericPassword
    case internetPassword
    case certificate
    case key
    case identity

    var value: CFString {
        switch self {
        case .genericPassword:
            return kSecClassGenericPassword
        case .internetPassword:
            return kSecClassInternetPassword
        case .certificate:
            return kSecClassCertificate
        case .key:
            return kSecClassKey
        case .identity:
            return kSecClassIdentity
        }
    }
}

enum KeychainError: Error, Equatable {
    case notFound
    case unexpectedData
    case duplicateItem
    case unhandledError(status: OSStatus)
}

final class Keychain: Keychainable {
    var query: [String: Any] {
        return [
            kSecClass as String: item.value,
            kSecAttrService as String: service
        ]
    }

    private let service: String
    private let item: KeychainItem

    required init(service: String = .init(), item: KeychainItem = .genericPassword) {
        assert(
            Bundle.main.bundleIdentifier != nil,
            "This is not the main bundle or CFBundleIdentifier is not defined."
        )

        guard let identifier = Bundle.main.bundleIdentifier else {
            fatalError("This is not the main bundle or CFBundleIdentifier is not defined.")
        }

        self.service = identifier
        self.item = item
    }
}
