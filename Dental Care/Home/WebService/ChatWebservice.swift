//
//  ChatWebservice.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import Foundation
import KVSpinnerView
import Alamofire
extension ChatConversationsVC {
   
        func chatlistapi() {

        let parameters = ["userId": UserDefaults.standard.string(forKey: "userid")!] as [String : Any]
            
            let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                        "lang":"en"]
             
            
            KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/chat/getconversations", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
                print(response)
                switch status {
                case .noNetwork:
                    print("network error")
                    BannerNotification.failureBanner(message: "No network Connection")
                    self.view.alpha = 1
                    self.view.isUserInteractionEnabled = true
                    
                case .success :
                    KVSpinnerView.dismiss()
                    print("success")
                     print(response["data"])
                    if let data = (response["data"])as? Json{
                        
                      self.chatmodel = ChatModel(Fromdata: data)

                         
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
                            self.chatload = 1
                       self.chatlistTV.reloadData()
                        }
                            
                          
                       
                            
                            
                        }
                        
                    
                    
                    
                case .failure :
                    print("failure")
                    KVSpinnerView.dismiss()
                    
                    BannerNotification.failureBanner(message: "\(response["message"]!)")
                case .unknown:
                    print("unknown")
                    KVSpinnerView.dismiss()
                    if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en-AE" { //en-AE
                        BannerNotification.failureBanner(message: "Oops! something went wrong")
                    }else {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")

                        
                    }
                }
                
            }
        }
}
extension ChatViewController {
    func getConversation() {

        let parameters = ["conversationId": conversationid!,
                          "bottomHit":bottomhit,
                          "isSeen":"0",
                          "isRead":"1",
                          "userId":UserDefaults.standard.string(forKey: "userid")!] as [String : Any]
            
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
         
        KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/chat/getconversationmessages", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
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
                            if self.reloaddata == true {
                                
                            }else {
                                self.chatm = chatmodel(Fromdata: data)
                            }
                        
                        
//                        selfreversedmessages = self.chatm?.messages.reversed()
//                            SocketIOManager.sharedInstance.connectToServerWithusername(username: UserDefaults.standard.string(forKey: "userid") ?? "", completionHandler:ch )
                        self.chat = 1
//                            if self.messagemodel?.message == nil {
//                              print ("messagemodel nil")
//                                
//                            }else{
//                             //   self.uploadphoto()
//                            }
//                        self.ChatTV.reloadData()
//                        self.ChatTV.scrollToBottom(animated: false)
                           
                        self.ChatTV.reloadData()
                            
                            
                          //  DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                            self.ChatTV.scroll(to:.bottom , animated: true)
                                //            ChatTV.scroll(indexpaths)
                           // }
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
    func getConversationreload() {

        let parameters = ["conversationId": conversationid!,
                          "bottomHit":bottomhit,
                          "isSeen":"0",
                          "isRead":"0",
                          "userId":UserDefaults.standard.string(forKey: "userid")!] as [String : Any]
            
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
         
        KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/chat/getconversationmessages", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
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
                            
                        }else {
                        
                        self.chatm = chatmodel(Fromdata: data)
                          
//                        selfreversedmessages = self.chatm?.messages.reversed()
//                            SocketIOManager.sharedInstance.connectToServerWithusername(username: UserDefaults.standard.string(forKey: "userid") ?? "", completionHandler:ch )
                        self.chat = 1
//                            if self.messagemodel?.message == nil {
//                              print ("messagemodel nil")
//
//                            }else{
//                             //   self.uploadphoto()
//                            }
//                        self.ChatTV.reloadData()
//                        self.ChatTV.scrollToBottom(animated: false)
                           
                        self.ChatTV.reloadData()
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
                    if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")
                    }else {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")

                        
                    }
                }
                
            }
        

}
    func sentmessageimage() {
        let parameters = ["conversationId":conversationid! ,
                          "senderId":UserDefaults.standard.string(forKey: "userid")!,
                          
                          //"message":MessageTF.text!,
        "format":"image", "scanId":""] as [String : String]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        do {
             filedata = try pickedImages!.jpegData(compressionQuality: 1.0)      ///Data(contentsOf: fileimage!)
            KVSpinnerView.show(saying: "Please Wait")
            Alamofire.upload(multipartFormData: { multipart in
               
                if self.filedata != nil {
                    multipart.append(self.filedata!, withName: "message", fileName: "file.png", mimeType: "image/png")
                }
                for (key, value ) in parameters {
                    multipart.append(value.data(using: .utf8)!, withName: key)
                }
                    
                
                
            }, to: URL(string: remote_Base_URL + "api/chat/newmessageimage")!) { [self] response in
                print("88888888888888 = \(response)")
                switch  response{
                   
                    
                case .success(request: let request, streamingFromDisk: let streamingFromDisk, streamFileURL: let streamFileURL):
                    
                    //print("88888888888888 = \(response)")
                    request.uploadProgress { progress in
                       debugPrint(progress)
                        
                    }
                    request.responseJSON {jsonresponse in
                             //debugPrint(jsonresponse["data"])
                       // print("888888888888 = \(jsonresponse.value["data"] as! Any)")
                        let data = jsonresponse.value as! [String:Any]
                      //  print(data)
                      let san = data["data"]
                        print("1111111111111\(san)///////")
                        self.messagemodel = messagedatamodels(Fromdata:san as! [String : Any])
                       
                        
//                        if messagemodel?.message == nil {
//                          print ("messagemodel nil")
//
//                        }else{
//                            uploadphoto()
//                        }
                        
                       // print(jsonresponse["data"])
                        
                        
//                        request.response {jsonresponse in
//                            print("*****************\(jsonresponse)*****************")
                       getConversationreload()
                            self.ChatTV.reloadData()
                        uploadphoto(message: messagemodel?.message)
                        }
//                        print("/////+++++\(response.result.value)************")
//                         let data = response.result.value["data"]
                            
                        
//                            print("//////////// \(data)/////////////****************")
//                         }
                   //  let data =  response.data["data"]
//                        getConversation()
//                        if jsonresponse("message") == 1 {
//
//                        }
//                    getConversation()
//                        self.ChatTV.reloadData()
                   // }
                   // BannerNotification.successBanner(message:"We have received your message and will respond within 24-48 Hrs")
//                    self.ChatTV.reloadData()
//                    KVSpinnerView.dismiss()
//                    getConversation()
//                    self.ChatTV.reloadData()
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
     

   
    
func SentMessage() {

    let parameters = ["conversationId":conversationid! ,
                      "senderId":UserDefaults.standard.string(forKey: "userid")!,
                      "message":MessageTF.text!,
                      "isSeen":"0",
                      "isRead":"0",
                      "recId":senderid ?? "",
    "format":"text", "scanId":""] as [String : Any]
    let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                "lang":"en"]




  //  KVSpinnerView.show(saying: "Please Wait")
    NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/chat/newmessage", methodeType: .post,parameter: parameters,headerType: header) { [self] (status, response) in
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

                    } else {
                    self.messagesmodel = MessagesModel(Fromdata: data)
                    self.chat = 1
                    self.getConversationreload()
                    self.ChatTV.reloadData()
                        //let messages = chatm?.messages
//                        let messageparam = ["conversationId":conversationid! ,
//                                            "senderId":UserDefaults.standard.string(forKey: "userid")!,
//                                            "message":MessageTF.text!,
//                                            "createdAt":messagemodel?.createdAt!,
//                                            "format":"text", "scanId":"",
////"recId":senderid ?? "",
//                                            "receiverId":UserDefaults.standard.string(forKey: "doctorID")!]  as [String : Any]
//                        SocketIOManager.sharedInstance.socket?.emit("send-message",messageparam)

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
    //63d4d3bbd0f1dbc9fa78563c
    func getchatdetails () {

        let parameters = ["doctorId":UserDefaults.standard.string(forKey: "doctorID")!,
                          "patientId":UserDefaults.standard.string(forKey: "userid")!] as [String : Any]
            
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/chat/getdoctorinfo", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
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
                        }else {
                            self.chardrmodel = chatdoctormodel(fromData: data)
                            if self.chardrmodel?.success == 1 {
                               // drchatmodel
                               // self.proimage.kf.setImage(with: URL(string: self.chardrmodel?.doctorData[self.indexpath?.row ?? 0].image.first ?? ""))
                                
                                self.name.text = self.chardrmodel?.doctorData?.name
                                //self.getConversation()
                            }
//                            if self.reloaddata == true {
//                                
//                            }else {
//                                self.chatm = chatmodel(Fromdata: data)
//                            }
                        
                        
//                        selfreversedmessages = self.chatm?.messages.reversed()
//                            SocketIOManager.sharedInstance.connectToServerWithusername(username: UserDefaults.standard.string(forKey: "userid") ?? "", completionHandler:ch )
                        self.chat = 1
//                            if self.messagemodel?.message == nil {
//                              print ("messagemodel nil")
//
//                            }else{
//                             //   self.uploadphoto()
//                            }
//                        self.ChatTV.reloadData()
//                        self.ChatTV.scrollToBottom(animated: false)
                           
                        self.ChatTV.reloadData()
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


