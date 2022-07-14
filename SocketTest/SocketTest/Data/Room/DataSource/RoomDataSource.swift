//
//  CreateRoomDataSource.swift
//  SocketTest
//
//  Created by 마경미 on 2022/07/08.
//

import Foundation
import Moya

protocol RoomDataSourceable: AnyObject {
    init(provider: MoyaProvider<RoomAPI>)
    
    func inquiryCreateRoom(
        request: CreateRoomRequest,
        completion: @escaping (Result<CreateRoomResponse, Error>) -> Void
    )
    
    func inquiryRoomList(
        request: RoomListRequest,
        completion: @escaping (Result<RoomListResponse, Error>) -> Void
    )
    
    func inquiryRoomDetail(
        request: RoomDetailRequest,
        completion: @escaping (Result<RoomDetailResponse, Error>) -> Void
    )
    
    func inquiryJoinRoom(
        request: JoinRoomRequest,
        completion: @escaping (Result<JoinRoomResponse, Error>) -> Void
    )
}

final class RoomDataSource: RoomDataSourceable {
    let provider: MoyaProvider<RoomAPI>
    
    init(provider: MoyaProvider<RoomAPI> = .init(plugins: [NetworkLoggerPlugin()])) {
        self.provider = provider
    }
    
    func inquiryCreateRoom(request: CreateRoomRequest, completion: @escaping (Result<CreateRoomResponse, Error>) -> Void) {
        provider.request(.createRoom(request: request), completion: completion)
    }
    
    func inquiryRoomList(
        request: RoomListRequest,
        completion: @escaping (Result<RoomListResponse, Error>) -> Void
    ) {
        provider.request(.roomList(request: request), completion: completion)
    }
    
    func inquiryRoomDetail(request: RoomDetailRequest, completion: @escaping (Result<RoomDetailResponse, Error>) -> Void) {
        provider.request(.roomDetail(request: request), completion: completion)
    }
    
    func inquiryJoinRoom(request: JoinRoomRequest, completion: @escaping (Result<JoinRoomResponse, Error>) -> Void) {
        provider.request(.joinRoom(request:request), completion: completion)
    }
}

enum RoomAPI {
    case createRoom(request: CreateRoomRequest)
    case roomList(request:RoomListRequest)
    case roomDetail(request:RoomDetailRequest)
    case joinRoom(request: JoinRoomRequest)
}

extension RoomAPI: TargetType {
    var method: Moya.Method {
        switch self {
        case .createRoom:
            return .post
        case .roomList:
            return .get
        case .roomDetail:
            return .get
        case .joinRoom:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .createRoom(let request):
            return .requestJSONEncodable(request)
        case .roomList:
            return .requestPlain
        case .roomDetail:
            return .requestPlain
        case .joinRoom:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case let .createRoom(request):
            return ["Authorization": "Bearer " + request.accessToken]
        case let .roomList(request):
            return ["Authorization": "Bearer " + request.accessToken]
        case let .roomDetail(request):
            return ["Authorization": "Bearer " + request.accessToken]
        case let .joinRoom(request):
            return ["Authorization": "Bearer " + request.accessToken]
        }
    }
    
    var path: String {
        switch self {
        case .createRoom:
            return "/api/room"
        case .roomList:
            return "/api/room/list"
        case .roomDetail(let request):
            return "/api/room/\(request.roomId)"
        case .joinRoom(let request):
            return "/api/room/\(request.roomId)/join"
        }
    }
}
