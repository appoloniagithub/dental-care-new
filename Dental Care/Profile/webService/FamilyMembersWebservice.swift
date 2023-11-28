//
//  FamilyMembersWebservice.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 28/10/2022.
//

import Foundation
import KVSpinnerView
extension FamilyMembersVC {
func getfamilymember() {

    let parameters = ["fileId":  UserDefaults.standard.string(forKey: "fileID")!] as [String : Any]
    let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                "lang":"en"]
    KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/file/getfilefamilymembers", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
                
            case .success :
                KVSpinnerView.dismiss()
                print("success")
                print(response["data"])
                if let data = (response["data"])as? Json{
                  //  BannerNotification.failureBanner(message: "\(response["message"]!)")
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
                    
                    self.familymodels = familymodel(Fromdata: data)
                    
                    self.memberTV.reloadData()
                        
                      
                   
                     
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

