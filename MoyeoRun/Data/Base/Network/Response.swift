//
//  Response.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/05/04.
//

import Foundation

struct Response<Data: Codable>: Codable {
    let data: Data
}
