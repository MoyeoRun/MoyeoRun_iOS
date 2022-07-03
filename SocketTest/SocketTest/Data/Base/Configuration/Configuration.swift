//
//  Configuration.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/01.
//
import Foundation

enum Configuration {
    private enum Key: String {
        case baseURL = "BASE_URL"

        var value: Any {
            guard let value = Bundle.main.infoDictionary?[self.rawValue] as? Any else {
                fatalError("Failed to find value from \(self)")
            }
            return value
        }
    }

    static let baseURL: URL = {
        guard
            let urlString = Key.baseURL.value as? String,
            let url = URL(string: urlString)
        else {
            fatalError("Failed to find baseURL")
        }
        return url
    }()
}
