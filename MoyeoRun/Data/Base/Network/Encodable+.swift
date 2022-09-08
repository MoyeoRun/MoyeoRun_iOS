//
//  Encodable+.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/31.
//

import Alamofire

extension Encodable {
    var toParameters: Parameters {
        guard
            let data = try? JSONEncoder().encode(self),
            let parameters = try? JSONSerialization.jsonObject(with: data) as? Parameters
        else {
            return Parameters()
        }

        return parameters
    }
}
