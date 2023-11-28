//
//  ChatModel.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import Foundation
class ChatModel {
    var  conversations = [ConversationModel]()
    var updatedAt:String?
    init(Fromdata data:[String:Any]) {
        self.updatedAt = data["updatedAt"] as? String
        if let conver = data["conversations"]  as? [[String:Any]] {
            for item in conver {
            self.conversations.append(ConversationModel(fromData: item))
        }
        }
        
        
}
}
class ConversationModel {
    var  conversationId:String?
    var updatedAt:String?
    var otherMemberId:String?
    var lastMessage:String?
    var lastName:String?
    var lastImage:String?
    var chatCount:Int?
    var lastReceiverId:String?
    var otherMemberData:MemberDataModel?
    init(fromData data: [String:Any]) {
        self.conversationId = data["conversationId"] as? String
        self.otherMemberId = data["otherMemberId"] as? String
        self.updatedAt = data["updatedAt"]as? String
        self.lastName = data["lastName"] as? String
        self.lastMessage = data["lastMessage"] as? String
        self.chatCount = data["chatCount"] as? Int
        self.lastReceiverId = data["lastReceiverId"] as? String
        self.lastImage = data["lastImage"] as? String
        if let memb = data["otherMemberData"] as? [String:Any]{
            self.otherMemberData = MemberDataModel(fromData: memb)
        
    }
}
}
class MemberDataModel {
    var id:String?
    var image = [String]()
    var name:String?
    init(fromData data: [String:Any]) {
        //self.image = data["image"] as? String
        self.id = data["id"] as? String
        self.name = data["name"] as? String
        if let img = data["image"]  as? [String] {
           
            for item in img {
           self.image.append(item)


    
}
}
    }
}
class chatmodel {
    var messages = [MessagesModel]()
 public init(Fromdata data:[String:Any]) {
        if let msg = data["messages"]  as? [[String:Any]] {
            for item in msg {
                self.messages.append(MessagesModel(Fromdata: item))
        }
        }
}
}
class MessagesModel {
    
  
        var _id:String?
        var conversationId:String?
        var senderId:String?
        var message:String?
        var format:String?
        var createdAt:String?
        var updatedAt:String?
        var __v:Int?
       var scanId:String?
        var  isSender:String?
    init(Fromdata data:[String:Any]) {
        self.conversationId = data["conversationId"] as? String
        self._id = data["_id"] as? String
        self.updatedAt = data["updatedAt"] as? String
        self.senderId = data["senderId"] as? String
        self.message = data["message"] as? String
        self.format = data["format"] as? String
        self.createdAt = data["createdAt"] as? String
        self.__v = data["__v"] as? Int
        self.isSender =  data["isSender"] as? String
        self.scanId = data["scanId"] as? String
    }
}
class messagedatamodel {
    
    var data = [messagedatamodels]()
    var  success:String?
    init(Fromdata data:[String:Any]) {
        if let item = data["data"]  as? [[String:Any]] {
            for items in item {
                self.data.append(messagedatamodels(Fromdata: items))
            }
        }
        
    }
}
class messagedatamodels {
    var conversationId:String?
    var createdAt:String?
    var format:String?
    var message:String?
    var  senderId:String?
    var  updatedAt:String?
    var name:String?
    
    init(Fromdata data:[String:Any]) {
        self.conversationId = data["conversationId"] as? String
        self.createdAt = data["createdAt"] as? String
        self.format = data["format"] as? String
        self.message = data["message"] as? String
        self.senderId = data["senderId"] as? String
        self.name = data["name"] as? String
    }
}



class librarymodel {
    var articles = [articlesmodel]()

    init(Fromdata data:[String:Any]) {
        if let articleitem = data["articles"]  as? [[String:Any]] {
            for item in articleitem {
            self.articles.append(articlesmodel(fromData: item))
        }
        }
    }

}
class articlesmodel {

        var _id:String
        var name:String
        var description:String
       var author:authormodel!
        var created :String
        var image = [String]()
    
        init(fromData data: [String:Any]) {
            self._id = data["_id"] as! String
            self.name = data ["title"] as! String
            self.description =  data["description"] as! String
            self.created = data["created"] as! String
            //self.image = data["image"] as! String
            if let authr = data["author"] as? [String:Any]{
                self.author = authormodel(fromData: authr)
            
            
    }
            if let img = data["image"]  as? [String] {
               
                for item in img {
               self.image.append(item)


        
    }
    }
    }
                                            }
class authormodel {
    var authorName:String
//var authorImage:String
    init(fromData data: [String:Any]) {
        self.authorName = data["authorName"] as! String
       // self.authorImage = data["authorImage"] as! String
    }
}
class chatdoctormodel {
    var success:Int
  //  var doctorData = [doctordatachatmodel]()
    var doctorData:doctordatachatmodel?
    init(fromData data:[String:Any]) {
        if let dr = data["doctorData"] as? [String:String]{
            self.doctorData = doctordatachatmodel(fromData: dr)


}
//        if let doctrdata = data["doctorData"]  as? [[String:Any]] {
//            for item in doctrdata {
//                self.doctorData.append(doctordatachatmodel(fromData: item))
//            }
//        }
        self.success = data["success"]  as! Int
    }
}
class doctordatachatmodel {
    var name:String
    var image = [String]()
    init(fromData data:[String:Any]) {
        self.name = data["name"] as! String
        if let img = data["image"]  as? [String] {
            
            for item in img {
                self.image.append(item)
                
                
                
            }
        }
        
        
    }
}

