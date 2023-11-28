//
//  NotificationWebservice.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 16/03/2023.
//

import Foundation
import KVSpinnerView
extension NotificationVC {
    func notification() {

        let parameters = [ "userId" : UserDefaults.standard.string(forKey: "userid")!] as [String : Any]
            
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
         
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/notification/getallnotifications", methodeType: .post,parameter: parameters,headerType: header) { [self] (status, response) in
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
//
                        }else {
                            self.notiModel = NotificationModel (fromData: data)
                            self.notiload = 1
                            self.notiTV.reloadData()
                        
//                        selfreversedmessages = self.chatm?.messages.reversed()
//                            SocketIOManager.sharedInstance.connectToServerWithusername(username: UserDefaults.standard.string(forKey: "userid") ?? "", completionHandler:ch )
                        
//                            if self.messagemodel?.message == nil {
//                              print ("messagemodel nil")
//
//                            }else{
//                             //   self.uploadphoto()
//                            }
//                        self.ChatTV.reloadData()
//                        self.ChatTV.scrollToBottom(animated: false)
                           
                      
//                        DispatchQueue.main.async(execute: { () -> Void in
//                            let indexPath = NSIndexPath(row: (self.chatm?.messages.count ?? 0)-1, section: 0)
//                            self.ChatTV.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
//
//                        })
                        }
                       
                           // BannerNotification.successBanner(message:"\(response["message"]!)")
                            
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
}
