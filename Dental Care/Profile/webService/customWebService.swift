//
//  customWebService.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import Foundation
import KVSpinnerView
extension CustomVC {
    
    func custompage() {
        
        
        
        
        
        let parameters = [
            "pageId":Pageid!
        ] as [String : Any]
    
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
         
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/custompages/getcustompages", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
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
                        
                    }
                    else {
                    
                    self.model = CustomModel(fromData: data)
                    //self.viewloadinitiated()
                    
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
extension LogoutVC {
    
        func logout() {
            
            let parameters = [
                "fileId":UserDefaults.standard.string(forKey: "fileID")!,
                "accessToken":UserDefaults.standard.string(forKey: "access_token")!
            ] as [String : Any]
            let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                        "lang":"en"]
            
            
            KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/logout", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
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
                        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "LoginVC")   as! LoginVC
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: false)
                     //   self.navigationController?.popToViewController(ofClass: LoginVC.self )
                        
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

