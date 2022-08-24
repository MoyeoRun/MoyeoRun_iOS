//
//  KeychainKeyType.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

protocol KeychainKeyType {
    var account: String { get }
}

extension KeychainKeyType where Self: RawRepresentable, RawValue == String {
    var account: String {
        return self.rawValue
    }
}
