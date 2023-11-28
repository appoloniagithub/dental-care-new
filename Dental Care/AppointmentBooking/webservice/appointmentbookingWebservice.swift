//
//  appointmentbookingWebservice.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 29/03/2023.
//

import Foundation
import KVSpinnerView
import DropDown
extension AppontmentDeptSelectionVC {
    func getbookingdata() {
//        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
//                    "lang":"en"]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/getbookingdata", methodeType: .get) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
                KVSpinnerView.dismiss()
                
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                if let data = (response["data"])as? Json{
                    self.appointmentgetmodel = Appointmentmodel(Fromdata: data)
                    self.appointmentTable.reloadData()
                }
                
                
            case .failure :
                print("failure")
                KVSpinnerView.dismiss()
                
                BannerNotification.failureBanner(message: "\(response["message"]!)")
            case .unknown:
                print("unknown")
                KVSpinnerView.dismiss()
                if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
                }else {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")

                    
                }
            }
            
        }
        
    }
    
    


}
extension AppointmentTypeVC {
    func getdoctor() {

       
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/doctors/getalldoctors", methodeType: .get,headerType: header) { (status, response) in
                print(response)
                switch status {
                case .noNetwork:
                    print("network error")
                    self.view.alpha = 1
                    self.view.isUserInteractionEnabled = true
                    BannerNotification.failureBanner(message: "No network Connection")
                    
                case .success :
                    KVSpinnerView.dismiss()
                    print("success")
                    print(response["data"])
                    if let data = (response["data"])as? Json{
                        
                        self.drmodel = Drmodel(Fromdata: data)
                        if self.drmodel?.success == 1 {
                           // self.load = 1
                         //   self.drTable.reloadData()
                        }
                        else {
                            BannerNotification.failureBanner(message:"\(response["message"]!)")
                        }
                        
                       
                            
                          
                       
                           
                            
                        }
                        
                    
                    
                    
                case .failure :
                    print("failure")
                    KVSpinnerView.dismiss()
                    
                    BannerNotification.failureBanner(message: "\(response["message"]!)")
                case .unknown:
                    print("unknown")
                    KVSpinnerView.dismiss()
                    if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")
                    }else {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")

                        
                    }
                }
                
            }
        

}

    
}
extension AppointmentdrSelectionVC {
    func bookappointment() {
       
       
       
        
        let parameters = [
            "userId":UserDefaults.standard.string(forKey: "userid") ?? "",
            "patientName":UserDefaults.standard.string(forKey: "name") ?? "",
            "phoneNumber": UserDefaults.standard.string(forKey: "phoneNumber") ?? "",
            "email": UserDefaults.standard.string(forKey: "email") ?? "",
            "emiratesId": UserDefaults.standard.string(forKey: "emiratesId") ?? "",
            "clinicName":clinicname ?? "",
            "serviceName":servicename ?? "",
            "consultationType":consultationtype ?? "" ,
            "ptime":timestring ?? "" ,
            "pdate":preffereddate ?? "",
            "PdoctorID":drID ?? ""
                
                 
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/reqbooking", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
                KVSpinnerView.dismiss()
                
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                if let data = (response["data"])as? Json{
                    self.appointmentModel = SignupModel(fromData: data)
                    if self.appointmentModel.success == 1 {
                        let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentPopUpVC")   as! AppointmentPopUpVC
                        
                       
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                    
                    
                    
                }
                
                
            case .failure :
                print("failure")
                KVSpinnerView.dismiss()
                
                BannerNotification.failureBanner(message: "\(response["message"]!)")
            case .unknown:
                print("unknown")
                KVSpinnerView.dismiss()
                if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
                }else {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")

                    
                }
            }
            
        }
        
    }
    func rescheduleappointment() {
       
        let parameters = [
            "bookingId":bookingid ?? "",
            "userId":UserDefaults.standard.string(forKey: "userid") ?? "",
            "patientName":UserDefaults.standard.string(forKey: "name") ?? "",
            "phoneNumber": UserDefaults.standard.string(forKey: "phoneNumber") ?? "",
            "email": UserDefaults.standard.string(forKey: "email") ?? "",
            "emiratesId": UserDefaults.standard.string(forKey: "emiratesId") ?? "",
            "clinicName":clinicname ?? "",
            "serviceName":servicename ?? "",
            "consultationType":consultationtype ?? "" ,
            "ptime":timestring ?? "" ,
            "pdate":preffereddate ?? ""
           ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/reschedule", methodeType: .post,parameter: parameters) { [self] (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
                KVSpinnerView.dismiss()
                
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                if let data = (response["data"])as? Json{
                  //  getallappointment()
                    
                    BannerNotification.successBanner(message: "\(response["message"]!)")
                    let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentPopUpVC")   as! AppointmentPopUpVC
                    navigationController?.pushViewController(vc, animated: true)
                   
                }
                
                
            case .failure :
                print("failure")
                KVSpinnerView.dismiss()
                
                BannerNotification.failureBanner(message: "\(response["message"]!)")
            case .unknown:
                print("unknown")
                KVSpinnerView.dismiss()
                if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
                }else {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")

                    
                }
            }
            
        }
        
    }

    func getdoctor() {

       
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/doctors/getalldoctors", methodeType: .get,headerType: header) { (status, response) in
                print(response)
                switch status {
                case .noNetwork:
                    print("network error")
                    self.view.alpha = 1
                    self.view.isUserInteractionEnabled = true
                    BannerNotification.failureBanner(message: "No network Connection")
                    
                case .success :
                    KVSpinnerView.dismiss()
                    print("success")
                    print(response["data"])
                    if let data = (response["data"])as? Json{
                        
                        self.drmodel = Drmodel(Fromdata: data)
                        if self.drmodel?.success == 1 {
                            //self.load = 1
                            self.doctortv.reloadData()
                        }
                        else {
                            BannerNotification.failureBanner(message:"\(response["message"]!)")
                        }
                        
                       
                            
                          
                       
                           
                            
                        }
                        
                    
                    
                    
                case .failure :
                    print("failure")
                    KVSpinnerView.dismiss()
                    
                    BannerNotification.failureBanner(message: "\(response["message"]!)")
                case .unknown:
                    print("unknown")
                    KVSpinnerView.dismiss()
                    if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")
                    }else {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")

                        
                    }
                }
                
            }
        

}
}

