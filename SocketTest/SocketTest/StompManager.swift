////
////  StompManager.swift
////  SocketTest
////
////  Created by 마경미 on 2022/05/20.
////
//
//import StompClientLib
//
//class StompManager {
////    static let shared:StompManager = StompManager()
////
//    var roomId = "0"
//    private let url = URL(string: "ws://3.39.224.239:8080/websocket")!
//    private var socketClient = StompClientLib()
//    
//    func registerSocket() {
//        if socketClient == nil {
//            socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url), delegate: self)
//        }
//    }
//    
//    func subscribe() {
//        print("Subscribe Topic")
//        socketClient.subscribe(destination: "/sub/chat/" + roomId)
//    }
//    
//    // public message
//    func sendMessage() {
//        var payloadObject : [String : Any] = [ Key 1 : Value 1 , ... , Key N, Value N ]
//
//        socketClient.sendJSONForDict(
//            dict: payloadObject as AnyObject,
//            toDestination: "/pub/chat/message")
//    }
//    
//    func disconnect() {
//        socketClient.disconnect()
//    }
//}
//
//extension StompManager: StompClientLibDelegate {
//    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
//        print("Receipt : \(receiptId)")
//    }
//    
//    func serverDidSendPing() {
//        print("Server ping")
//    }
//    
//    func stompClientDidConnect(client: StompClientLib!) {
//        print("socket is connected")
//        subscribe()
//    }
//    
//    func stompClientDidDisconnect(client: StompClientLib!) {
//        print("socket is disconnected")
//    }
//    
//    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
//        print("Error send : " + description)
//        
//        socketClient.disconnect()
//        registerSocket()
//    }
//    
//    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
//        print("Destination : \(destination)")
//        print("JSON Body : \(String(describing: jsonBody))")
//        print("String Body : \(stringBody ?? "nil")")
//        
//        
//        guard let JSON = jsonBody as? [String : AnyObject] else { return }
//
//        guard let innerJSON_Message = JSON ["message"] else {return}
//        guard let innerJSON_Member = JSON ["member"] else {return}
//
//        let newMsg = Message(
//            member:
//                Sender(
//                    memberId: innerJSON_Member["memberId"] as? Int ?? -1,
//                    username: innerJSON_Member["username"] as? String ?? "",
//                    description: innerJSON_Member["description"] as? String ?? "",
//                    profileImage: innerJSON_Member["profileImage"] as? String ?? ""
//                ),
//            message :
//                MessageContents(
//                    messageId: lastMessageId + 1,
//                    message: innerJSON_Message["message"] as? String ?? "",
//                    image: innerJSON_Message["image"] as? String ?? "",
//                    createdAt: "\(Date(timeIntervalSinceNow: 32400))"
//                )
//        )
//        lastMessageId += 1
//        MessageList.append(newMsg)
//    }
//    
//    func stompClientJSONBody(
//        client: StompClientLib!,
//        didReceiveMessageWithJSONBody jsonBody: String?,
//        withHeader header: [String : String]?,
//        withDestination destination: String
//    ) {
//    }
//}
