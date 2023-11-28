//
//  AddMemberWebService.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import Foundation
import KVSpinnerView
extension AddMemberVC {
    
        
        
        
    func addmember() {
        
        let parameters = [
            "firstName" : firstNameTF.text!,
                           "lastName" : lastNameTF.text!,
                           "email" : emailIDTF.text!,
            "phoneNumber" : UserDefaults.standard.string(forKey: "phoneNumber") ?? "",
            "countryCode" : UserDefaults.standard.string(forKey: "countryCode") ?? "",
                           "emiratesId" : emiratesTF.text!,
                           "role" : "1",
                           "city":cityLabel.text!,
            "gender":genderLabel.text!,
            "fileNumber":fileNumberTF.text!,
            "dob":dobTF.text!
        ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/file/addtofamily", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                BannerNotification.failureBanner(message: "No network Connection")
                KVSpinnerView.dismiss()
                print("network error")
                
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                //      print(response["data"]!)
                if let data = response["data"] as? Json{
                     if response["authError"] as? String  == "1" {
                         RefreshTocken.shared.refreshtokenapi()
                         BannerNotification.failureBanner(message: "You Must Login First")
                        UserDefaults.standard.set("", forKey: "fileID")
                        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                        UserDefaults.standard.set("", forKey: "userid")
                        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "LoginVC")   as! LoginVC
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: false)
                        
                    }else {
                    self.model = membermodel(fromData: data)
                    if self.model.success == 1 {
                       
                        self.navigationController?.popViewController(animated:true)
                        BannerNotification.successBanner(message:"\(response["message"]!)")
                    }
                    else {
                        BannerNotification.failureBanner(message: "\(response["message"]!)")
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
            
        }    }
}
