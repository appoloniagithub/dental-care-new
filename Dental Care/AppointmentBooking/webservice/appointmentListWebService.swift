//
//  appointmentListWebService.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 06/04/2023.
//

import Foundation
import KVSpinnerView
extension AppointmentAllBookVC {
    func getallappointment() {
       
       
       
        
        let parameters = [
            "userId":UserDefaults.standard.string(forKey: "userid") ?? ""
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/getallbookings", methodeType: .post,parameter: parameters) { (status, response) in
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
                    self.appointmentgetmodel = appointmentListModel(Fromdata: data)
                    let indexPath = IndexPath(row: 0, section: 0)
                    if let cell = self.appointmentTable.cellForRow(at: indexPath) as? AppointmentemptyTVC {
                        cell.statusLabel.isHidden = false
                        }
                  
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
    func getremotetiming() {
       
    
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/remote", methodeType: .get) { (status, response) in
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
                    self.appointmentgetmodel = appointmentListModel(Fromdata: data)
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
extension AppointmentBookingDetailVC {
    func rescheduleappointment() {
       
        let parameters = [
            "bookingId":bookingId ?? ""
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
                self.detailModel = appointmentbookingModel(Fromdata: data)
                    
                    BannerNotification.successBanner(message: "\(response["message"]!)")
                    
                    
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
    func getappointmentdetail() {
       
       
       
        
        let parameters = [
            "bookingId":bookingId ?? ""
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/showbookingdetails", methodeType: .post,parameter: parameters) { [self] (status, response) in
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
                self.detailModel = appointmentbookingModel(Fromdata: data)
                    if self.detailModel?.success == 1 {
                        if self.detailModel?.booking[self.indexpath?.row ?? 0].status == "Confirmed" {
//                            self.statusLabel.textColor = UIColor.green
//                            self.statusLabel.text = detailModel?.booking[indexpath?.row ?? 0].status
                            self.timeLabel.text = "Time: \(self.detailModel?.time ?? "")"
                            self.dateLabel.text = "Date: \(self.detailModel?.date ?? "")"
                            
                            self.doctorNameLabel.text = "Doctor Name: \(self.detailModel?.booking[self.indexpath?.row ?? 0].doctorName ?? "")"
                            patientNameLabel.text = "Patient Name: \(self.detailModel?.booking[self.indexpath?.row ?? 0].patientName ?? "")"
                            patientEmailLabel.text = "Email: \(self.detailModel?.booking[self.indexpath?.row ?? 0].email ?? "")"
                            patientPhoneNumberLabel.text = "Phone No: \(self.detailModel?.booking[self.indexpath?.row ?? 0].phoneNumber ?? "")"
                            clinicNameLabel.text = "Clinic Name: \(self.detailModel?.booking[self.indexpath?.row ?? 0].clinicName ?? "")"
                            consultationtypeLabel.text =  "Consultation Type: \(self.detailModel?.booking[self.indexpath?.row ?? 0].consultationType ?? "")"
                            serviceNameLabel.text = "Service: \(self.detailModel?.booking[self.indexpath?.row ?? 0].serviceName ?? "")"

                            
                        }else {
                            //doctorView.isHidden = true
                          //  timeLabel.isHidden = true
                          //  dateLabel.isHidden = true
//                            statusLabel.textColor = UIColor.red
//                            statusLabel.text =  detailModel?.booking[indexpath?.row ?? 0].status
                            doctorNameLabel.text = "Doctor Name: Not assigned"
                            timeLabel.text = "Date: Not assigned"
                            dateLabel.text = "Time: Not assigned"
                            doctorNameLabel.textColor = UIColor.red
                            timeLabel.textColor = UIColor.red
                            dateLabel.textColor = UIColor.red
                            patientNameLabel.text = "Patient Name: \(self.detailModel?.booking[self.indexpath?.row ?? 0].patientName ?? "")"
                            patientEmailLabel.text = "Email: \(self.detailModel?.booking[self.indexpath?.row ?? 0].email ?? "")"
                            patientPhoneNumberLabel.text = "Phone No: \(self.detailModel?.booking[self.indexpath?.row ?? 0].phoneNumber ?? "")"
                            clinicNameLabel.text = "Clinic Name: \(self.detailModel?.booking[self.indexpath?.row ?? 0].clinicName ?? "")"
                            consultationtypeLabel.text =  "Consultation Type: \(self.detailModel?.booking[self.indexpath?.row ?? 0].consultationType ?? "")"
                            serviceNameLabel.text = "Service: \(self.detailModel?.booking[self.indexpath?.row ?? 0].serviceName ?? "")"
                            
                            
                        }
                        
                        
                       
                        
                        
                        
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
    func deleteappointment() {
       
       
       
        
        let parameters = [
            "bookingId":bookingId ?? ""
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/deletebooking", methodeType: .post,parameter: parameters) { [self] (status, response) in
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
                self.detailModel = appointmentbookingModel(Fromdata: data)
                    
                    BannerNotification.failureBanner(message: "\(response["message"]!)")
                    navigationController?.popViewController(animated: false)
                    delegate?.reloadtable()
                    
                    
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
extension AppointmentAllBookVC {
    func cancelappointment() {
       
       
       
        
        let parameters = [
            "bookingId":bookingId ?? ""
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/cancelbooking", methodeType: .post,parameter: parameters) { [self] (status, response) in
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
                    getallappointment()
                    
                    BannerNotification.failureBanner(message: "\(response["message"]!)")
                    //navigationController?.popViewController(animated: false)
                   // delegate?.reloadtable()
                    
                    
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
            "bookingId":bookingId ?? ""
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
                    getallappointment()
                    
                    BannerNotification.successBanner(message: "\(response["message"]!)")
                    
                    
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
