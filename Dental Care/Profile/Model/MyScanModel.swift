//
//  MyScanModel.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 28/10/2022.
//

import Foundation

class myscanmodel {
    var scans = [scanmodel]()
    var success:Int?
    init(Fromdata data:[String:Any]) {
        self.success = data["success"] as? Int
        if let scanimage = data["scans"]  as? [[String:Any]] {
            
            for item in scanimage {
                self.scans.append(scanmodel(Fromdata: item))
        }

}
    }
}
class scanmodel {
    var _id:String?
    var userId:String?
    var doctorId:String?
    var doctorName:String?
    var logo:String?
    var created:String?
    var faceScanImages = [String]()
    var teethScanImages = [String]()    //    [ScanedImageModel]()
    init(Fromdata data:[String:Any]) {
        self._id = data["_id"] as? String
        self.doctorId = data["doctorId"] as? String
        self.doctorName = data["doctorName"] as? String
        self.userId = data["userId"] as? String
        self.created = data["created"] as? String
        self.logo = data["logo"] as? String
        if let img = data["faceScanImages"]  as? [String] {
           
            for item in img {
           self.faceScanImages.append(item)


    
}
}
        if let teethimage = data["teethScanImages"]  as? [String] {
            for item in teethimage {
                self.teethScanImages.append(item)
            }
        }
    }
}
class familymodel {
    var foundFamily = [familymembermodel]()

    init(Fromdata data:[String:Any]) {
        if let item = data["foundFamily"]  as? [[String:Any]] {
            for itms in item {
            self.foundFamily.append(familymembermodel(fromData: itms))
        }
        }
    }
}

class familymembermodel {
    var firstName:String?
    var lastName:String?
    var fileNumber:String?
    var emiratesId :String?
    var userId :String?
    var image = [String]()
    var assignedDoctorId:String?
    var assignedDoctorName:String?
    var city:String?
    var email:String?
    var gender:String?
    var phoneNumber:String?
    
    
    init(fromData data: [String:Any]) {
        self.firstName = data["firstName"] as? String
        self.lastName = data ["lastName"] as? String
        self.fileNumber =  data["fileNumber"] as? String
        self.emiratesId = data["emiratesId"] as? String
        self.userId = data["userId"] as? String
        
        self.assignedDoctorId = data["assignedDoctorId"] as? String
        self.assignedDoctorName = data["assignedDoctorName"] as? String
        self.city = data["city"] as? String
        self.email = data["email"] as? String
        self.gender = data["gender"] as? String
        self.phoneNumber = data["phoneNumber"] as? String
        if let img = data["image"]  as? [String] {
            
            for item in img {
                self.image.append(item)
                
                
            }
        }

}
}
class Drmodel {
    var doctors = [drlist]()
    var success:Int?
    init(Fromdata data:[String:Any]) {
        self.success = data["success"] as? Int
        if let item = data["doctors"]  as? [[String:Any]] {
            for itms in item {
            self.doctors.append(drlist(fromData: itms))
        }
    
}
    }
}
class drlist {
    var _id:String?
    var firstName:String?
    var lastName:String?
    var speciality:String?
    var departmentNumber:String?
    var role:String?
    var image = [String]()
    init(fromData data: Json) {
        self._id = data["_id"] as? String
        self.firstName = data["firstName"] as? String
        self.lastName = data["lastName"] as? String
        self.departmentNumber = data["departmentNumber"] as? String
        self.role = data["role"] as? String
        self.speciality = data["speciality"] as? String
        if let img = data["image"]  as? [String] {
           
            for item in img {
           self.image.append(item)


    
}
}
    }
}


