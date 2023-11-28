//
//  SetPasswordVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 24/10/2022.
//

import UIKit
import SkyFloatingLabelTextField

class SetPasswordVC: UIViewController {
    var fromforgot:Bool?
    var fileID:String?
    var otp:String?
    var passmodel:passwordmodel!
    var passwordvalid:Bool?
    var delegate:profiledelegate?
    var currentpasswordSecured:Bool? = true
    var newPasswordSecured:Bool? = true

    @IBOutlet weak var newPasswordViewimage: UIImageView!
    @IBOutlet weak var currentpasswordView: UIImageView!
    @IBOutlet weak var newPasswordView: UIView!
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var confirmTF: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var newPasswordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var currentPasswordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var currentPasswordView: UIView!
    @IBOutlet weak var validationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if fromforgot == true {
            currentPasswordView.isHidden = true
        }
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
            currentPasswordTF.placeholder = "إدخل كلمة السر الحالية"
            currentPasswordTF.selectedTitle = "كلمة المرور الحالي"
            currentPasswordTF.title = "كلمة المرور الحالي"
            newPasswordTF.selectedTitle = "كلمة مرور جديدة"
            newPasswordTF.title = "كلمة مرور جديدة"
            newPasswordTF.placeholder = "الرجاء إدخال كلمة مرور جديدة"
            confirmTF.title = "Confirm Password"
            confirmTF.selectedTitle = "Confirm Password"
            confirmTF.placeholder = "الرجاء تأكيد كلمة المرور"
        }
        
       
    }
    
    @IBAction func currentPasswordseeButtonAction(_ sender: UIButton) {
        if currentpasswordSecured ==  true {
            currentPasswordTF.isSecureTextEntry = false
            currentpasswordView.image = UIImage(named: "hide")
            currentpasswordView.tintColor = UIColor.black
            currentpasswordSecured = false
            
        }else {
            currentPasswordTF.isSecureTextEntry = true
            currentpasswordView.image = UIImage(named: "view")
            
            currentpasswordSecured = true
            
        }
        
    }
    @IBAction func newPasswordSeeButtonAction(_ sender: UIButton) {
        if newPasswordSecured ==  true {
            newPasswordTF.isSecureTextEntry = false
            newPasswordViewimage.image = UIImage(named: "hide")
            newPasswordViewimage.tintColor = UIColor.black
            newPasswordSecured = false
            
        }else {
            newPasswordTF.isSecureTextEntry = true
            newPasswordViewimage.image = UIImage(named: "view")
            
            newPasswordSecured = true
            
        }
        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        if fromforgot == true {
           
            navigationController?.popToViewController(ofClass: LoginVC.self)
        }
        else {
            delegate?.tabbar()
            navigationController?.popViewController(animated: true)
        }
       
    }
    
    @IBAction func verifyPasswordButtonAction(_ sender: UIButton) {
        if fromforgot == true {
            if newPasswordTF.text?.count ?? 0 < 6  {
                validationView.isHidden = false
            BannerNotification.failureBanner(message: "Please enter the  password")
        }
            else   if newPasswordTF.text == confirmTF.text {
            //if passwordvalid == true {
           newpassword()
//            }
        }else {
           
            BannerNotification.failureBanner(message: "Confirm Password and Password doesnt match")
            
        }
            
       
    }
        else {
            if newPasswordTF.text?.count ?? 0 < 6  {
                validationView.isHidden = false
                BannerNotification.failureBanner(message: "Please enter the  password")
            }
         else    if newPasswordTF.text == confirmTF.text {
   //             if passwordvalid == true {
                    changepassword()
//                }
            }else {
               
                BannerNotification.failureBanner(message: "Confirm Password and Password doesnt match")
                
            }
            
        }
    }
    
//    @IBAction func newPasswordaction(_ sender: SkyFloatingLabelTextField) {
//        passwordvalidexsisting()
//    }
    func passwordvalidexsisting() {
        
        let password = validpassword(mypassword: newPasswordTF.text!) //get text Field data & checked through the function
                 if(password == false)
                {
                    BannerNotification.failureBanner(message: "invalid password")
                     validationView.isHidden = false
                }
                else
                {
                    
                    passwordvalid = true
           
                   
                }


    func validpassword(mypassword : String) -> Bool
        {

            let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
            let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
            return passwordtesting.evaluate(with: mypassword)
        
    }
    

}
}
