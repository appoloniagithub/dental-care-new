//
//  NotificationModel.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 16/03/2023.
//

import Foundation
class NotificationModel {
    var allNotifications = [AllNotificationsModel]()
    var success:Int
    init(fromData data: [String:Any]) {
        self.success = data["success"] as? Int ?? 1
        if let noti = data["allNotifications"]  as? [[String:Any]] {
            for item in noti {
            self.allNotifications.append(AllNotificationsModel(fromData: item))
        }
        }
    }
}
class AllNotificationsModel {
    var _id:String?
    var actionId:String?
    var actionName:String?
    var  body:String?
    var isRead:String?
    var title:String?
    var userId:String?
    var created:String?
    
    init(fromData data: [String:Any]) {
        self._id = data["_id"] as? String
        self.actionId = data["actionId"] as? String
        self.actionName = data["actionName"] as? String
        self.body = data["body"] as? String
        self.isRead = data["isRead"] as? String
        self.title = data["title"] as? String
        self.userId = data["userId"] as? String
        self.created = data["created"] as? String
    }
}
