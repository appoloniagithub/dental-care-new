//
//  ProfileVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 26/10/2022.
//

import UIKit
import Kingfisher
import KVSpinnerView
protocol profiledelegate {
    func tabbar()
}

class ProfileVC: UIViewController,profiledelegate {
    
    @IBOutlet weak var appoinmenticon: UIImageView!
    
    @IBOutlet weak var logouticon: UIImageView!
    
    @IBOutlet weak var faqicon: UIImageView!
    
    @IBOutlet weak var termsicon: UILabel!
    @IBOutlet weak var privacyicon: UIImageView!
    
    @IBOutlet weak var deleteaccounticon: UIImageView!
    @IBOutlet weak var changepasswordicon: UIImageView!
    @IBOutlet weak var websiteicon: UIImageView!
    @IBOutlet weak var myscanicon: UIImageView!
    @IBOutlet weak var editprofileicon: UIImageView!
    @IBOutlet weak var familyicons: UIImageView!
    
    @IBOutlet weak var contactusicon: UIImageView!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var proimage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roundView: UIView!
    var profilegetmodel:profilemodel?
    var name:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        roundView.layer.cornerRadius = roundView.frame.size.width/2
        roundView.clipsToBounds = true
       // proimage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage")!))
        nameLabel.text =  "Hello \( UserDefaults.standard.string(forKey: "name") ?? "")"
        versionLabel.text = "Version:\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject? as! String)"
        proimage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage") ?? ""))
       editprofileget()
        languageiconchange()
       
    }
    func languageiconchange() {
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            myscanicon.image = UIImage(named: "right-arrow")
            familyicons.image = UIImage(named: "right-arrow")
            editprofileicon.image = UIImage(named: "right-arrow")
            changepasswordicon.image = UIImage(named: "right-arrow")
            websiteicon.image = UIImage(named: "right-arrow")
            appoinmenticon.image = UIImage(named: "right-arrow")
            faqicon.image = UIImage(named: "right-arrow")
            privacyicon.image = UIImage(named: "right-arrow")
            contactusicon.image = UIImage(named: "right-arrow")
            logouticon.image = UIImage(named: "right-arrow")
            deleteaccounticon.image = UIImage(named: "right-arrow")
        }else {
            myscanicon .image = UIImage(named: "left-arrow(1)")
            familyicons .image = UIImage(named: "left-arrow(1)")
            editprofileicon .image = UIImage(named: "left-arrow(1)")
            changepasswordicon .image = UIImage(named: "left-arrow(1)")
            websiteicon .image = UIImage(named: "left-arrow(1)")
            appoinmenticon .image = UIImage(named: "left-arrow(1)")
            faqicon .image = UIImage(named: "left-arrow(1)")
            privacyicon .image = UIImage(named: "left-arrow(1)")
            contactusicon .image = UIImage(named: "left-arrow(1)")
            logouticon .image = UIImage(named: "left-arrow(1)")
            deleteaccounticon .image = UIImage(named: "left-arrow(1)")
            
            
            
        }
    }
    @IBAction func MyscanButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ProfileSB", bundle:      Bundle.main).instantiateViewController(withIdentifier: "MyScanVC")  as! MyScanVC
        vc.delegate = self
        
        tabBarController?.tabBar.isHidden = true
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func myAppointmentButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentAllBookVC")   as! AppointmentAllBookVC
        vc.delegate = self
//        vc.scantype = .teethScanwithHelp
//        vc.onlyTeethScan = true
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func faqButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ProfileSB", bundle:      Bundle.main).instantiateViewController(withIdentifier: "FAQVC")  as! FAQVC
        tabBarController?.tabBar.isHidden = true
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func familyMembersButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ProfileSB", bundle:      Bundle.main).instantiateViewController(withIdentifier: "FamilyMembersVC")  as! FamilyMembersVC
        tabBarController?.tabBar.isHidden = true
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "ProfileSB", bundle:      Bundle.main).instantiateViewController(withIdentifier: "EditProfileVC")  as! EditProfileVC
        tabBarController?.tabBar.isHidden = true
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func bookanAppointmentButtonAction(_ sender: UIButton) {
        guard let url = URL(string: "https://appolonia.ae/contact-us/book-appointment/") else { return }
        UIApplication.shared.open(url)
   
    }
    
    @IBAction func visitwebsiteButtonAction(_ sender: UIButton) {
        guard let url = URL(string: "https://appolonia.ae") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func changePasswordButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "SetPasswordVC")  as! SetPasswordVC
         tabBarController?.tabBar.isHidden = true
        vc.delegate = self
          navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func termsButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "CustomStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomVC")  as! CustomVC
        //vc.Pageid = "1"
        tabBarController?.tabBar.isHidden = true
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func privacyPolicyButtonAction(_ sender: UIButton) {
//        let vc = UIStoryboard.init(name: "CustomStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomVC")  as! CustomVC
//        vc.Pageid = "2"
//        tabBarController?.tabBar.isHidden = true
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
        guard let url = URL(string: "https://appolonia.ae/essential-pages/privacy-policy/") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func contactUsButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "contactUsVC")  as! contactUsVC
        tabBarController?.tabBar.isHidden = true
        vc.delegate = self
        vc.fromhome = true
          navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func logoutButtonAction(_ sender: UIButton) {
//        let vc = UIStoryboard.init(name: "CustomStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "LogoutVC")  as! LogoutVC
//        vc.isfromlogout = true
//        vc.screenshot = self.view.takeScreenshot()
//        tabBarController?.tabBar.isHidden = true
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: false)
        logoutalert()
    }
    
    @IBAction func deleteAccountButtonAction(_ sender: UIButton) {
//        let vc = UIStoryboard.init(name: "CustomStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "LogoutVC")  as! LogoutVC
//        vc.isfromdelete = true
//        tabBarController?.tabBar.isHidden = true
//        vc.screenshot = self.view.takeScreenshot()
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
        deletealert()

    }
    func tabbar() {
        
        tabBarController?.tabBar.isHidden = false
    }
    
}
extension ProfileVC  {
    func editprofileget() {
       
            let parameters = [
        
                "userId" : UserDefaults.standard.string(forKey: "userid")!
            ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        
       // KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/profileget", methodeType: .post,parameter: parameters,headerType:header ) { (status, response) in
                print(response)
                switch status {
                case .noNetwork:
                    print("network error")
                    BannerNotification.failureBanner(message: "No network Connection")
                    
                case .success :
                        //  KVSpinnerView.dismiss()
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
                            self.name = "\(self.profilegetmodel?.userData.firstName ?? "")" + " \(self.profilegetmodel?.userData.lastName ?? "")"
                            UserDefaults.standard.set( self.name, forKey: "name")
                            let proimage = image_baseURL + (self.profilegetmodel?.userData.image.first ?? "")
                            UserDefaults.standard.set(proimage, forKey: "proimage")
                            self.nameLabel.text =  "Hello \( UserDefaults.standard.string(forKey: "name") ?? "")"
                            self.proimage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage") ?? ""))
                       
                    //self.initialviewload()
                    }
                    }
                    
                case .failure :
                    print("failure")
                    
                  //  KVSpinnerView.dismiss()
                    BannerNotification.failureBanner(message: "\(response["message"]!)")
                case .unknown:
                    print("unknown")
                  //  KVSpinnerView.dismiss()
                    if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")
                    }else {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")

                        
                    }
                }
                
            }    }
}
extension ProfileVC {
    private func logoutalert() {
        let alertController = UIAlertController(title: "Logout", message: "Do you wish to Logout?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.logout()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    private func deletealert() {
        let alertController = UIAlertController(title: "Delete Account", message: "All your personal details, scans & chats will be deleted if you continue & your account will be disabled. Do you want to continue?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
            vc.fromdelete = true
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func logout() {
        
        let parameters = [
            "fileId":UserDefaults.standard.string(forKey: "fileID")!,
            "accessToken":UserDefaults.standard.string(forKey: "access_token")!
        ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/logout", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                KVSpinnerView.dismiss()
                BannerNotification.failureBanner(message: "No network Connection")
                print("network error")
                
                
            case .success :
                
                print("success")
                KVSpinnerView.dismiss()
                //      print(response["data"]!)
                if let data = response["data"] as? Json{
                    if data["success"] as? Int == 1 {
                        UserDefaults.standard.set("", forKey: "fileID")
                        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                        UserDefaults.standard.set("", forKey: "userid")
                        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "LoginVC")   as! LoginVC
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: false)
                        //   self.navigationController?.popToViewController(ofClass: LoginVC.self )
                        
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


   // }


