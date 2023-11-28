//
//  ForgotPasswordWebservice.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 24/10/2022.
//

import Foundation
import KVSpinnerView
extension ForgotPasswordPhoneVC {
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
                    self.model = forgotmodel(fromData: data)
                    if self.model!.success == 1 {
                        BannerNotification.successBanner(message: "\(response["message"]!)")
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                       vc.fileid = self.model?.fileId
                       vc.isfromforgot = true
                        vc.phoneno = self.phoneno
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        BannerNotification.successBanner(message: "\(response["message"]!)")
                      
                    }
                    else {
                        BannerNotification.failureBanner(message: "\(response["message"]!)")
                    }
                    
                    
                    
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

}
extension SetPasswordVC {
    func newpassword() {
        let parameters = [
            "fileId":fileID!,
            "recentOtp":otp!,
            "newPassword":newPasswordTF.text!
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/newpasswordforgot", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                KVSpinnerView.dismiss()
                BannerNotification.failureBanner(message: "No network Connection")
                print("network error")
                
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                if let data = (response["data"])as? Json{
                    self.passmodel = passwordmodel(fromData: data)
                    BannerNotification.successBanner(message: "\(response["message"]!)")
                    if self.passmodel?.success == 1 {
                        self.navigationController?.popToViewController(ofClass: LoginVC.self)
                    } else {
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
    func changepassword() {
        let parameters = [
            "passwordUpdate":["oldPassword":currentPasswordTF.text!,
                              "newPassword":newPasswordTF.text],
            "fileId":UserDefaults.standard.string(forKey: "fileID")!] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/changepassword", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                KVSpinnerView.dismiss()
                BannerNotification.failureBanner(message: "No network Connection")
                print("network error")
                
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                if let data = (response["data"])as? Json{
                    self.passmodel = passwordmodel(fromData: data)
                    BannerNotification.successBanner(message: "\(response["message"]!)")
                    if self.passmodel?.success == 1 {
                        BannerNotification.successBanner(message: "\(response["message"]!)")
                        self.navigationController?.popViewController(animated: true)
                    } else {
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


