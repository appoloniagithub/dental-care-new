//
//  ProfileModel.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import Foundation
class profilemodel {
    var success:Int?
    var notificationCount:Int?
    var userData: profileuserdata!
    var scans = [scansmodel]()
    
    init(fromData data:Json) {
        self.success = data["success"] as? Int
        self.notificationCount = data["notificationCount"] as? Int
        
        if let user = data["userData"] as? [String:Any]{
            self.userData = profileuserdata(fromData: user)
        }
        if let scandue = data["scans"]  as? [[String:Any]] {
            
            for item in scandue {
                self.scans.append(scansmodel(fromData: item))
            }
            
        }
    }
}
class profileuserdata {
  var id = ""
  var firstName = ""
    var lastName = ""
   var image = [String]()
  var email = ""
    var phoneNumber = ""
    var emiratesId = ""
    var fileNumber = ""
    var gender = ""
    var city = ""
    var dob = ""
    var role = ""
  
    init(fromData data: Json) {
        self.id = (data ["_id"] as? String)!
        self.firstName = (data ["firstName"] as? String)!
        self.lastName = (data["lastName"] as? String)!
        self.email = (data ["email"] as? String)!
        self.phoneNumber = (data ["phoneNumber"] as? String)!
        self.emiratesId = (data ["emiratesId"] as? String)!
        self.fileNumber = (data ["fileNumber"] as? String)!
        self.gender = (data ["gender"] as? String)!
        self.city = (data ["city"] as? String)!
        self.dob = (data ["dob"] as? String) ?? ""
        self.role = (data ["role"] as? String)!
        if let img = data["image"]  as? [String] {
           
            for item in img {
           self.image.append(item)


    
}
}
    }
    
  
}
class scansmodel{
    var scanDue:String?
    var scanType:String?
    init(fromData data: Json) {
        self.scanDue = (data ["scanDue"] as? String) ?? ""
        self.scanType = (data ["scanType"] as? String) ?? ""
       
    }
}
class image {
    
}

class membermodel {
    var success:Int?
    init(fromData data: Json) {
        self.success = data["success"] as? Int
    }
}
class CustomModel {
   
    var page:pagesmodel!
    init(fromData data: Json) {
        if let page = data["page"] as? [String:Any]{
            self.page = pagesmodel(fromData: page)
}
}
}
class pagesmodel {
    var title:String?
    var description:String?
    init(fromData data: Json) {
        self.title = data["title"] as? String
        self.description = data["description"] as? String
        
}

}
