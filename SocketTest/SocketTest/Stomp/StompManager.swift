//
//  StompManager.swift
//  SocketTest
//
//  Created by 마경미 on 2022/05/20.
//

import StompClientLib

class StompManager {
//    static let shared:StompManager = StompManager()
    private var socketClient = StompClientLib()
    private let url = URL(string: "ws://15.164.169.48:4000/ws/websocket")!
//    var readyMessage: ReadyRoomRequest
    
    // connection
    func registerSockect() {
        socketClient.openSocketWithURLRequest(
            request: NSURLRequest(url: url),
            delegate: self,
            connectionHeaders: [ "X-AUTH-TOKEN" : UserDefaults.standard.string(forKey: "accessToken")! ]
        )
    }
    
    // subscribe
    func subscribe(memberId: Int) {
        socketClient.subscribe(destination: "/sub/member/\(memberId)")
    }
    
    // public message
    func sendMessage(senderId: CLong) {
        let payloadObject : [String : Any] = [ "type" : "READY" , "senderId" : senderId]

        socketClient.sendJSONForDict(
            dict: payloadObject as AnyObject,
            toDestination: "/pub/ready/{roodId}")
    }
    
    func disconnect() {
        socketClient.disconnect()
    }
}

extension StompManager : StompClientLibDelegate {
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("Destination : \(destination)")
        print("JSON Body : \(String(describing: jsonBody))")
        print("String Body : \(stringBody ?? "nil")")
    }
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTINATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
    }
    
    // Unsubscribe Topic
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
    }
    
    // Subscribe Topic after Connection
    func stompClientDidConnect(client: StompClientLib!) {
        print("Socket is connected")
        // Stomp subscribe will be here!
        subscribe(memberId: <#T##Int#>)
        // Note : topic needs to be a String object
    }
    
    // Error - disconnect and reconnect socket
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error Send : \(String(describing: message))")
        disconnect()
    }
    
    func serverDidSendPing() {
        print("Server ping")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
      print("Receipt : \(receiptId)")
    }
}

