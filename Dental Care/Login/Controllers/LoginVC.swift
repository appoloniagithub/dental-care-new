//
//  LoginVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 19/10/2022.
//

import UIKit
import CountryPickerView
import SkyFloatingLabelTextField
import WebKit
import KVSpinnerView



class LoginVC: UIViewController,CountryPickerViewDataSource,CountryPickerViewDelegate {
    var loginType:Int? = 1
    var phoneno = ""
    var loginmodel:LoginModel?
    var selectedcountry:String = ""
    var passwordSecured = true
    var name:String?
    let selLanguage = DCLanguageManager.sharedInstance.getLanguage()
   
    var window:UIWindow!
    
    
    @IBOutlet weak var arabicSelectionView: UIView!
    @IBOutlet weak var englishselectionview: UIView!
    @IBOutlet weak var fileTF: SkyFloatingLabelTextField!
    @IBOutlet weak var fileidView: UIView!
    @IBOutlet weak var phoneNoroundview: UIView!
    @IBOutlet weak var fileNoroundView: UIView!
    @IBOutlet weak var phoneNoSelectionIMG: UIImageView!
    @IBOutlet weak var passwordIMG: UIImageView!
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var fileNoSelectionIMG: UIImageView!
    @IBOutlet weak var userNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var countrySelectionView: CountryPickerView!
    
    @IBOutlet weak var PhoneView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        countrySelectionView.delegate = self
        countrySelectionView.dataSource = self
        selectedcountry = countrySelectionView.selectedCountry.phoneCode
        userNameTF.keyboardType = .numberPad
        passwordTF.isSecureTextEntry = true
        countrySelectionView.font = .systemFont(ofSize: 14)
        countrySelectionView.selectedCountry.localizedName()
        //changeLayout()
//        SocketIOManager.sharedInstance.establishConnection()
//      SocketIOManager.sharedInstance.connectToServerWithusername(username:UserDefaults.standard.string(forKey: "userid") ?? "" )
        
    }
    override func viewDidAppear(_ animated: Bool) {
        initialLoadView()
        navigation()
        viewinitialload()
    }
    func viewinitialload() {
        if selLanguage == "en" {
            englishselectionview.backgroundColor = UIColor(hexFromString: "205072")
            englishselectionview.borderColor = UIColor.white
            arabicSelectionView.backgroundColor = UIColor.lightGray
            arabicSelectionView.borderColor = UIColor.clear
            //changeLayout()
            
        }
        else {
            arabicSelectionView.backgroundColor = UIColor(hexFromString: "205072")
            arabicSelectionView.borderColor = UIColor.white
            englishselectionview.backgroundColor = UIColor.lightGray
            englishselectionview.borderColor = UIColor.clear
            passwordTF.placeholder = "ادخل رقمك السري"
            passwordTF.selectedTitle =  "كلمة المرور"
            passwordTF.title = "كلمة المرور"
            userNameTF.placeholder = "أدخل رقم هاتفك"
            userNameTF.title = "أدخل رقم هاتفك"
            userNameTF.selectedTitle = "أدخل رقم هاتفك"
            fileTF.placeholder = "أدخل هوية الإمارات الخاصة بك"
            fileTF.selectedTitle = "هويه الإمارات"
            fileTF.title = "هويه الإمارات"
        }
       
    }
    func navigation() {
        let isUserLoggedIn:Bool = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(isUserLoggedIn) {
            
            let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")   as! CustomTabBarvc
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    func initialLoadView() {
        phoneNoroundview.layer.cornerRadius = phoneNoroundview.frame.size.width/2
        phoneNoroundview.clipsToBounds = true
        fileNoroundView.layer.cornerRadius = fileNoroundView.frame.size.width/2
        fileNoroundView.clipsToBounds = true
        phoneNoSelectionIMG.image = UIImage(named: "Ellipse 2-1")
        fileNoSelectionIMG.image = UIImage(named: "Ellipse 4")
        passwordIMG.tintColor = UIColor.black
        
        
    }
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        selectedcountry = countrySelectionView.selectedCountry.phoneCode
    }
    func countrypicker() {
        countrySelectionView.showPhoneCodeInView = true
    }
    @IBAction func phoneNoButtonAction(_ sender: UIButton) {
        phoneNoSelectionIMG.image = UIImage(named: "Ellipse 2-1")
        fileNoSelectionIMG.image = UIImage(named: "Ellipse 4")
        fileidView.isHidden = true
        PhoneView.isHidden = false
        userNameTF.keyboardType = .numberPad
        countrySelectionView.isHidden = false
        userNameTF.placeholder = "Enter your Phone Number"
        userNameTF.title = "Phone Number"
        userNameTF.selectedTitle = "Phone Number"
        loginType = 0
        userNameTF.text = nil
        loginType = 1
        
    }
    @IBAction func englishButtonAction(_ sender: UIButton) {
        englishselectionview.backgroundColor = UIColor(hexFromString: "205072")
        englishselectionview.borderColor = UIColor.white
        arabicSelectionView.backgroundColor = UIColor.lightGray
        arabicSelectionView.borderColor = UIColor.clear
        //changeLayout()
        
    

       
    DCLanguageManager.sharedInstance.setLanguage(languageCode: "en")
        changeLayout()
        countrySelectionView.selectedCountry.localizedName()
        
    }
    @IBAction func arabicButtonAction(_ sender: UIButton) {
        arabicSelectionView.backgroundColor = UIColor(hexFromString: "205072")
        arabicSelectionView.borderColor = UIColor.white
        englishselectionview.backgroundColor = UIColor.lightGray
        englishselectionview.borderColor = UIColor.clear
        DCLanguageManager.sharedInstance.setLanguage(languageCode: "ar")
        
            changeLayout()
        
    }
    @IBAction func passwordSeeButtonAction(_ sender: UIButton) {
        if passwordSecured ==  true {
            passwordTF.isSecureTextEntry = false
            passwordIMG.image = UIImage(named: "hide")
            passwordIMG.tintColor = UIColor.black
            passwordSecured = false
            
        }else {
            passwordTF.isSecureTextEntry = true
            passwordIMG.image = UIImage(named: "view")
            
            passwordSecured = true
            
        }
        
        
        
    }
    @IBAction func fileNoButtonAction(_ sender: UIButton) {
        phoneNoSelectionIMG.image = UIImage(named: "Ellipse 4")
        fileNoSelectionIMG.image = UIImage(named: "Ellipse 2-1")
        userNameTF.keyboardType = .default
        fileidView.isHidden = false
        PhoneView.isHidden = true
       // countrySelectionView.isHidden = true
        loginType = 0
        userNameTF.text = nil
        userNameTF.placeholder = "Please enter you File Number"
        userNameTF.title = "File Number"
        userNameTF.selectedTitle = "File Number"
    }
    
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        textvalidation()
        
    }
    
    @IBAction func contactusButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "contactUsVC")   as! contactUsVC
        //   vc.scantype = .faceScanAlone
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func privacyPolicy(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "CustomStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomVC")  as! CustomVC
        vc.Pageid = "2"
      //  tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "SignUpVC")   as! SignUpVC
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func forgotPasswordButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "ForgotPasswordPhoneVC")   as! ForgotPasswordPhoneVC
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
        
        
//        
//        let vc = UIStoryboard.init(name: "ScanSB", bundle:      Bundle.main).instantiateViewController(withIdentifier: "TeethScanLanVC")   as! TeethScanLanVC
//        vc.scantype = .teethScanwithHelp
//        vc.onlyTeethScan = true
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.pushViewController(vc, animated: true)
////
        
        

    }
    @IBAction func currentPasswordseeButtonAction(_ sender: UIButton) {
        
    }
  
        
   
    func textvalidation() {
        if selLanguage == "en" {
            if loginType == 0 {
                if fileTF.text?.isEmpty == true {
                    BannerNotification.failureBanner(message: "Please fill the highlighted field")
                    fileTF.placeholderColor = UIColor.red
                }
                if passwordTF.text?.isEmpty == true {
                    BannerNotification.failureBanner(message:"Please fill the highlighted field")
                    passwordTF.placeholderColor = UIColor.red
                }
                if fileTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false  {
                    
                    login()
                    
                }
                
            }
            else {
                if  userNameTF.text?.isEmpty == true {
                    BannerNotification.failureBanner(message:"Please fill the highlighted field")
                    userNameTF.placeholderColor = UIColor.red
                }
                
                if passwordTF.text?.isEmpty == true {
                    BannerNotification.failureBanner(message: "Please fill the highlighted field")
                    passwordTF.placeholderColor = UIColor.red
                }
                if userNameTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false {
                    phoneno = selectedcountry + (userNameTF.text ?? "")
                    login()
                }
            }
        }else {
            if loginType == 0 {
                if fileTF.text?.isEmpty == true {
                    BannerNotification.failureBanner(message: "يرجى ملء الحقل المميز")
                    fileTF.placeholderColor = UIColor.red
                }
                if passwordTF.text?.isEmpty == true {
                    BannerNotification.failureBanner(message:"يرجى ملء الحقل المميز")
                    passwordTF.placeholderColor = UIColor.red
                }
                if fileTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false  {
                    
                    login()
                    
                }
                
            }
            else {
                if  userNameTF.text?.isEmpty == true {
                    BannerNotification.failureBanner(message:"يرجى ملء الحقل المميز")
                    userNameTF.placeholderColor = UIColor.red
                }
                
                if passwordTF.text?.isEmpty == true {
                    BannerNotification.failureBanner(message: "يرجى ملء الحقل المميز")
                    passwordTF.placeholderColor = UIColor.red
                }
                if userNameTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false {
                    phoneno = selectedcountry + (userNameTF.text ?? "")
                    login()
                }
                
            }
            
        }
    }
    
  
    
}
extension LoginVC {
    enum currentlang {
        case en
        case ar
    }
//    private func setLocalizedStrings() {
//        EnterutnoLBl.text = eExpoLanguageManager.get_localizedString("Enter Your mobile number")
//        loginbtn.setTitle(eExpoLanguageManager.get_localizedString("Login"), for: .normal)
//        EnglishBtn.setTitle(eExpoLanguageManager.get_localizedString("English"), for: .normal)
//        Arabicbtn.setTitle(eExpoLanguageManager.get_localizedString("Arabic"), for: .normal)
//    }
    private func changeLayout() {
        Utility.changeLayoutCorrespondingToLanguage()
     //   restart()

//        let rootViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC")
//      UIApplication.shared.windows.first?.rootViewController = rootViewController
//        var navigationArray = navigationController?.viewControllers
//        navigationArray?.removeAll()
//        navigationArray?.append(rootViewController)
//        self.navigationController?.viewControllers = navigationArray!
//        navigationArray = navigationController?.viewControllers
//        
     
        let rootViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC")
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        navigationArray.removeAll()// To remove previous UIViewController
        navigationArray.append(rootViewController)

        self.navigationController?.viewControllers = navigationArray
        
        
        
//        UIApplication.shared.windows.first?.rootViewController = rootViewController
//        guard let navigationController = self.navigationController else { return }
//        var navigationArray = navigationController.viewControllers
//
//        navigationArray.removeAll()
//        navigationArray.append(rootViewController)
//     //   self.navigationController?.viewControllers = navigationArray
//        navigationArray = self.navigationController!.viewControllers
//
//

        }
    private func restart() {
        let alertController = UIAlertController(title: "Language", message: "To changing language you need to restart application, do you want to restart?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            exit(0)
        }

        let cancelAction = UIAlertAction(title: "Restart later", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    public func refreshtokenapi() {
        let parameters = [
            
            "fileId" :  UserDefaults.standard.string(forKey: "fileID")!,
            "refreshToken":UserDefaults.standard.string(forKey: "refreshToken")!
        ] as [String : Any]
        
        KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "/api/user/refreshToken", methodeType: .post,parameter: parameters) {  (status, response) in
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
                    if response["success"] as? String  == "1" {
                        BannerNotification.failureBanner(message: "\(response["message"]!)")
                        UserDefaults.standard.set("", forKey: "fileID")
                        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                        UserDefaults.standard.set("", forKey: "userid")
                        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "LoginVC")   as! LoginVC
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
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




    


