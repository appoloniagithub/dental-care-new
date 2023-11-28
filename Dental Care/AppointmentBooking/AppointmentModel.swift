//
//  AppointmentModel.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 29/03/2023.
//

import Foundation

class Appointmentmodel {
    var clinic = [clinicmodel]()
    var services = [String]()
    

    init(Fromdata data:[String:Any]) {
        if let clinicitem = data["clinic"]  as? [[String:Any]] {
            for item in clinicitem {
              
                self.clinic.append(clinicmodel(Fromdata: item))
        }
        }
        if let service = data["services"]  as? [String] {
            
            for item in service {
                self.services.append(item)
                
                
            }
        }

    }

}
class clinicmodel {
    var city:String?
    var clinicLogo:String?
    var clinicName:String?
    var address:String?
    var __v:String?
    var _id:String?
    var fcmKey:String?
    var  forceUpdate:String?
    var version:String?
    init(Fromdata data:[String:Any]) {
        self._id = data["_id"] as? String
        self.__v = data["__v"] as? String
        self.address = data["address"] as? String
        self.city = data["city"] as? String
        self.clinicName = data["clinicName"] as? String
        self.fcmKey = data["fcmKey"] as? String
        self.forceUpdate = data["forceUpdate"] as? String
        self.version = data["version"] as? String
        
    }
}
class appointmentListModel {
    var allBookings = [allbookingModel]()
    var pendingbooking = [pendingbookingModel]()
    var finshedbooking = [finshedbookingModel]()
    var confirmedbooking = [confirmedbookingModel]()
    var cancelledbooking = [cancelledbookingModel]()
   
    var success:Int?
    init(Fromdata data:[String:Any]) {
        if let bookingitem = data["allBookings"]  as? [[String:Any]] {
            for item in bookingitem {
                
                self.allBookings.append(allbookingModel(Fromdata: item))
            }
            if let pendingbookingitem = data["pending"]  as? [[String:Any]] {
                for item in pendingbookingitem {
                    
                    self.pendingbooking.append(pendingbookingModel(Fromdata: item))
                }
            }
            if let cancelledbookingitem = data["cancelled"]  as? [[String:Any]] {
                for item in cancelledbookingitem {
                    
                    self.cancelledbooking.append(cancelledbookingModel(Fromdata: item))
                }
            }
            if let finshedbookingitem = data["finished"]  as? [[String:Any]] {
                for item in finshedbookingitem {
                    
                    self.finshedbooking.append(finshedbookingModel(Fromdata: item))
                }
                
            }
            if let confirmbookingbookingitem = data["confirmed"]  as? [[String:Any]] {
                for item in confirmbookingbookingitem {
                    
                    self.confirmedbooking.append(confirmedbookingModel(Fromdata: item))
                }
                
            }
        }
    }
}
class allbookingModel {
    var _id:String?
    var clinicName:String?
    var  consultationType:String?
    var createdAt:String?
    var email:String?
    var patientName:String?
    var phoneNumber:String?
    var image:String?
    var serviceName:String?
    var doctorName:String?
    var roomId:String?
    var status:String?
    var updatedAt:String?
    var time:String?
    var date:String?
    var userId:String?
    init(Fromdata data:[String:Any]) {
        self._id = data["_id"] as? String
        self.clinicName = data["clinicName"] as? String
        self.consultationType = data["consultationType"] as? String
        self.createdAt = data["createdAt"] as? String
        self.doctorName = data["doctorName"] as? String
        self.date = data["date"] as? String
        self.time = data["time"] as? String
        self.image = data["image"] as? String
        self.email = data["email"] as? String
        self.roomId = data["roomId"] as? String
        self.patientName = data["patientName"] as? String
        self.phoneNumber = data["phoneNumber"] as? String
        self.serviceName = data["serviceName"] as? String
        self.status = data["status"] as? String
        self.updatedAt = data["updatedAt"] as? String
        self.userId = data["userId"] as? String
        
    }
}
class confirmedbookingModel {
    var _id:String?
    var clinicName:String?
    var  consultationType:String?
    var createdAt:String?
    var email:String?
    var patientName:String?
    var phoneNumber:String?
    var image:String?
    var serviceName:String?
    var doctorName:String?
    var roomId:String?
    var status:String?
    var updatedAt:String?
    var time:String?
    var date:String?
    var userId:String?
    init(Fromdata data:[String:Any]) {
        self._id = data["_id"] as? String
        self.clinicName = data["clinicName"] as? String
        self.consultationType = data["consultationType"] as? String
        self.createdAt = data["createdAt"] as? String
        self.doctorName = data["doctorName"] as? String
        self.date = data["date"] as? String
        self.time = data["time"] as? String
        self.image = data["image"] as? String
        self.email = data["email"] as? String
        self.roomId = data["roomId"] as? String
        self.patientName = data["patientName"] as? String
        self.phoneNumber = data["phoneNumber"] as? String
        self.serviceName = data["serviceName"] as? String
        self.status = data["status"] as? String
        self.updatedAt = data["updatedAt"] as? String
        self.userId = data["userId"] as? String
        
    }
}
class cancelledbookingModel {
    var _id:String?
    var clinicName:String?
    var  consultationType:String?
    var createdAt:String?
    var email:String?
    var patientName:String?
    var phoneNumber:String?
    var image:String?
    var serviceName:String?
    var doctorName:String?
    var roomId:String?
    var status:String?
    var updatedAt:String?
    var time:String?
    var date:String?
    var userId:String?
    init(Fromdata data:[String:Any]) {
        self._id = data["_id"] as? String
        self.clinicName = data["clinicName"] as? String
        self.consultationType = data["consultationType"] as? String
        self.createdAt = data["createdAt"] as? String
        self.doctorName = data["doctorName"] as? String
        self.date = data["date"] as? String
        self.time = data["time"] as? String
        self.image = data["image"] as? String
        self.email = data["email"] as? String
        self.roomId = data["roomId"] as? String
        self.patientName = data["patientName"] as? String
        self.phoneNumber = data["phoneNumber"] as? String
        self.serviceName = data["serviceName"] as? String
        self.status = data["status"] as? String
        self.updatedAt = data["updatedAt"] as? String
        self.userId = data["userId"] as? String
        
    }
}
class pendingbookingModel {
    var _id:String?
    var clinicName:String?
    var  consultationType:String?
    var createdAt:String?
    var email:String?
    var patientName:String?
    var phoneNumber:String?
    var image:String?
    var ptime:String?
    var pdate:String?
    var serviceName:String?
    var doctorName:String?
    var roomId:String?
    var status:String?
    var updatedAt:String?
    var time:String?
    var date:String?
    var userId:String?
    init(Fromdata data:[String:Any]) {
        self._id = data["_id"] as? String
        self.clinicName = data["clinicName"] as? String
        self.consultationType = data["consultationType"] as? String
        self.createdAt = data["createdAt"] as? String
        self.doctorName = data["doctorName"] as? String
        self.date = data["date"] as? String
        self.time = data["time"] as? String
        self.image = data["image"] as? String
        self.email = data["email"] as? String
        self.pdate = data["pdate"] as? String
        self.ptime = data["ptime"] as? String
        self.roomId = data["roomId"] as? String
        self.patientName = data["patientName"] as? String
        self.phoneNumber = data["phoneNumber"] as? String
        self.serviceName = data["serviceName"] as? String
        self.status = data["status"] as? String
        self.updatedAt = data["updatedAt"] as? String
        self.userId = data["userId"] as? String
        
    }
}
class finshedbookingModel {
    var _id:String?
    var clinicName:String?
    var  consultationType:String?
    var createdAt:String?
    var email:String?
    var patientName:String?
    var phoneNumber:String?
    var image:String?
    var serviceName:String?
    var doctorName:String?
    var roomId:String?
    var status:String?
    var updatedAt:String?
    var time:String?
    var date:String?
    var userId:String?
    init(Fromdata data:[String:Any]) {
        self._id = data["_id"] as? String
        self.clinicName = data["clinicName"] as? String
        self.consultationType = data["consultationType"] as? String
        self.createdAt = data["createdAt"] as? String
        self.doctorName = data["doctorName"] as? String
        self.date = data["date"] as? String
        self.time = data["time"] as? String
        self.image = data["image"] as? String
        self.email = data["email"] as? String
        self.roomId = data["roomId"] as? String
        self.patientName = data["patientName"] as? String
        self.phoneNumber = data["phoneNumber"] as? String
        self.serviceName = data["serviceName"] as? String
        self.status = data["status"] as? String
        self.updatedAt = data["updatedAt"] as? String
        self.userId = data["userId"] as? String
    }
}
class appointmentbookingModel {
    var booking = [AppointmentdetailModel]()
    var success:Int?
    var date:String?
    var time:String?
    init(Fromdata data:[String:Any]) {
        self.success = data["success"] as? Int
        self.date = data["date"] as? String
        self.time = data["time"] as? String
        if let bookingitem = data["booking"]  as? [[String:Any]] {
            for item in bookingitem {
              
                self.booking.append(AppointmentdetailModel(Fromdata: item))
        }
        }
    }
}

class AppointmentdetailModel {
    var _id:String?
    var clinicName:String?
    var consultationType:String?
    var createdAt:String?
    var date:String?
    var doctorId:String?
    var doctorName:String?
    var email:String?
    var patientName:String?
    var phoneNumber:String?
    var time:String?
    var serviceName:String?
    var status:String?
    init(Fromdata data:[String:Any]) {
        self._id = data["_id"] as? String
        self.clinicName = data["clinicName"] as? String
        self.consultationType = data["consultationType"] as? String
        self.createdAt = data["createdAt"] as? String
        self.date = data["date"] as? String
        self.doctorId = data["doctorId"] as? String
        self.doctorName = data["doctorName"] as? String
        self.email = data["email"] as? String
        self.patientName = data["patientName"] as? String
        self.phoneNumber = data["phoneNumber"] as? String
        self.time = data["time"] as? String
        self.serviceName = data["serviceName"] as? String
        self.status = data["status"] as? String
        
    }
  
}
