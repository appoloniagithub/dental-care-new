//
//  ScanWebservice.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 28/10/2022.
//

import Foundation
import KVSpinnerView
extension FinalReviewVC {
    func uploadscanedimage() {
        

        
       
            let parameters = [
            
                "userId" : UserDefaults.standard.string(forKey: "userid")!,
                "doctorId" : UserDefaults.standard.string(forKey: "doctorID")!,
                "doctorName":UserDefaults.standard.string(forKey: "doctor")!,
                "faceScanImages" :[faceScan64],
                "teethScanImages": [teethScan64]
            ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
            
            
             KVSpinnerView.show(saying: "Please wait while your scan is getting submitted \n which takes approx. 10 - 30 seconds")
       
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/scans/submitscans", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
                print(response)
                switch status {
                case .noNetwork:
                    BannerNotification.failureBanner(message: "No network Connection")
                    print("network error")
                    
                    
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
                            
                        }
                        else {
                        self.uploadmodel = submitscanmodel(fromData: data)
                       
                        BannerNotification.successBanner(message: "\(response["message"]!)")
                            if self.uploadmodel.success == 1 {
                            //  self.newchatapi()
                                let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanPopupVC") as! ScanPopupVC
                                    self.tabBarController?.tabBar.isHidden = true
                                self.navigationController?.navigationBar.isHidden = true
//                                vc.isfromreview = true
                                vc.conversationid = self.uploadmodel.conversationId
                                self.navigationController?.pushViewController(vc, animated: true)
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
        
    func newchatapi() {

//        for image in scanimgarr {
//            if let data = image.jpegData(compressionQuality: 1) {
//                let base64 = data.base64EncodedString(options: .lineLength64Characters)
//                imagebase64ae.append(base64)
//            }
//        }


            let parameters = [

                "senderId" : UserDefaults.standard.string(forKey: "userid")!,
                "receiverId" :  UserDefaults.standard.string(forKey: "doctorID")!,
                "message" : "hiiii",
                "format":"message",
                "scanId": uploadmodel.scanId!
            ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]

            KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/chat/newchat", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
                print(response)
                switch status {
                case .noNetwork:
                    print("network error")
                    BannerNotification.failureBanner(message: "No network Connection")


                case .success :
                    KVSpinnerView.dismiss()
                    print("success")
                  
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
                        self.newchat = newchatmodel(fromData: data)
                        BannerNotification.successBanner(message: "\(response["message"]!)")
                        if self.newchat.chatExist == 1 {
                            self.newmsgapi()
                        }else {
                            BannerNotification.successBanner(message: "\(response["message"]!)")
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
    func newmsgapi() {




            let parameters = [

                "senderId" : UserDefaults.standard.string(forKey: "userid")!,
                "conversationId" : newchat.conversationId!,
                "message" : "hi how are you",
                "format":"message",
                
                "scanId": uploadmodel.scanId!
            ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]

            KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/chat/newmessage", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
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
                        self.newchat = newchatmodel(fromData: data)
                        BannerNotification.successBanner(message: "\(response["message"]!)")
                        if self.newchat.chatExist == 1 {
                            
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
extension DoctorSelectionVC {
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
                            self.load = 1
                            self.drTable.reloadData()
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

class submitscanmodel {
    var scanId:String?
    var scanFirstImage:String?
    var success:Int?
    var conversationId:String?
    init(fromData data: Json) {
        self.scanId = data["scanId"] as? String
        self.scanFirstImage = data["scanFirstImage"] as? String
        self.success = data["success"] as? Int
        self.conversationId = data["conversationId"] as? String
    }
}
class newchatmodel {
    var chatExist:Int?
    var conversationId:String?
    init(fromData data: Json) {
        self.chatExist = data["chatExist"] as? Int
        self.conversationId = data["conversationId"] as? String
    }
}


