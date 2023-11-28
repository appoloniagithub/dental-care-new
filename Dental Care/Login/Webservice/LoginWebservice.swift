//
//  LoginWebservice.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 21/10/2022.
//

import Foundation
import UIKit
import KVSpinnerView
extension LoginVC {
    func login() {
        
        
        
        
        
        
        let parameters = [ "isPhoneNumber" : loginType,
                            "phoneNumber" : phoneno ?? "",
                           "password" : passwordTF.text!,
                           "emiratesId" :  fileTF.text!,
                           "device_token": UserDefaults.standard.string(forKey: "Device_token")!
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/login", methodeType: .post,parameter: parameters) { [self] (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
                
            case .success :
                KVSpinnerView.dismiss()
                print("success")
                
                if let data = (response["data"])as? Json{
                    self.loginmodel = LoginModel(fromData: data)
                    if self.loginmodel?.success == 1 {
                        UserDefaults.standard.set(self.loginmodel?.role, forKey: "role")
                        if loginmodel?.role == "1" {
                        self.name = "\(self.loginmodel?.familyHead?.firstName ?? "")" + " \(self.loginmodel?.familyHead?.lastName ?? "")"
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.set(self.loginmodel?.fileId  ?? "", forKey: "fileID")
                        UserDefaults.standard.set(self.loginmodel?.familyHead?.assignedDoctorImage, forKey: "doctorimage")
                        UserDefaults.standard.set( self.name, forKey: "name")
                            let proimage = image_baseURL + (self.loginmodel?.familyHead?.image.first)!

                        UserDefaults.standard.set(proimage, forKey: "proimage")
                            UserDefaults.standard.set(self.loginmodel?.familyHead?.phoneNumber, forKey: "phoneNumber")
                            
                        UserDefaults.standard.set(self.loginmodel?.familyHead?.assignedDoctorName, forKey: "doctor")
                        UserDefaults.standard.set(self.loginmodel?.familyHead?.assignedDoctorId, forKey: "doctorID")
                        UserDefaults.standard.set(self.loginmodel?.access_token, forKey: "access_token")
                        UserDefaults.standard.set(self.loginmodel?.familyHead?.email, forKey: "email")
                        UserDefaults.standard.set(self.loginmodel?.familyHead?.fileNumber, forKey: "filenumber")
                           UserDefaults.standard.set(loginmodel?.familyHead?.emiratesId, forKey: "emiratesId")
                            UserDefaults.standard.set(self.loginmodel?.familyHead?._id, forKey: "userid")
                            UserDefaults.standard.set(loginmodel?.refresh_token, forKey: "refresh_token")
                            
                        // UserDefaults.standard.set(self.loginmodel?.familyHead?.lastName, forKey: "lastname")
                        
                        UserDefaults.standard.set(self.loginmodel?.familyHead?.phoneNumber, forKey: "phoneNumber")
                        
                        //UserDefaults.standard.set(self.loginmodel?, forKey: "name")
                        
                        UserDefaults.standard.synchronize()
                        let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")  as! CustomTabBarvc//Tabbar  Drtab Home DoctorSB
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: false)
                        
                    }
                        else if loginmodel?.role == "Doctor" {
                            UserDefaults.standard.set(self.loginmodel?.doctorFound?._id, forKey: "userid")
                            self.name = "\(self.loginmodel?.doctorFound?.firstName ?? "")" + " \(self.loginmodel?.doctorFound?.lastName ?? "")"
                            UserDefaults.standard.set( self.name, forKey: "name")
                            let vc = UIStoryboard.init(name: "Drhome", bundle:      Bundle.main).instantiateViewController(withIdentifier: "DrHomeVC")  as! DrHomeVC//Tabbar  Drtab Home DoctorSB
                            self.navigationController?.navigationBar.isHidden = true
                            self.navigationController?.pushViewController(vc, animated: false)

                        }
                    }
                   
                    else  if self.loginmodel?.isExisting == 1  {
                        if  self.loginmodel?.phoneVerified == 0 && self.loginmodel?.clinicVerified == 1  {
                                    let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "OTPVC")  as! OTPVC//Tabbar  Drtab Home DoctorSB
//                                    vc.fileid = self.loginmodel?.fileId
                                   // vc.otp = self.loginmodel?.otp
                                
                                    self.navigationController?.pushViewController(vc, animated: false)
                        }else if self.loginmodel?.phoneVerified == 0 {
                        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "OTPVC")  as! OTPVC//Tabbar  Drtab Home DoctorSB
                      vc.fileid = self.loginmodel?.fileId
//                      vc.otp = self.loginmodel?.otp
                        self.navigationController?.pushViewController(vc, animated: false)
                        }
                        else {
                            BannerNotification.failureBanner(message:  "\(response["message"]!)")
                        }
            }else {
                        BannerNotification.failureBanner(message:  "\(response["message"]!)")
                    }
                }
                
            case .failure :
                KVSpinnerView.dismiss()
                print("failure")
                
                
                BannerNotification.failureBanner(message: "\(response["message"]!)")
            case .unknown:
                KVSpinnerView.dismiss()
                print("unknown")
               
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
               
            }
            
        }    }
}
