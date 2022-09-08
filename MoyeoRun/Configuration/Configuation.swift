//
//  Configuation.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/04/04.
//

import Foundation

enum Configuration: String {
    case baseURL = "BASE_URL"
    case clientId = "CLIENT_ID"
    case serverClientId = "SERVER_CLIENT_ID"

    var toString: String {
        guard let string = self.value as? String else {
            fatalError("Failed to find value typed: String")
        }

        return string
    }

    var toURL: URL {
        guard
            let urlString = self.value as? String,
            let url = URL(string: urlString)
        else {
            fatalError("Failed to find value typed: URL")
        }

        return url
    }

    private var value: Any? {
        guard let value = Bundle.main.infoDictionary?[self.rawValue] else {
            fatalError("Failed to find value of \(self.rawValue)")
        }

        return value
    }
}
