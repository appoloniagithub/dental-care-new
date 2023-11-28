//
//  OTPwebService.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 24/10/2022.
//

import Foundation
import KVSpinnerView
extension OTPVC {
    func verifyotpforgot() {
        let parameters = [
            "fileId":fileid!,
            "otp":OTPTF.text!
        ] as [String : Any]
       
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/verifyforgototp", methodeType: .post,parameter: parameters) { (status, response) in
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
                    self.verifymodel = Verifymodel(fromData: data)
                    if self.verifymodel?.success == 1 {
                        BannerNotification.successBanner(message: "\(response["message"]!)")
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SetPasswordVC") as! SetPasswordVC
                        vc.fromforgot = true
                        vc.fileID = self.fileid
                        vc.otp = self.OTPTF.text
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        BannerNotification.successBanner(message: "\(response["message"]!)")
                    }else {
                        BannerNotification.failureBanner(message: "\(response["message"]!)")
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
    func verifyotp() {
        let parameters = [
            "fileId":fileid!,
            "otp":OTPTF.text!
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/phoneverify", methodeType: .post,parameter: parameters) { (status, response) in
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
                    self.verifymodel = Verifymodel(fromData: data)
                    if self.verifymodel?.success == 1 {
                        if self.fromdelete == true {
                            self.deleteaccount()
                        }else {
                            BannerNotification.successBanner(message:  "\(response["message"]!)")
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                            
                            self.navigationController?.navigationBar.isHidden = true
                            self.navigationController?.pushViewController(vc, animated: true)
                            BannerNotification.successBanner(message: "\(response["message"]!)")
                        }
                    }else {
                        BannerNotification.failureBanner(message: "\(response["message"]!)")
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
    func resendotp() {
        let parameters = [
            "fileId":fileid!,
            
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/newotp", methodeType: .post,parameter: parameters) { (status, response) in
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
    func requstPassword() {
        
        
        
        
        
        
        let parameters = [
            "phoneNumber":phoneno!
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/forgotpassword", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                KVSpinnerView.dismiss()
                BannerNotification.failureBanner(message: "No network Connection")
                print("network error")
                
                
            case .success :
                KVSpinnerView.dismiss()
                print("success")
                
                if let data = (response["data"])as? Json{
                    BannerNotification.successBanner(message: "\(response["message"]!)")
                    
                    
                }
                
                
            case .failure :
                print("failure")
                
                KVSpinnerView.dismiss()
                BannerNotification.failureBanner(message: "\(response["message"]!)")
            case .unknown:
                print("unknown")
                if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
                }else {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")

                    
                }
            }
            
        }    }
    
    
    
    func deleteotp() {
        let parameters = [
            "fileId":UserDefaults.standard.string(forKey: "fileID")!,
            
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/newotp", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                KVSpinnerView.dismiss()
                
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                if let data = (response["data"])as? Json{
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
    func deleteaccount() {
        
        let parameters = [
            "fileId":UserDefaults.standard.string(forKey: "fileID")!
            
        ] as [String : Any]
        
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/deleteaccount", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                KVSpinnerView.dismiss()
                BannerNotification.failureBanner(message: "No network Connection")
                print("network error")
                
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                //      print(response["data"]!)
                if let data = response["data"] as? Json{
                    UserDefaults.standard.set("", forKey: "fileID")
                    UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                    UserDefaults.standard.set("", forKey: "userid")
                    BannerNotification.successBanner(message: "\(response["message"]!)")
                    let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "LoginVC")   as! LoginVC
                    self.navigationController?.navigationBar.isHidden = true
                    self.navigationController?.pushViewController(vc, animated: false)
                    
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
            
        }    }
    func verifyOtpDelete() {
        let parameters = [
            "fileId":UserDefaults.standard.string(forKey: "fileID")!,
            "otp":OTPTF.text!
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/phoneverify", methodeType: .post,parameter: parameters) { (status, response) in
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
                    self.verifymodel = Verifymodel(fromData: data)
                    if self.verifymodel?.success == 1 {
                        if self.fromdelete == true {
                            self.deleteaccount()
                        }else {
                            BannerNotification.successBanner(message: "\(response["message"]!)")
//                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//                            self.navigationController?.hidesBottomBarWhenPushed = true
//                            self.navigationController?.navigationBar.isHidden = true
//                            self.navigationController?.tabBarController?.tabBar.isHidden = true
//                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
                    }else {
                        BannerNotification.failureBanner(message: "\(response["message"]!)")
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
