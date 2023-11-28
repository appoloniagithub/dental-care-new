//
//  NetworkManager.swift
//  FlipSell
//
//  Created by WC46 on 24/09/19.
//  Copyright © 2019 flipsell. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher



typealias Json = [String: Any]
typealias JsonArray = [Json]
typealias Parameter = [String: Any]
typealias NetworkCompletion = ((StatusType,Json)->())


struct FSConstants {
    static let serverUsername = ""
    static let serverPassword = ""
}

enum StatusType {
    case noNetwork
    case success
    case failure
    case unknown
}
enum EncodingType {
    case url
    case json
}
extension EncodingType {
    var encoding : ParameterEncoding {
        switch self {
        case .url:
            return URLEncoding.default
        case .json :
            return JSONEncoding.default
        }
    }
}

struct NetworkManager {
    static func webcallWithErrorCode(urlString url:String, methodeType method:HTTPMethod, parameter params:Parameters? = nil, encodingType encoding:ParameterEncoding = EncodingType.url.encoding, headerType header:HTTPHeaders? = nil, completion:@escaping NetworkCompletion) {
        
      //  let spiner = ActivitySpinner().showLoader(view:UIApplicati )
        if !(NetworkReachabilityManager()!.isReachable) {
            ///
            completion(.noNetwork,[:])
        }
        
        networkPrint(url: url, parameter: params, method: method.rawValue, header: header, encodingType: encoding)
        if params != nil {
            
        }
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: header).validate().responseJSON {
            respose in
            //
           
            print("============== DEBUG PRINT ====================")
            debugPrint(respose)
            print("============== ====================")
            //
            switch(respose.result) {
            case .success(_):
                
           //
                if respose.result.value != nil {
                    let result = respose.result.value as? Json ?? [:]
                    let serverError = result["serverError"] as? Int ?? 1
                    if serverError == 0 {
                        completion(.success,result)
                    } else {
                       completion(.failure,result)
                   }
                }
                break
            case .failure(let errorVal):
                
               //
                print("Error is:\(errorVal.localizedDescription)")
                
                completion(.unknown,["Message":errorVal.localizedDescription])
                break
            }
        }
    }
    
    
    static func webcallWithErrorCodeResponsString(urlString url:String, methodeType method:HTTPMethod, parameter params:Parameters? = nil, encodingType encoding:ParameterEncoding = EncodingType.json.encoding, headerType header:HTTPHeaders? = nil, completion:@escaping NetworkCompletion) {
        
        if !(NetworkReachabilityManager()!.isReachable) {
            completion(.noNetwork,[:])
        }
        
        networkPrint(url: url, parameter: params, method: method.rawValue, header: header, encodingType: encoding)
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: header).authenticate(user: FSConstants.serverUsername, password: FSConstants.serverPassword).validate().responseJSON {
            respose in
            
            print("*********************Response:",respose)
            
            switch(respose.result) {
            case .success(_):
                if respose.result.value != nil {
                    let result = respose.result.value as? Json ?? [:]
                    let errorCode = result["ErrorCode"] as? Int ?? 1
                    if errorCode == 0 {
                        completion(.success,result)
                    } else {
                        completion(.failure,result)
                    }
                }
                break
            case .failure(let errorVal):
                print("Error is:\(errorVal.localizedDescription)")
                completion(.unknown,["Message":errorVal.localizedDescription])
                break
            }
            } .responseString { (response) in
                print("*********************Response:",response)
                //completion(.failure)
        }
    }
    
    
    
    
    static func webcallMultipartWithErrorCode(urlString url:String, methodeType method:HTTPMethod, parameter params:Parameters? = nil,imageParam:String, encodingType encoding:ParameterEncoding = EncodingType.json.encoding, headerType header:HTTPHeaders? = nil,imagesData:[UIImage], completion:@escaping NetworkCompletion) {
//        ["Content-type":"multipart/form-data"]
        if !(NetworkReachabilityManager()!.isReachable) {
            completion(.noNetwork,[:])
        }
        networkPrint(url: url, parameter: params, method: method.rawValue, header: header, encodingType: encoding)
            Alamofire.upload(multipartFormData:
                { multipartFormData in
                    if params != nil {
                    for (key, value) in params!
                    {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                    }

//                    for i in 0..<imagesData.count {
//                        let imageDataToUpload = imagesData[i].jpegData(compressionQuality: 1)!
//                        //let imageData1:Data = imageData.jpegData(compressionQuality: 1)!//(UIImageJPEGRepresentation(Image, 1))!
//
//                        multipartFormData.append(imageDataToUpload, withName: imageParam, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//
//                    }
//
                    for imageData in imagesData {
                        let imageData1:Data = imageData.jpegData(compressionQuality: 1)!//(UIImageJPEGRepresentation(Image, 1))!
                        
                        multipartFormData.append(imageData1, withName: imageParam, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
            },
                             to: url,
                headers : header,
                encodingCompletion:
                { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON(completionHandler:
                            { response in
                                
                        })
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            }
            )








        Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: header).authenticate(user: FSConstants.serverUsername, password: FSConstants.serverPassword).validate(contentType: ["application/json"]).responseJSON {
            respose in

            print("*********************Response:",respose)

            switch(respose.result) {
            case .success(_):
                if respose.result.value != nil {
                    let result = respose.result.value as? Json ?? [:]
                    let errorCode = result["ErrorCode"] as? Int ?? 1
                    if errorCode == 0 {
                        completion(.success,result)
                    } else {
                        completion(.failure,result)
                    }
                }
                break
            case .failure(let errorVal):
                print("Error is:\(errorVal.localizedDescription)")
                completion(.unknown,["Message":errorVal.localizedDescription])
                break
            }
        }
    }
    
    static func getImageAuthorization() -> AnyModifier {
        let modifier = AnyModifier { request in
            var requestMutable = request
            let credentialData = "dev2:aNother123".data(using: String.Encoding.utf8)!
            let base64Credentials = credentialData.base64EncodedString(options: [])
            
            requestMutable.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
            
            return requestMutable
        }
        return modifier
    }
    
    static func errorText(jsn: Any) -> String{
        if let response = jsn as? [String: Any]{
            if let msgArray = response["Message"] as? [String]{
                return msgArray[0]
            }
            else if let msgString = response["Message"] as? String{
                return msgString
            }
            else if let msgDict = response["Message"] as? [String: String]{
                for i in msgDict.keys{
                    return msgDict[i] ?? ""
                }
            }
        }
        return ""
    }
}

func networkPrint(url:String, parameter: Parameter? = nil, method: String,header:HTTPHeaders? = nil, encodingType: ParameterEncoding){
    print("============NetworkPrint=============")
    print("url:",url)
    print("Parameter:",parameter as Any)
    print("method:",method)
    print("header:",header as Any)
    print("encodingType:",encodingType as Any)
    print("=====================================")
}




class ActivitySpinner {
    func showLoader(view: UIView) -> UIActivityIndicatorView {
        
        //Customize as per your need
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
        spinner.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        spinner.layer.cornerRadius = 3.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.white;
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        return spinner
    }
}

extension UIActivityIndicatorView {
    func dismissLoader() {
        DispatchQueue.main.async {
            self.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        
    }
}
