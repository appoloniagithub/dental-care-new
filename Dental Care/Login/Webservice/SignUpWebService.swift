//
//  SignUpWebService.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 21/10/2022.
//

import Foundation
import KVSpinnerView


extension SignUpVC {
    
    func checkpatient() {
        
        
        
        
        let parameters = ["fileNumber": userNameCPTF.text!,
                          "isFileNumber":signupType!,
                          "emiratesId":userNameCPTF.text!] as [String : Any]
        
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/checkpatient", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
//                self.view.alpha = 1
//                self.view.isUserInteractionEnabled = true
                
            case .success :
                KVSpinnerView.dismiss()
                print("success")
                print(response["data"])
                if let data = (response["data"])as? Json{
                    self.checkmodel = CheckPatientModel(fromData: data)
                    self.checkpatientconditions()
                    BannerNotification.successBanner(message: "\(response["message"]!)")
                  
                    
                }
                
                
            case .failure :
                print("failure")
                KVSpinnerView.dismiss()
                
                BannerNotification.failureBanner(message: "\(response["message"]!)")
            case .unknown:
                print("unknown")
                KVSpinnerView.dismiss()
              
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
               
            }
            
        }
    }
    func signup() {
        
        
        
        
        
        let parameters = [ "firstName" : self.firstnameTF.text!,
                           "lastName" : self.lastNameTF.text!,
                           "email" : self.emailIDView.text!,
                           "phoneNumber" : phoneno,
                           "countryCode" : selectedcountry!,
                           "emiratesId" : emiratesidtext!,    //emiratesidsignupTF.text!,
                           "role" : "1",
                           "isExisting" : checkmodel.isExisting!,
                           "gender":genderLabel.text!,
                           "password" : passwordsignupTf.text!,
                           "dob":dobTF.text!,
                           "fileNumber":    filenumbertext!,//fileNoSignupTF.text!,
                           "city":cityLabel.text!
                           
        ] as [String : Any]
        
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/signup", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                KVSpinnerView.dismiss()
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                //      print(response["data"]!)
                if let data = response["data"] as? Json{
                       self.signModel = SignupModel(fromData: data)
                    if self.signModel.success == 1 {
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                        vc.fileid = self.signModel.fileId
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
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
                KVSpinnerView.dismiss()
              
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
                
            }
            
        }    }
    
    func verifyotp() {
        
        
        
        
        
        let parameters = ["otp": otpTf.text!,
                          "fileId":checkmodel.fileId!
        ] as [String : Any]
        
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/phoneverify", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
                
            case .success :
                KVSpinnerView.dismiss()
                print("success")
                print(response["data"]!)
                if let data = response as? Json{
                    self.signupexisting()
                    
                    
                   
                    
                   
                    
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
    func resendotp() {
        let parameters = [
            "fileId":checkmodel.fileId!,
           
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



    
    func signupexisting() {
        
        
        
        
        
        let parameters = [
         
            "isExisting" : checkmodel.isExisting!,
            "password" : passwordEcsistingTF.text!,
            "fileId" :checkmodel.fileId!
        ] as [String : Any]
        
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/signup", methodeType: .post,parameter: parameters) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
                
            case .success :
                KVSpinnerView.dismiss()
                print("success")
                //      print(response["data"]!)
                if let data = response["data"] as? Json{
                    BannerNotification.successBanner(message: "\(response["message"]!)")
                    self.navigationController?.popViewController(animated: false)
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
}
    





