//
//  OTPVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 21/10/2022.
//

import UIKit
import SkyFloatingLabelTextField

class OTPVC: UIViewController {
    var fileid:String?
    var verifymodel:Verifymodel!
    var fromdelete:Bool?
    var isfromforgot:Bool?
    var phoneno:String?
    var delegate:profiledelegate?

    @IBOutlet weak var OTPTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var backImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if fromdelete == true {
            
            deleteotp()
        }
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
            OTPTF.placeholder = "رقم التليفون"
            
        }

        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        if fromdelete == true {
            navigationController?.popViewController(animated: true)
            delegate?.tabbar()
        }
        else {
            navigationController?.popToViewController(ofClass: LoginVC.self)
        }
    }
    
    @IBAction func resendButtonAction(_ sender: UIButton) {
        if fromdelete == true {
            OTPTF.text = nil
            deleteotp()
            view.endEditing(true)
        }
        else if isfromforgot == true {
            OTPTF.text = nil
            requstPassword()
            view.endEditing(true)
        }
        else {
            OTPTF.text = nil
            resendotp()
            view.endEditing(true)
        }
    }
    
    @IBAction func verifyButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            if OTPTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "Please Enter OTP")
            }
            else {
                if isfromforgot ==  true {
                    verifyotpforgot()
                }
                else if fromdelete == true {
                    verifyOtpDelete()
                }
                else {
                    verifyotp()
                }
            }
        }else {
            if OTPTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "الرجاء إدخال OTP")
            }
            else {
                if isfromforgot ==  true {
                    verifyotpforgot()
                }
                else if fromdelete == true {
                    verifyOtpDelete()
                }
                else {
                    verifyotp()
                }
            }

            
        }
    }
    
  

}
