//
//  LibraryWebService.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import Foundation
import KVSpinnerView
extension LibraryVC {
    func libraryget() {
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/library/getarticles", methodeType: .get,parameter: nil,headerType: header) { (status, response) in
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
                    self.libraryodel = librarymodel(Fromdata: data)
                   
                    self.reload = 1
                    self.libraryTableView.reloadData()
                    
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
