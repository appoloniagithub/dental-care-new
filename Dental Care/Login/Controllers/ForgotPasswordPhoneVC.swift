//
//  ForgotPasswordPhoneVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 21/10/2022.
//

import UIKit
import CountryPickerView
import SkyFloatingLabelTextField

class ForgotPasswordPhoneVC: UIViewController,CountryPickerViewDataSource,CountryPickerViewDelegate {
    var phoneno:String?
    var model:forgotmodel!
    var selectedcountry:String?
    @IBOutlet weak var phonenoTF: SkyFloatingLabelTextField!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var countryview: CountryPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        countryview.delegate = self
        countryview.dataSource = self
        phoneno = countryview.selectedCountry.phoneCode + (phonenoTF.text ?? "")
        countryview.font = .systemFont(ofSize: 14)
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
            phonenoTF.placeholder = "أدخل رقم هاتفك"
            phonenoTF.selectedTitle = "رقم التليفون"
            phonenoTF.title = "رقم التليفون"
        }
    }
    
    @IBAction func verifyButtonAction(_ sender: UIButton) {
        phoneno = (selectedcountry ?? "+971") + (phonenoTF.text ?? "")
        requstPassword()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        selectedcountry = countryview.selectedCountry.phoneCode
    }
    func countrypicker() {
        countryview.showPhoneCodeInView = true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
