//
//  SignUpVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 20/10/2022.
//

import UIKit
import SkyFloatingLabelTextField
import CountryPickerView

class SignUpVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, CountryPickerViewDelegate,CountryPickerViewDataSource {
    
    var isexsisting:Bool?
    var signupType:Int? = 0
    var checkmodel:CheckPatientModel!
    var needediting:Bool?
    var pickertype = 1
    var phoneno = ""
    let datePickerView:UIDatePicker = UIDatePicker()
    var selectedcountry:String?
    var genderdata = ["Select Gender","Male","Female","Prefer not to Say"]
    var genderardata = ["حدد نوع الجنس","ذكر","أنثى","افضل عدم القول"]
    var cityData = ["Select City","Abu Dhabi", "Dubai", "Sharjah", "Ajman", "Umm Al Quwain", "Ras Al Khaimah", "Fujairah"]
    var cituDataar = ["اختر مدينة","أبو ظبي","دبي","الشارقة","عجمان","أم القيوين","رأس الخيمة","الفجيرة"]
    var city:String? = "Select City"
    var gender:String? = "Select Gender"
    var emiratesid:String?
    var password:Bool?
    var signModel:SignupModel!
    var emiratesidtext:String?
    var filenumbertext:String?
    @IBOutlet weak var backImage: UIImageView!
    var passwordSecured = true
    @IBOutlet weak var doneView: UIView!
    
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var passwordVaslidView: UIView!
    @IBOutlet weak var donebutton: UIButton!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editbutton: UIButton!
    @IBOutlet weak var EmioratesIdSelectionIMG: UIImageView!
    @IBOutlet weak var patientRegisterButton: UIButton!
    @IBOutlet weak var otpTf: SkyFloatingLabelTextField!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var fileNoselectionIMG: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var nextStepLabel: UILabel!
    @IBOutlet weak var userNameCPTF: SkyFloatingLabelTextField!
    @IBOutlet weak var signupPasswordimg: UIImageView!
    @IBOutlet weak var passwordvalidview: UIView!
    @IBOutlet weak var fileIdView: UIView!
    @IBOutlet weak var emiratesidView: UIView!
    @IBOutlet weak var resendButton: UIButton!
   
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var exsistingpasswordsee: UIImageView!
    @IBOutlet weak var resendButtonView: UIView!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var nextStepbutton: UIButton!
    @IBOutlet weak var fileNoselectionButton: UIButton!
    @IBOutlet weak var emiratesidSelectionButton: UIButton!
    @IBOutlet weak var passwordValidationExsistingView: UILabel!
    @IBOutlet weak var passwordEcsistingTF: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordSignupValidationView: UILabel!
    @IBOutlet weak var passwordsignupTf: SkyFloatingLabelTextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dobTF: SkyFloatingLabelTextField!
    @IBOutlet weak var dropdowngenderIMg: UIImageView!
    @IBOutlet weak var dropdowncityIMg: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var fileNoSignupTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emiratesidSignUpTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailIDView: SkyFloatingLabelTextField!
    @IBOutlet weak var countryView: CountryPickerView!
    @IBOutlet weak var phoneNoTF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var firstnameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var PatientButtonView: UIView!
    @IBOutlet weak var passwordSeeButtonSignup: UIButton!
    @IBOutlet weak var passwordSeeExsisting: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var nextStepView: UIView!
    @IBOutlet weak var cpUserView: UIView!
    @IBOutlet weak var SelectionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        emiratesidView.isHidden = true
    picker.delegate = self
    picker.dataSource = self
        datePickerView.datePickerMode = .date
        countryView.delegate = self
        countryView.dataSource = self
        selectedcountry = countryView.selectedCountry.phoneCode
        patientRegisterButton.isHidden = true
        self.dobTF.datePicker(target: self,
                                  doneAction: #selector(doneAction),
                                  cancelAction: #selector(cancelAction),
                                  datePickerMode: .date)
        
        passwordsignupTf.isSecureTextEntry = true
        passwordEcsistingTF.isSecureTextEntry = true
        countryView.font = .systemFont(ofSize: 14)
        viewinitialload()
       
        //  fileIdView.isHidden = true
    }
    func viewinitialload() {
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
            
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
            userNameCPTF.placeholder = "أدخل هوية الإمارات الخاصة بك"
            userNameCPTF.selectedTitle = "هويه الإمارات"
            userNameCPTF.title = "هويه الإمارات"
            firstnameTF.placeholder = "أدخل اسمك الأول"
            firstnameTF.selectedTitle = "الاسم الاول"
            firstnameTF.title = "الاسم الاول"
            lastNameTF.placeholder = "أدخل اسمك الأخير"
            lastNameTF.selectedTitle = "الكنية"
            lastNameTF.title = "الكنية"
            emiratesidSignUpTF.placeholder = "أدخل هوية الإمارات الخاصة بك"
            emiratesidSignUpTF.selectedTitle = "هويه الإمارات"
            emiratesidSignUpTF.title = "هويه الإمارات"
            fileNoSignupTF.placeholder = "أدخل رقم الملف الخاص بك"
            fileNoSignupTF.title = "رقم الملف"
            fileNoSignupTF.selectedTitle = "رقم الملف"
            emailIDView.placeholder = "أدخل معرف البريد الإلكتروني الخاص بك"
            emailIDView.selectedTitle = "عنوان الايميل"
            emailIDView.title = "عنوان الايميل"
            genderLabel.text = "حدد نوع الجنس"
            dobTF.placeholder = "أدخل تاريخ ميلادك"
            dobTF.selectedTitle = "تاريخ الولادة"
            dobTF.title = "تاريخ الولادة"
            cityLabel.text = "اختر مدينة"
            passwordsignupTf.placeholder = "ادخل رقمك السري"
            passwordsignupTf.title = "كلمة المرور"
            passwordsignupTf.selectedTitle = "كلمة المرور"
            
            
            
            
        }
        
    }
    @IBAction func doneButtonDropAction(_ sender: Any) {
        
        
        
        picker.isHidden = true
        doneView.isHidden = true
        donebutton.isEnabled = false
        cancelButton.isEnabled = false
        pickerContainerView.isHidden = true
        if pickertype == 1{
           
            cityLabel.text = city
            cityLabel.textColor = UIColor.black
        }
        else {
         
            genderLabel.text = gender
            genderLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func fileNoSelectionButtonAction(_ sender: UIButton) {
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
        
        EmioratesIdSelectionIMG.image = UIImage(named: "Ellipse 4")
        fileNoselectionIMG.image = UIImage(named: "Ellipse 2-1")
        
        userNameCPTF.keyboardType = .default
        userNameCPTF.text = nil
        userNameCPTF.placeholder = "Enter your File Number"
        userNameCPTF.selectedTitle = "File Number"
        userNameCPTF.title = "File Number"
        fileIdView.isHidden = true
        emiratesidView.isHidden = false
        signupType = 1
    }
        else {
            EmioratesIdSelectionIMG.image = UIImage(named: "Ellipse 4")
            fileNoselectionIMG.image = UIImage(named: "Ellipse 2-1")
            
            userNameCPTF.keyboardType = .default
            userNameCPTF.text = nil
            userNameCPTF.placeholder = "أدخل ملفك لا"
            userNameCPTF.selectedTitle = "رقم الملف"
            userNameCPTF.title = "رقم الملف"
            fileIdView.isHidden = true
            emiratesidView.isHidden = false
            signupType = 1
        }
    }
    
    @IBAction func passwordAction(_ sender: UITextField) {
        if passwordsignupTf.text?.count ?? 0 < 6 {
            passwordVaslidView.isHidden = false
        }
    }
    @IBAction func emiratesidSelectionAction(_ sender: UIButton) {
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            
            EmioratesIdSelectionIMG.image = UIImage(named: "Ellipse 2-1")
            fileNoselectionIMG.image = UIImage(named: "Ellipse 4")
            userNameCPTF.keyboardType = .numberPad
            
            userNameCPTF.text = nil
            userNameCPTF.placeholder = "Enter your Emirates ID"
            userNameCPTF.selectedTitle = "Emirates ID"
            userNameCPTF.title = "Emirates ID"
            emiratesidView.isHidden = true
            fileIdView.isHidden = false
            signupType = 0
        }else {
            EmioratesIdSelectionIMG.image = UIImage(named: "Ellipse 2-1")
            fileNoselectionIMG.image = UIImage(named: "Ellipse 4")
            userNameCPTF.keyboardType = .numberPad
            
            userNameCPTF.text = nil
            userNameCPTF.placeholder = "أدخل هوية الإمارات الخاصة بك"
            userNameCPTF.selectedTitle = "هويه الإمارات"
            userNameCPTF.title = "هويه الإمارات"
            emiratesidView.isHidden = true
            fileIdView.isHidden = false
            signupType = 0
        }
    }
//    @IBAction func pickergesture(_ sender: UITapGestureRecognizer) {
//        picker.isHidden = true
//        pickerContainerView.isHidden = true
//        donebutton.isEnabled = false
//        cancelButton.isEnabled = false
//    }
    
    
    @IBAction func editUserButtonAction(_ sender: UIButton) {
        SelectionView.isHidden = false
        //usernameView.isHidden = true
        nextStepView.isHidden = false
        nextStepbutton.isHidden = false
            passwordView.isHidden = true
            registerView.isHidden = true
           // dropdownButton.isEnabled = true
            userNameCPTF.isEnabled = true
            needediting = false
            registerView.isHidden = true
            PatientButtonView.isHidden = true
        patientRegisterButton.isHidden = true
        editbutton.isEnabled = false
        editView.isHidden = true
        hiddenView.isHidden = true
          //  nextstepLabel.text = "Edit"
            //registerButtonView.isHidden =  false
       
        
    }
    func checkpatientvalidation() {
        if userNameCPTF.text?.isEmpty == true {
            
                userNameCPTF.placeholderColor = UIColor.red
                userNameCPTF.titleColor = UIColor.red
               // userNameCPTF.selectedTitleColor = UIColor.red
            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                
                BannerNotification.failureBanner(message: "please fill the required field")
            }else {
                BannerNotification.failureBanner(message: "الرجاء تعبئة الحقول المطلوبة")
            }
        }
        else {
            checkpatient()
        }
    }
   
    @IBAction func passwordclinic(_ sender: SkyFloatingLabelTextField) {
        if  passwordEcsistingTF.text?.count ?? 0 < 8 {
          passwordvalidview.isHidden = false
        }
    }
    @IBAction func nextSteoButtonAction(_ sender: UIButton) {
        checkpatientvalidation()
    }
    
    @IBAction func genderButtonAction(_ sender: UIButton) {
        picker.isHidden = false
        doneView.isHidden = false
        donebutton.isEnabled = true
        cancelButton.isEnabled = true
        pickertype = 0
        pickerContainerView.isHidden = false
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.reloadAllComponents()
       
        view.endEditing(true)
    }
    
    @IBAction func cityButtonAction(_ sender: UIButton) {
        picker.isHidden = false
        doneView.isHidden = false
        donebutton.isEnabled = true
        cancelButton.isEnabled = true
        pickertype = 1
        pickerContainerView.isHidden = false
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.reloadAllComponents()
        view.endEditing(true)
      
        
    }
    @IBAction func signupPasswordSeeButtonAction(_ sender: UIButton) {
        if passwordSecured ==  true {
            passwordsignupTf.isSecureTextEntry = false
            signupPasswordimg.image = UIImage(named: "hide")
            signupPasswordimg.tintColor = UIColor.black
            passwordSecured = false
            
        }else {
            passwordsignupTf.isSecureTextEntry = true
            signupPasswordimg.image = UIImage(named: "view")
            passwordSecured = true
            
        }

    }
    
    @IBAction func exsistingPasswordSeeButtonAction(_ sender: UIButton) {
        if passwordSecured ==  true {
            passwordEcsistingTF.isSecureTextEntry = false
            exsistingpasswordsee.image = UIImage(named: "hide")
            exsistingpasswordsee.tintColor = UIColor.black
            passwordSecured = false
            
        }else {
            passwordEcsistingTF.isSecureTextEntry = true
            exsistingpasswordsee.image = UIImage(named: "view")
            passwordSecured = true
            
        }

    }
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        pickerContainerView.isHidden = true
        picker.isHidden = true
        doneView.isHidden = true
        donebutton.isEnabled = false
        cancelButton.isEnabled = false
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func PatientRegisterButtonAction(_ sender: UIButton) {
        if checkmodel.isExisting == 0 {
            phoneno = (selectedcountry ?? "+971")   + (phoneNoTF.text ?? "")
            if signupType == 0 {
              textvalidationemirates()
            }else {
                textvalidationfile()
            }
           
        }else
        if checkmodel.phoneVerified == 0 {
            passwordvalidexsisting()
        }else{
            phoneno = (selectedcountry ?? "+971") + (phoneNoTF.text ?? "")
            if signupType == 0 {
              textvalidationemirates()
            }else {
                textvalidationfile()
            }
        }
    }
    @IBAction func resendButtonAction(_ sender: UIButton) {
       resendotp()
    }
    func checkpatientconditions() {
        if checkmodel.isExisting == 1 {
            if checkmodel.activeRequested == 1 && checkmodel.phoneVerified == 0 {
//                registerView.isHidden = true
//                passwordView.isHidden = false
//                userNameCPTF.isEnabled = false
//                PatientButtonView.isHidden = false
//                registerButton.isHidden = false
//                nextstepLabel.text = "Edit"
//                needediting = true
//                registerButtonView.isHidden =  false
  //           resendbutton.isEnabled = true
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                vc.fileid = self.checkmodel?.fileId
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else   if checkmodel.activeRequested == 1 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC

                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if checkmodel.clinicVerified == 1{
                registerView.isHidden = true
                passwordView.isHidden = false
              //  userNameCPTF.isEnabled = false
                hiddenView.isHidden = false
                editView.isHidden = false
                editbutton.isEnabled = true
                PatientButtonView.isHidden = false
                patientRegisterButton.isHidden = false
                nextStepLabel.text = "Edit"
                needediting = true
                PatientButtonView.isHidden =  false
                resendButton.isEnabled = true
                patientRegisterButton.isHidden = false
                
            }
            else if checkmodel.phoneVerified == 0 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                vc.fileid = self.checkmodel?.fileId
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc, animated: true)
                }
            else {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
               
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
            
            
    else {
        SelectionView.isHidden = true
        //usernameView.isHidden = true
        nextStepView.isHidden = true
        nextStepbutton.isHidden = true
            passwordView.isHidden = true
            registerView.isHidden = false
        userNameCPTF.resignFirstResponder()
           // dropdownButton.isEnabled = true
           // userNameCPTF.isEnabled = false
        hiddenView.isHidden = false
            needediting = true
            registerView.isHidden = false
            PatientButtonView.isHidden = false
        patientRegisterButton.isHidden = false
        editView.isHidden = false
        editbutton.isEnabled = true
          //  nextstepLabel.text = "Edit"
            //registerButtonView.isHidden =  false
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickertype == 1{
           return  cityData.count
        }
        else {
          return  genderdata.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            
            if pickertype == 1{
                return cityData[row]
            }else {
                return genderdata[row]
            }
        }
        else {
            if pickertype == 1{
                return cituDataar[row]
            }else {
                return genderardata[row]
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            if pickertype == 1{
                city = String(cityData[row])
                
            }
            else {
                gender = String(genderdata[row])
                
            }
        }else {
            if pickertype == 1{
                city = String(cituDataar[row])
            }else {
                gender = String(genderardata[row])
            }
        }
    }
    func textvalidationemirates() {
      if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en-AE" {
        
        if firstnameTF.text?.isEmpty == true {
            firstnameTF.placeholderColor = UIColor.red
            
            BannerNotification.failureBanner(message: "Please Fill Highlighted Fields")
        }
        if lastNameTF.text?.isEmpty == true {
            lastNameTF.placeholderColor = UIColor.red
            
            BannerNotification.failureBanner(message: "Please Fill Highlighted Fields")
        }
        if phoneNoTF.text?.isEmpty == true {
            phoneNoTF.placeholderColor = UIColor.red
            
            BannerNotification.failureBanner(message: "Please Fill Highlighted Fields")
        }
//        if fileNoSignupTF.text?.isEmpty == true {
//            if signupType == 0 {
//                fileNoSignupTF.placeholderColor = UIColor.red
//
//                BannerNotification.failureBanner(message: "Please Fill Highlighted Fields")
//            }
//        }
        if emailIDView.text?.isValidEmail() == false {
            emailIDView.placeholderColor = UIColor.red
            emailIDView.titleColor = UIColor.red
            
            BannerNotification.failureBanner(message: "please fill the email id in proper format")
            
        }
        if genderLabel.text == "Select Gender" {
            BannerNotification.failureBanner(message: "Please Select Gender")
            genderLabel.textColor = UIColor.red
        }
        if dobTF.text?.isEmpty == true {
            BannerNotification.failureBanner(message: "Please Select Your Date of Birth")
            dobTF.placeholderColor = UIColor.red
            
        }
        if cityLabel.text == "Select City" {
            BannerNotification.failureBanner(message: "Please Select Your City")
            cityLabel.textColor = UIColor.red
        }
        if passwordsignupTf.text?.count ?? 0 < 8 {
            passwordsignupTf.placeholderColor = UIColor.red
            passwordVaslidView.isHidden = true
        }
        
        if firstnameTF.text?.isEmpty == false &&  lastNameTF.text?.isEmpty == false && phoneNoTF.text?.isEmpty == false  && emailIDView.text?.isValidEmail() == true && genderLabel.text != "Select Gender" &&  dobTF.text?.isEmpty == false && cityLabel.text != "Select City" && passwordsignupTf.text?.count ?? 0  > 5 {
            emiratesidtext = userNameCPTF.text
            filenumbertext = fileNoSignupTF.text
            phoneno = countryView.selectedCountry.phoneCode + (phoneNoTF.text ?? "")
            signup()
            // passwordvalid()
           // && fileNoSignupTF.text?.isEmpty == false
        }
        } else {
            gender = "حدد نوع الجنس"
            city = "اختر مدينة"
            if firstnameTF.text?.isEmpty == true {
                firstnameTF.placeholderColor = UIColor.red
                
                BannerNotification.failureBanner(message: "الرجاء ملء الحقول المميزة")
            }
            if lastNameTF.text?.isEmpty == true {
                lastNameTF.placeholderColor = UIColor.red
                
                BannerNotification.failureBanner(message: "الرجاء ملء الحقول المميزة")
            }
            if phoneNoTF.text?.isEmpty == true {
                phoneNoTF.placeholderColor = UIColor.red
                
                BannerNotification.failureBanner(message: "الرجاء ملء الحقول المميزة")
            }
//            if fileNoSignupTF.text?.isEmpty == true {
//                if signupType == 0 {
//                    fileNoSignupTF.placeholderColor = UIColor.red
//
//                    BannerNotification.failureBanner(message: "الرجاء ملء الحقول المميزة")
//                }
//            }
            if emailIDView.text?.isValidEmail() == false {
                emailIDView.placeholderColor = UIColor.red
                emailIDView.titleColor = UIColor.red
                
                BannerNotification.failureBanner(message: "يرجى ملء معرف البريد الإلكتروني بالتنسيق المناسب")
                
            }
            if genderLabel.text == "حدد نوع الجنس" {
                BannerNotification.failureBanner(message: "يرجى تحديد الجنس")
                genderLabel.textColor = UIColor.red
            }
            if dobTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "الرجاء تحديد تاريخ ميلادك")
                dobTF.placeholderColor = UIColor.red
                
            }
            if cityLabel.text == "اختر مدينة" {
                BannerNotification.failureBanner(message: "الرجاء تحديد مدينتك")
                cityLabel.textColor = UIColor.red
            }
            if passwordsignupTf.text?.count ?? 0 < 8 {
                passwordsignupTf.placeholderColor = UIColor.red
                passwordVaslidView.isHidden = true
            }
            
            if firstnameTF.text?.isEmpty == false &&  lastNameTF.text?.isEmpty == false && phoneNoTF.text?.isEmpty == false && emailIDView.text?.isValidEmail() == true && genderLabel.text != "حدد نوع الجنس" &&  dobTF.text?.isEmpty == false && cityLabel.text != "اختر مدينة" && passwordsignupTf.text?.count ?? 0  > 5 {
                emiratesidtext = userNameCPTF.text
                filenumbertext = fileNoSignupTF.text
                phoneno = countryView.selectedCountry.phoneCode + (phoneNoTF.text ?? "")
                signup()
                // passwordvalid()
               // && fileNoSignupTF.text?.isEmpty == false 
            }
            }
            
        
        
        }
    func textvalidationfile() {
       
            if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
              
              if firstnameTF.text?.isEmpty == true {
                  firstnameTF.placeholderColor = UIColor.red
                  
                  BannerNotification.failureBanner(message: "Please Fill Highlighted Fields")
              }
              if lastNameTF.text?.isEmpty == true {
                  lastNameTF.placeholderColor = UIColor.red
                  
                  BannerNotification.failureBanner(message: "Please Fill Highlighted Fields")
              }
              if phoneNoTF.text?.isEmpty == true {
                  phoneNoTF.placeholderColor = UIColor.red
                  
                  BannerNotification.failureBanner(message: "Please Fill Highlighted Fields")
              }
      //        if fileNoSignupTF.text?.isEmpty == true {
      //            if signupType == 0 {
      //                fileNoSignupTF.placeholderColor = UIColor.red
      //
      //                BannerNotification.failureBanner(message: "Please Fill Highlighted Fields")
      //            }
      //        }
              if emailIDView.text?.isValidEmail() == false {
                  emailIDView.placeholderColor = UIColor.red
                  emailIDView.titleColor = UIColor.red
                  
                  BannerNotification.failureBanner(message: "please fill the email id in proper format")
                  
              }
              if genderLabel.text == "Select Gender" {
                  BannerNotification.failureBanner(message: "Please Select Gender")
                  genderLabel.textColor = UIColor.red
              }
              if dobTF.text?.isEmpty == true {
                  BannerNotification.failureBanner(message: "Please Select Your Date of Birth")
                  dobTF.placeholderColor = UIColor.red
                  
              }
              if cityLabel.text == "Select City" {
                  BannerNotification.failureBanner(message: "Please Select Your City")
                  cityLabel.textColor = UIColor.red
              }
              if passwordsignupTf.text?.count ?? 0 < 8 {
                  passwordsignupTf.placeholderColor = UIColor.red
                  passwordVaslidView.isHidden = true
              }
                if emiratesidSignUpTF.text?.isEmpty == true {
                    
                    emiratesidSignUpTF.placeholderColor = UIColor.red
                    emiratesidSignUpTF
                        .titleColor = UIColor.red
                    BannerNotification.failureBanner(message: "Please enter your emirates id")
                }
              
                if firstnameTF.text?.isEmpty == false &&  lastNameTF.text?.isEmpty == false && phoneNoTF.text?.isEmpty == false  && emailIDView.text?.isValidEmail() == true && genderLabel.text != "Select Gender" &&  dobTF.text?.isEmpty == false && emiratesidSignUpTF.text?.isEmpty == false && cityLabel.text != "Select City" && passwordsignupTf.text?.count ?? 0  > 5 {
                  emiratesidtext = userNameCPTF.text
                  filenumbertext = fileNoSignupTF.text
                  phoneno = countryView.selectedCountry.phoneCode + (phoneNoTF.text ?? "")
                  signup()
                  // passwordvalid()
                 // && fileNoSignupTF.text?.isEmpty == false
              }

        }
        else {
            
            
            
            gender = "حدد نوع الجنس"
            city = "اختر مدينة"
            
            if firstnameTF.text?.isEmpty == true {
                firstnameTF.placeholderColor = UIColor.red
                firstnameTF.titleColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء تحديد تاريخ ميلادك")
            }
            if lastNameTF.text?.isEmpty == true {
                lastNameTF.placeholderColor = UIColor.red
                lastNameTF.titleColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء تحديد تاريخ ميلادك")
            }
            if phoneNoTF.text?.isEmpty == true {
                phoneNoTF.placeholderColor = UIColor.red
                phoneNoTF.titleColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء تحديد تاريخ ميلادك")
            }
            if emiratesidSignUpTF.text?.isEmpty == true {
                
                emiratesidSignUpTF.placeholderColor = UIColor.red
                emiratesidSignUpTF
                    .titleColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء تحديد تاريخ ميلادك")
            }
            
            if emailIDView.text?.isValidEmail() == false {
                emailIDView.placeholderColor = UIColor.red
                emailIDView.titleColor = UIColor.red
                BannerNotification.failureBanner(message: "يرجى ملء البريد الإلكتروني بالتنسيق الصحيح.")
                
            }
            if genderLabel.text == "حدد نوع الجنس" {
                BannerNotification.failureBanner(message: "يرجى تحديد الجنس")
                genderLabel.textColor = UIColor.red
                genderLabel.textColor = UIColor.red
            }
            if dobTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "الرجاء تحديد تاريخ ميلادك")
                dobTF.placeholderColor = UIColor.red
                dobTF.titleColor = UIColor.red
            }
            if cityLabel.text == "اختر مدينة" {
                BannerNotification.failureBanner(message: "الرجاء تحديد مدينتك")
                cityLabel.textColor = UIColor.red
            }
            if passwordsignupTf.text?.count ?? 0 < 6  {
                BannerNotification.failureBanner(message: "من فضلك أدخل رقمك السري")
                passwordVaslidView.isHidden = false
            }
            
            if firstnameTF.text?.isEmpty == false &&  lastNameTF.text?.isEmpty == false && phoneNoTF.text?.isEmpty == false && emiratesidSignUpTF.text?.isEmpty == false && emailIDView.text?.isValidEmail() == true && genderLabel.text != "حدد نوع الجنس" &&  dobTF.text?.isEmpty == false && cityLabel.text != "اختر مدينة" && passwordsignupTf.text?.count ?? 0 <= 8   {
                emiratesidtext = emiratesidSignUpTF.text
                filenumbertext = userNameCPTF.text
                phoneno = countryView.selectedCountry.phoneCode + (phoneNoTF.text ?? "")
                signup()
                //  passwordvalid()
            }
            
        }
        
    }
    func validpassword(mypassword : String) -> Bool
        {

            let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
            let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
            return passwordtesting.evaluate(with: mypassword)
        
    }
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        selectedcountry = countryView.selectedCountry.phoneCode
    }
    func countrypicker() {
        countryView.showPhoneCodeInView = true
        countryView.selectedCountry.localizedName()
        
    }
    
    

    func passwordvalid() {
        
        let password = validpassword(mypassword: passwordsignupTf.text!) //get text Field data & checked through the function
                 if(password == false)
                {
                    BannerNotification.failureBanner(message: "invalid password")
                     passwordVaslidView.isHidden = false
                }
                else
                {
                    
                    
                   
                }
    }
    @objc func cancelAction() {
    self.dobTF.resignFirstResponder()
}

@objc func doneAction() {
    if let datePickerView = self.dobTF.inputView as? UIDatePicker {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: datePickerView.date)
        self.dobTF.text = dateString
        
        print(datePickerView.date)
        print(dateString)
        
        self.dobTF.resignFirstResponder()
    }
}
    @objc func doneDropAction() {
        picker.isHidden = true
            
         
        
    }
    func passwordvalidexsisting() {
        
        let password = validpassword(mypassword: passwordEcsistingTF.text!) //get text Field data & checked through the function
                 if(password == false)
                {
                    BannerNotification.failureBanner(message: "invalid password") //Use to Alert Msg Box
                }
                else
                {
                  
                        verifyotp()
                    
                   
                   
                }
//        if passwordTextfield != confirmPasswordTF {
//            BannerNotification.failureBanner(message: "Please Confirm the password")
            
        
    }
    

}
