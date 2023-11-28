//
//  SocketIOManager.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 26/12/2022.
//

import Foundation
import SocketIO
class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    var socket: SocketIOClient? = nil
    var messagemodel:MessagesModel?
   // var messagemodel:socketmodel
    var dataarray:[String:String] = [:]
    
    override init() {
        super.init()
        setupSocket()
        
        socket?.connect()
    }
    
    let manager = SocketManager(socketURL: URL(string: "http://socket.appolonia.ae:7052/")!, config: [.log(false), .compress])
    // let url = URL(string:"https://socket-uat.herokuapp.com/")
    
    //      let  manager = SocketManager(socketURL:  URL(string: "https://socket-uat.herokuapp.com/")!, config: [.log(true),.reconnects(true),.reconnectAttempts(3)])
    
    func establishConnection() {
        socket?.connect()
        
    }
    func closeConnection() {
        socket?.disconnect()
    }
    func setupSocket() {
        self.socket = manager.defaultSocket
    }
    //  , completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void)
    func connectToServerWithusername(username: String){
        socket?.emit("new-user-add", username)
        //socket?.on("SomeMessage") {  ( dataArray, ack) -> Void in
         // completionHandler(dataArray[0] as? [[String: AnyObject]])
        //  }
    }
    func sendMessage(message: String,senderId: String,receiverId:String) {
        socket?.emit("send-message", senderId, message,receiverId)
//socket?.emit("send-message", senderId)
        
    }
    
        func getChatMessage(completionHandler: @escaping  (_ messageInfo: MessagesModel) -> Void) {
            socket?.on("receive-message") { (dataarray, socketAck) -> Void in
                //var messageDictionary = [messagemodel]()
                var messagedata:[[String:Any]] = dataarray as! [[String:Any]]
                
                print(dataarray)
               // for item in dataarray {
                self.messagemodel = MessagesModel(Fromdata: messagedata[0])
              //  }
               
//                messageDictionary["conversationId"] = dataarray as? String
//                messageDictionary["message"] = dataarray as? String
//                messageDictionary["format"] = dataarray as? String
//                messageDictionary["scanId"] = dataarray as? String
//                messageDictionary["senderId"] = dataarray as? String
//                messageDictionary["receiverId"] = dataarray as? String
               // print("hagshda\(messageDictionary)")
                
                completionHandler(self.messagemodel!)
            }
        }
    func joinroom(room:String) {
       // socket?.emit("join-room",room)
        socket?.emitWithAck("join-room", with: [room]).timingOut(after: 2) { data in
            if let ackData = data[0] as? [String: Any] {
                print("Acknowledgement received:", ackData)
            }
        }
        
    }
    func joinedroom() {
        socket?.on("room-created") { (dataarray, socketAck) -> Void in
            print(dataarray)
        }
    }
    func createroom() {
        //   socket?.emit("create-room")
        //socket?.on("create-room") { (dataarray, socketAck) -> Void in
        // / socket?.on("create-room") { (dataarray, socketAck) -> Void in)
        //  print(dataarray)
        //
        //        socket?.emit("create-room") { ackData in
        //            print("Acknowledgement received:", ackData)
        //        }
        //        socket?.emit("eventName") { data, ack in
        //            if let ackData = data as? [String: Any] {
        //                print("Acknowledgement received:", ackData)
        //            }
        //        }
//        socket?.emitWithAck("create-room").timingOut(after: 0) { ack in
//            guard let ackData = ack.first as? [String: Any] else {
//                print("Acknowledgement not received")
//                return
//            }
//            print("Acknowledgement received:", ackData)
//        }
        socket?.emitWithAck("create-room").timingOut(after: 2) { data in
            if let ackData = data as? [String: Any] {
                print("Acknowledgement received:", ackData)
            }
        }


//        socket?.emitWithAck("create-room").timingOut(after: 0) { ackData in
//            if let ackData = ackData.first as? [String: Any] {
//                print("Acknowledgement received:", ackData)
//            }
//        }
    }
//        socket?.emit("eventName") { ackData in
//            guard let ackData = ackData else {
//                print("Acknowledgement not received")
//                return
//            }
//            print("Acknowledgement received:", ackData)
//        }
//    }
    
    }
class socketmodel {
    var conversationId:String?
    var message:String?
    var format:String?
    var scanId:String?
    var senderId:String?
    var receiverId:String?
    var roomname:String?
    init(fromData dataArray: Json) {
        self.senderId = dataArray["senderId"] as? String
        self.conversationId = dataArray["conversationId"] as? String
        self.format = dataArray["format"] as? String
        self.scanId = dataArray["scanId"] as? String
        self.receiverId = dataArray["receiverId"] as? String
        
        self.message = dataArray["message"] as? String
    }
}
    //    func setupSocketEvents() {
    //        socket?.on(clientEvent: .connect) {data, ack in
    //            print("Connected")
    //        }
    //
    //                    socket?.on("login") { (data, ack) in
    //                        guard let dataInfo = data.first else { return }
    //                        if let response: SocketLogin = try? SocketParser.convert(data: dataInfo) {
    //                            print("Now this chat has \(response.numUsers) users.")
    //                        }
    //                    }
    //
    //                    socket?.on("user joined") { (data, ack) in
    //                        guard let dataInfo = data.first else { return }
    //                        if let response: SocketUserJoin = try? SocketParser.convert(data: dataInfo) {
    //                            print("User '\(response.username)' joined...")
    //                            print("Now this chat has \(response.numUsers) users.")
    //                        }
    //                    }
    //
    //                    socket?.on("user left") { (data, ack) in
    //                        guard let dataInfo = data.first else { return }
    //                        if let response: SocketUserLeft = try? SocketParser.convert(data: dataInfo) {
    //                            print("User '\(response.username)' left...")
    //                            print("Now this chat has \(response.numUsers) users.")
    //                        }
    //                    }
    //
    //                    socket?.on("new message") { (data, ack) in
    //                        guard let dataInfo = data.first else { return }
    //                        if let response: SocketMessage = try? SocketParser.convert(data: dataInfo) {
    //                            print("Message from '\(response.username)': \(response.message)")
    //                        }
    //                    }
    //
    //                    socket?.on("typing") { (data, ack) in
    //                        guard let dataInfo = data.first else { return }
    //                        if let response: SocketUserTyping = try? SocketParser.convert(data: dataInfo) {
    //                            print("User \(response.username) is typing...")
    //                        }
    //                    }
    //
    //                    socket?.on("stop typing") { (data, ack) in
    //                        guard let dataInfo = data.first else { return }
    //                        if let response: SocketUserTyping = try? SocketParser.convert(data: dataInfo) {
    //                            print("User \(response.username) stopped typing...")
    //                        }
    //                    }
    //                }
    //
    //
    ////
    //

