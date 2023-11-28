//
//  LoginModel.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 21/10/2022.
//

import Foundation
class LoginModel {
    var id:String?
    var access_token:String?
    var refresh_token:String?
    var fileId:String?
    var success:Int?
    var role:String?
    var familyHead:LoginFamilyHead?
    var phoneVerified:Int?
    var otp:String?
    var clinicVerified:Int?
    var active:Int?
    var email :String?
    var image:String?
    var countryCode:String?
    var activeRequested:Int?
    var isExisting:Int?
    var doctorFound:logindoctorModel?
    
    init(fromData data: Json) {
       self.id = data ["id"] as? String
        self.phoneVerified = data ["phoneVerified"] as? Int
        self.access_token = data ["access_token"] as? String
        self.fileId =  data["fileId"] as? String
        self.role = data["role"] as? String
        self.success = data["success"] as? Int
        self.image = data["image"] as? String
        self.email = data["email"] as? String
        self.clinicVerified = data["clinicVerified"] as? Int
        self.isExisting = data["isExisting"] as? Int
        self.countryCode = data["countryCode"] as? String
        self.activeRequested = data["activeRequested"] as? Int
        self.refresh_token = data["refresh_token"] as? String
        if let familyhead = data["familyHead"] as? [String:Any]{
            self.familyHead = LoginFamilyHead(fromData: familyhead)
}
        if let doctor = data["doctorFound"] as? [String:Any] {
            self.doctorFound = logindoctorModel(fromData: doctor)
        }
    }
}
class logindoctorModel {
    var _id:String?
    var certifications:String?
    var education:String?
    var  email:String?
    var  firstName:String?
    var emiratesId:String?
    var gender:String?
    var lastName:String?
    var nationality:String?
    var phoneNumber:String?
    var speciality:String?
    init(fromData data: Json) {
        self._id = data["_id"] as? String
        self.certifications = data["certifications"] as? String
        self.email = data["email"] as? String
        self.firstName = data["firstName"] as? String
        self.gender = data["gender"] as? String
        self.lastName = data["lastName"] as? String
        self.nationality = data["nationality"] as? String
        self.phoneNumber = data["phoneNumber"] as? String
        self.speciality = data["speciality"] as? String
    }
}
class LoginFamilyHead {
    var _id:String?
    var assignedDoctorName:String?
    var assignedDoctorId:String?
    var assignedDoctorImage:String?
    var city:String?
    var email:String?
    var firstName:String?
    var lastName:String?
    var emiratesId:String?
    var gender:String?
    var image = [String]()
    var phoneNumber:String?
    var role:String?
    var fileNumber:String?
    init(fromData data: Json) {
        self._id = data["_id"] as? String
        self.assignedDoctorId = data["assignedDoctorId"] as? String
        self.lastName = data["lastName"] as? String
        self.emiratesId = data["emiratesId"] as? String
        self.assignedDoctorName = data["assignedDoctorName"] as? String
        self.assignedDoctorImage = data["assignedDoctorImage"] as? String
        self.city = data["city"] as? String
        self.email = data["email"] as? String
        self.firstName = data["firstName"] as? String
        self.gender = data["gender"] as? String
        self.phoneNumber = data["phoneNumber"] as? String
        self.role = data["role"] as? String
        self.fileNumber = data["fileNumber"] as? String
        if let img = data["image"]  as? [String] {
            
            for item in img {
                self.image.append(item)
                
                
            }
        }
    }
}
