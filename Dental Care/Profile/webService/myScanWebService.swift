//
//  myScanWebService.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 28/10/2022.
//

import Foundation
import KVSpinnerView
extension MyScanVC {
    func myscangetget() {
       
            let parameters = [
        
                "userId" :  UserDefaults.standard.string(forKey: "userid")!
            ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
            KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/scans/getmyscans", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
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
                            
                        }else {
                        self.scanmodel = myscanmodel(Fromdata: data)
                        self.scan = 1
                        self.scanTable.reloadData()
                        if self.scanmodel?.success == 0 {
                           // BannerNotification.failureBanner(message: "\(response["message"]!)")
                            self.scanTable.isHidden = true
                            self.noscanImage.isHidden = false
                        }else {
                      //  BannerNotification.successBanner(message:"\(response["message"]!)")
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

extension MyScanImagesVC {
    func scanGet() {
        let parameters = [
            
            "userId" :  UserDefaults.standard.string(forKey: "userid")!,
            "scanId":scanid!
        ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/scans/getscanid", methodeType: .post,parameter: parameters,headerType: header) { [self] (status, response) in
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
                        
              }
                    else
                        {
                        self.scanmodel = myscanmodel(Fromdata: data)
                        self.scan = 1
                                                      self.scanCv.reloadData()
                        if self.scanmodel?.success == 1 {
                           // self.scanmodel = myscanmodel(Fromdata: data)

                            if self.scanmodel?.scans[indexPath?.row ?? 0].faceScanImages.count == 0 {
                                scanar = dummyar + (scanmodel?.scans[indexPath?.row ?? 0].teethScanImages ?? [""])
                                scanar.insert(logo, at: 4)
                                onlyteethscan = true
                                self.scan! = 1
                                self.scanCv.reloadData()

                            }
                            else if self.scanmodel?.scans[indexPath?.row ?? 0].teethScanImages.count == 0{
                                scanar =  (scanmodel?.scans[indexPath?.row ?? 0].faceScanImages ?? [""]) + dummyteethar
                                scanar.insert(logo, at: 4)
                                onlyfacescan = true
                                self.scan! = 1
                                self.scanCv.reloadData()

                            }else {


                                //let scan = [self.scansimagemodel!.faceScanImages,self.scansimagemodel!.teethScanImages]

                                let scan = [self.scanmodel!.scans[indexPath?.row ?? 0].faceScanImages ,self.scanmodel!.scans[indexPath?.row ?? 0].teethScanImages]

                                scanar = (scan.joined())
                                scanar.insert(logo, at: 4)
                                self.scan! = 1
                                self.scanCv.reloadData()

                            }
                            
                        }else {
                            //  BannerNotification.successBanner(message:"\(response["message"]!)")
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


