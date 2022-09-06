//
//  MakeRoomDataSource.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/09/06.
//

import Foundation
import Alamofire

protocol RoomRemoteDataSourceable: AnyObject {
    init(service: NetworkServiceable)

    func inquiryMakeRoom(
        request: MakeRoomRequest,
        completion: @escaping (Response<MakeRoomResponse>) -> Void
    )
}

final class RoomRemoteDataSource: RoomRemoteDataSourceable {
    private let service: NetworkServiceable

    required init(service: NetworkServiceable = NetworkService()) {
        self.service = service
    }

    func inquiryMakeRoom(
        request: MakeRoomRequest,
        completion: @escaping (Response<MakeRoomResponse>) -> Void
    ) {
        service.request(router: RoomRouter.makeRoom(request: request), completion: completion)
    }
}

enum RoomRouter: Routable {
    case makeRoom(request: MakeRoomRequest)

    var method: HTTPMethod {
        switch self {
        case .makeRoom:
            return .post
        }
    }

    var path: String {
        switch self {
        case .makeRoom:
            return "/api/room"
        }
    }

    var parameters: Parameters {
        switch self {
        case .makeRoom:
            return Parameters()
        }
    }
}
