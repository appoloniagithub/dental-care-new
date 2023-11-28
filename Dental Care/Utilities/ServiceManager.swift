//
//  ServiceManager.swift
//  EzLukUp
//
//  Created by REMYA V P on 19/10/22.
//

//import Foundation
//import Alamofire
//import SVProgressHUD
//
//class ServiceManager: NSObject {
//
//    static let sharedInstance = ServiceManager()
//    var uploadProgress : Progress?
//    var requestMade = 0
//    var requestFinished = 0
//    var completionHandler : (Bool, AnyObject?, NSError?)->() = {_,_,_ in }
//  
//    func postMethodAlamofire(_ serviceName : String, dictionary : Parameters?,withHud isHud: Bool,controller:UIViewController? = nil, completion : @escaping (Bool, AnyObject?, NSError?)->Void) {
//       // let hud = SVProgressHUD()
//      
//        SVProgressHUD.setDefaultMaskType(.clear)
//        completionHandler = completion
//        DispatchQueue.main.async {
//            if isHud {
//                SVProgressHUD.show()
//                self.requestMade += 1
////                if controller != nil{
////                    controller?.view.isUserInteractionEnabled = false
////                }
//            }
//        }
//        print("URL: \(kBaseUrl + serviceName) Params:\(dictionary!)")
//        if let url = URL(string: kBaseUrl + serviceName) {
//            
//            let header:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
//                AF.request(url, method: .post, parameters: dictionary!, encoding: URLEncoding.httpBody, headers: header ).responseJSON { (response:AFDataResponse<Any>) in
//                  
//                    
//                    DispatchQueue.main.async { [self] in
//                        if isHud {
//                            self.requestFinished += 1
//                            if requestFinished == requestMade {
//                                print("requestMade: \(requestMade), request Finished: \(requestFinished)")
//                                SVProgressHUD.dismiss()
//                            }else{
//                                if !(SVProgressHUD.isVisible()){
//                                    SVProgressHUD.show()
//                                }
//                               
//                            }
//                           
////                            if controller != nil{
////                                controller?.view.isUserInteractionEnabled = true
////                            }
//                        }
//                    }
//                    
//                      switch response.result {
//                      
//                      case .success(let jsonData):
//                          let dictionary = jsonData as! NSDictionary
//                          let status:Bool = dictionary.object(forKey: "status") as! Bool
//                            completion(true, response.value as AnyObject , nil)
//                      case .failure(let error):
//                        
//                        completion(false,nil,error as NSError)
//                          break
//                          
//                      }
//                    
//                }
//            
//        }
//          }
//       
//       
//    func getMethodAlamofire(_ serviceName : String, param : Parameters?,withHud isHud: Bool, head:String, completion : @escaping (Bool, AnyObject?, NSError?)->Void)
//       {
//           completionHandler = completion
//           if let url = URL(string: kBaseUrl + serviceName) {
//               let header : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded","x-access-token": head]
//               
//               AF.request(url, method: .get, parameters: param, encoding: URLEncoding.httpBody, headers: header).responseJSON { (response:AFDataResponse<Any>) in
//               
//                   
//                   switch response.result {
//                   case .success(let jsonData):
//                     //  print("Success with JSON: \(jsonData)")
//                       let dictionary = jsonData as! NSDictionary
//                       let status:Bool = dictionary.object(forKey: "status") as! Bool
//                       if(status){
//                           completion(true, response.value as AnyObject , nil)
//                       }
//                   case .failure(let error): completion(false,nil,error as NSError)
//                       break
//                       
//                   }
//               }
//           }
//       }
//        
//       //MARK:-Put Method with Headers
//       
//       func putWithHeader_Body(withServiceName serviceName: String!, andParameters parameters: Parameters?,body:Parameters?,  withHud isHud: Bool, completion : @escaping (Bool, AnyObject?, NSError?)->Void){
//           
//           var urlComponent = URLComponents(string: kBaseUrl+serviceName!)!
//           
//           let queryItems =  parameters?.map{return URLQueryItem(name: $0.key, value: $0.value as? String)}
//           urlComponent.queryItems = queryItems
//           var httpRequest = URLRequest(url:urlComponent.url!)
//           httpRequest.httpMethod = HTTPMethod.put.rawValue
//          
//           httpRequest.httpBody =  try? JSONSerialization.data(withJSONObject: body!)
//         
//           httpRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//          // httpRequest.setValue(TCToken.currentToken.auth_token, forHTTPHeaderField: "Authtoken")
//           AF.request(httpRequest).responseJSON { (response) in
//           
//               switch response.result {
//               case .success(let jsonData):
//                   //print("Success with JSON: \(jsonData)")
//                   let dictionary = jsonData as! NSDictionary
//                   let status:Bool = dictionary.object(forKey: "status") as! Bool
//                   if(status){
//                       completion(true, response.value as AnyObject , nil)
//                   }
//               case .failure(let error): completion(false,nil,error as NSError)
//                   break
//               }
//            
//           }
//       }
//       
//       
//    func uploadSingleData(_ serviceName : String, parameters : Parameters?,imgdata : Data?,filename: String,withHud isHud: Bool, completion : @escaping (Bool, AnyObject?, NSError?)->Void)
//    {
//       
//       completionHandler = completion
//       
//           let header : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
//           
//           AF.upload(
//               multipartFormData: { multipartFormData in
//                if imgdata != nil {
//                   multipartFormData.append( imgdata!, withName: filename, fileName: filename, mimeType: "image/jpg")
//                }
//                   if parameters != nil {
//                       for (key, value) in parameters! {
//                           multipartFormData.append(("\(value)").data(using: .utf8)!, withName: key)
//                       }
//                   }
//           },to: kBaseUrl + serviceName, method: .post , headers: header)
//              .responseJSON(completionHandler: { response in
//                   
//                   switch response.result {
//                   case .success( _):
//                       let dictionary = response.value as! NSDictionary
//                       let status:Bool = dictionary.object(forKey: "status") as! Bool
//                       if(status){
//                           completion(true, response.value as AnyObject , nil)
//                       }
//                       break
//                   case .failure(let error):
//                       completion(false,nil,error as NSError)
//                       break
//                   }
//               })
//       }
//
//    
//    // MARK: - new api functions
//  //  let token : String = UserDefaults.standard.value(forKey: "Ktoken") as! String
//        
//    func uploadSingleDataa(_ serviceName : String, headerf : String, parameters : Parameters?,image : Data?,filename: String,mimetype: String,withHud isHud: Bool, completion : @escaping (Bool, AnyObject?, NSError?)->Void)
//        {
//    //        if isHud {
//    //            SVProgressHUD.show()
//    //        }
//            completionHandler = completion
//            let diceRoll = Int(arc4random_uniform(6) + 1)
//            var file_name = "imageFile"
//            file_name.append("\(diceRoll)")
//            file_name.append("\(mimetype)")
//            print("finale image name is = \(file_name)")
//            
//            let header : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded","x-access-token":headerf]
//            
//            let url = kBaseUrl + serviceName
//            print("URL = \(url)")
//           // print("PARAMETERS = \(parameters!)")
//            print("header values",header)
//            AF.upload(
//                multipartFormData: { multipartFormData in
//                    multipartFormData.append( image!, withName: "file", fileName: file_name, mimeType: mimetype)
//                    if parameters != nil {
//                        for (key, value) in parameters! {
//                            multipartFormData.append(("\(value)").data(using: .utf8)!, withName: key)
//                        }
//                    }
//                },to: kBaseUrl + serviceName, method: .post , headers: header)
//                .responseJSON(completionHandler: { response in
//    //                if isHud {
//    //                    SVProgressHUD.dismiss()
//    //                }
//                    print(response)
//                    switch response.result {
//                    case .success(let jsonData):
//                        
//                        let dictionary = jsonData as! NSDictionary
//                        let status:Bool = dictionary.object(forKey: "status") as! Bool
//                        if status == true{
//                            completion(true, response.value as AnyObject , nil)
//                            //self.getModalObject(serviceUrl: serviceName, response: response)
//                        }else{
//                            self.completionHandler(true,response.value as AnyObject,nil)
//                        }
//                    case .failure(let error):
//                        completion(false,nil,error as NSError)
//                        break
//                    }
//                })
//        }
//        
//        //MARK: ------------------------------------------------------------------------
//    
//    
//func postMethodAlamofireWithrawdata(_ serviceName : String, dictionary : Parameters?,withHud isHud: Bool,rowData:Data, completion : @escaping (Bool, AnyObject?, NSError?)->Void) {
//    if isHud {
//        DispatchQueue.main.async {
//  //          SVProgressHUD.show()
//        }
//        
//    }
//    completionHandler = completion
//    if let url = URL(string: kBaseUrl + serviceName) {
//        let header:HTTPHeaders = ["Content-Type":"application/json"]
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject: dictionary!)
//        //rowData as Data
//        
//        request.headers = header
//        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
//            if isHud {
//                DispatchQueue.main.async {
//       //             SVProgressHUD.dismiss()
//                }
//            }
//            switch response.result {
//            case .success(let jsonData):
//                
//                let dictionary = jsonData as! NSDictionary
//                let status:Bool = dictionary.object(forKey: "status") as! Bool
//                if status {
//                    completion(true, response.value as AnyObject , nil)
//                    //self.getModalObject(serviceUrl: serviceName, response: response)
//                }else{
//                    self.completionHandler(true,response.value as AnyObject,nil)
//                }
//            case .failure(let error): completion(false,nil,error as NSError)
//                break
//            }
//        }
//    }
//}
//}
