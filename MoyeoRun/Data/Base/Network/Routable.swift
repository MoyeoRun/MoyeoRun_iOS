//
//  Routable.swift
//  MoyeoRun
//
//
//  Created by Jeongho Moon on 2022/08/31.
//

import Alamofire

protocol Routable: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
    var encoding: ParameterEncoding? { get }
}

extension Routable {
    var baseURL: URL {
        return Configuration.baseURL.toURL
    }

    var encoding: ParameterEncoding? {
        return nil
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method

        if let encoding = encoding {
            request = try encoding.encode(request, with: parameters)
        } else {
            switch method {
            case .post, .put:
                request = try JSONEncoding.default.encode(request, with: parameters)
            case .get, .delete:
                request = try URLEncoding.default.encode(request, with: parameters)
            default:
                assert(
                    true,
                    """
                        Failed to endcode parameters,
                        Check if parameters is encodable, method is valid, or API is RESTful.
                    """
                )
            }
        }

        return request
    }
}
