//
//  StompDTO.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/14.
//

import Foundation

struct StompSendDTO {
    var message : String? = ""
    var dictionary: [String: Any] {
        return ["message": message]
    }

    var nsDictionary: NSDictionary{
        return dictionary as NSDictionary
    }
}
