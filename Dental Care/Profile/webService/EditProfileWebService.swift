//
//  EditProfileWebService.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import Foundation
import KVSpinnerView
import Alamofire
extension EditProfileVC {
    func editprofileget() {
       
            let parameters = [
        
                "userId" : UserDefaults.standard.string(forKey: "userid")!
            ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        
        KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/profileget", methodeType: .post,parameter: parameters,headerType:header ) { (status, response) in
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
                      //
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
                            self.profilegetmodel = profilemodel(fromData: data)
                       
                    self.initialviewload()
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
    func editprofilepost() {
        
             let parameters = [
         
                 "userId" : UserDefaults.standard.string(forKey: "userid")!,
                 "gender" : genderLabel.text!,
                 "firstName" : firstNameTF.text!,
                 "lastName" : lastNameTF.text!,
                 "email" :emailidTF.text!,
                 "emiratesId" : emiratesIDTF.text!,
                 "fileNumber" : UserDefaults.standard.string(forKey: "filenumber") ?? "",
                 "city" :cityLabel.text!,
                 "dob" :dobTF.text!,
                 "isFamilyHead" : "1",
                 "isEmiratesIdChanged" : "0",
                 "isFileNumberChanged" : "0",
                 "fileId" : "632c2f19f114bb4be6e1d227"
                 
             ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
         
        KVSpinnerView.show(saying: "Please Wait")
             NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/updateprofile", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
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
                             
                         } else {
                             self.profilegetmodel = profilemodel(fromData: data)
                         if self.profilegetmodel?.success == 1 {
                             self.maskView.isHidden = false
                             self.editButtonLabel.text = "Edit"
                             self.edited = false
                             self.navigationController?.popViewController(animated: false)
                             BannerNotification.successBanner(message: "\(response["message"]!)")
                             
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
                 
             }
    }
    func editprofileimage() {

        let parameters = [
            "userId" : UserDefaults.standard.string(forKey: "userid")!,
            "gender" : genderLabel.text!,
            
            "firstName" : firstNameTF.text!,
            "lastName" : lastNameTF.text!,
            "email" :emailidTF.text!,
            "emiratesId" : emiratesIDTF.text!,
            "fileNumber" : UserDefaults.standard.string(forKey: "filenumber") ?? "",
            "city" :cityLabel.text!,
            "dob" :dobTF.text!,
            "isFamilyHead" : "1",
            "isEmiratesIdChanged" : "0",
            "isFileNumberChanged" : "0",
            "fileId" : "632c2f19f114bb4be6e1d227"
          

        ] as [String : String]
        let header = ["Authorization":UserDefaults.standard.string(forKey: "access_token")!,"lang":"en"]
        do {
            if pickedImages != nil {
            filedata = try pickedImages!.jpegData(compressionQuality: 1.0)
            }
          //Data(contentsOf: fileimage!)
            KVSpinnerView.show(saying: "Please Wait")
            Alamofire.upload(multipartFormData: {  multipart in
               
                if self.filedata != nil {
                    multipart.append(self.filedata!, withName: "image", fileName: "file.png", mimeType: "image/png")
                }
                for (key, value ) in parameters {
                    multipart.append(value.data(using: .utf8)!, withName: key)
                }
                for (key, value ) in header {
                    multipart.append(value.data(using: .utf8)!, withName: key)
                }
                    
                
                
            }, to: URL(string: remote_Base_URL + "api/user/updateprofile")!) { result in
                switch  result {
                    
                case .success(request: let request, streamingFromDisk: let streamingFromDisk, streamFileURL: let streamFileURL):
                 
                   
                    request.uploadProgress { progress in
                       debugPrint(progress)
                    }
                    request.responseJSON { jsonresponse in
                        debugPrint(jsonresponse)
                        KVSpinnerView.dismiss()
                        let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")  as! CustomTabBarvc
                        vc.selectedIndex = 3
                        self.tabBarController?.tabBar.isHidden = true
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
//                    BannerNotification.successBanner(message:"We have received your message and will respond within 24-48 Hrs")
                    
                   
                   
                case .failure(let error):
                    print("failure,\(error.localizedDescription)")
                    BannerNotification.failureBanner(message: error.localizedDescription)
                    KVSpinnerView.dismiss()
                }
               
            }
        }
        catch {
          print("error")
        }
    }
     
}


    //}
    

