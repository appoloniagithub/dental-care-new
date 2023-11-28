//
//  SignUPModel.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 21/10/2022.
//

import Foundation
class CheckPatientModel {
    var success:Int?
    var fileId:String? = ""
    var message:String? = ""
    var isExisting:Int?
    var clinicVerified:Int?
    var active:Int?
    var activeRequested:Int?
    var phoneVerified:Int?
    init(fromData data: Json) {
        self.success = data ["success"] as? Int
        self.fileId = data ["fileId"] as? String
        self.message =  data["message"] as? String
        self.isExisting = data ["isExisting"] as? Int
        self.clinicVerified = data ["clinicVerified"] as? Int
        self.active = data ["active"] as? Int
        self.phoneVerified = data ["phoneVerified"] as? Int
        self.activeRequested = data ["activeRequested"] as? Int

}

}
class SignupModel {
    var success:Int?
    var fileId:String?
     init(fromData data: Json) {
            self.success = data ["success"] as? Int
            self.fileId = data["fileId"] as? String
           
        
        
    }
}
class Verifymodel {
    var success:Int?
    init(fromData data: Json) {
    self.success = data["success"] as? Int
    }
}
class forgotmodel {
    var fileId:String?
    var success:Int?
    init(fromData data: Json) {
        self.fileId = data["fileId"] as? String
        self.success = data["success"] as? Int
}
}
class passwordmodel {
    var success:Int?
    init(fromData data: Json) {
    self.success = data["success"] as? Int
}
}
