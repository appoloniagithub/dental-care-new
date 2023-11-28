//
//  AddMemberVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import UIKit
import Kingfisher
import SkyFloatingLabelTextField

class AddMemberVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var model:membermodel!
    var pickertype = 1
    let datePickerView:UIDatePicker = UIDatePicker()
    var genderdata = ["Select Gender","Male","Female","Prefer not to Say"]
    var cityData = ["Select City","Abu Dhabi", "Dubai", "Sharjah", "Ajman", "Umm Al Quwain", "Ras Al Khaimah", "Fujairah"]
    var genderardata = ["حدد نوع الجنس","ذكر","أنثى","افضل عدم القول"]
    var cituDataar = ["اختر مدينة","أبو ظبي","دبي","الشارقة","عجمان","أم القيوين","رأس الخيمة","الفجيرة"]
    var imagePicker = UIImagePickerController()
    var pickedImages: UIImage?
    var gender:String? = "Select Gender"
    var city:String? = "Select City"
    var fromscansetting:Bool?
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var dobTF: SkyFloatingLabelTextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailIDTF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var fileNumberTF: SkyFloatingLabelTextField!
    @IBOutlet weak var proimage: UIImageView!
    @IBOutlet weak var emiratesTF: SkyFloatingLabelTextField!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self
        imagePicker.delegate = self
        datePickerView.datePickerMode = .date
        self.dobTF.datePicker(target: self,
                                  doneAction: #selector(doneAction),
                                  cancelAction: #selector(cancelAction),
                                  datePickerMode: .date)
        proimage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage") ?? ""))
        proimage.layer.cornerRadius = proimage.frame.size.width/2
        proimage.clipsToBounds = true
        
        viewinitialload()
    }
    func viewinitialload() {
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
            emiratesTF.placeholder = "أدخل هوية الإمارات الخاصة بك"
            emiratesTF.selectedTitle = "هويه الإمارات"
            emiratesTF.title = "هويه الإمارات"
            fileNumberTF.placeholder = "أدخل رقم الملف الخاص بك"
            fileNumberTF.title = "رقم الملف"
            fileNumberTF.selectedTitle = "رقم الملف"
            firstNameTF.placeholder = "أدخل اسمك الأول"
            firstNameTF.title = "الاسم الاول"
            firstNameTF.selectedTitle = "الاسم الاول"
            lastNameTF.placeholder = "أدخل اسمك الأخير"
            lastNameTF.selectedTitle = "الكنية"
            lastNameTF.title = "الكنية"
            emailIDTF.placeholder = "أدخل بريدك الإلكتروني - المعرف"
            emailIDTF.selectedTitle = "عنوان الايميل"
            emailIDTF.title = "عنوان الايميل"
            emailIDTF.selectedTitle = "عنوان الايميل"
            dobTF.placeholder = "أدخل تاريخ ميلادك"
            dobTF.selectedTitle = "تاريخ الولادة"
            dobTF.title = "تاريخ الولادة"
            
        }
    }
    @IBAction func doneButtonAction(_ sender: UIButton) {
        containerView.isHidden = true
        if pickertype == 1{
            cityLabel.text = city
            cityLabel.textColor =  UIColor(hexFromString: "205072")
           
        }
        else {
            genderLabel.text  = gender
            genderLabel.textColor = UIColor(hexFromString: "205072")
           
        }
        if fromscansetting == true {
            tabBarController?.tabBar.isHidden = true

        }
        else {
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        containerView.isHidden = true
       // tabBarController?.tabBar.isHidden = true
        if fromscansetting == true {
            tabBarController?.tabBar.isHidden = true

        }
        else {
            tabBarController?.tabBar.isHidden = true
        }
    }
    @IBAction func GenderButtonAction(_ sender: UIButton) {
        picker.isHidden = false
        containerView.isHidden = false
        pickertype = 0
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.reloadAllComponents()
        view.endEditing(true)
        tabBarController?.tabBar.isHidden = true

    }
    
    @IBAction func propicButtonAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                  
                   
                   
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                   //imag.mediaTypes = [kUTTypeImage];
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
               }

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image picker delegate")
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickedImages  = pickedImage
           // pickedImages.append(pickedImage)
//                pickedimage.contentMode = .scaleAspectFill
            proimage.image = pickedImage
            }

            dismiss(animated: true, completion: nil)
        
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addMemberbuttonAction(_ sender: UIButton) {
        validation()
    }

    @IBAction func cityButtonAction(_ sender: UIButton) {
       // tabBarController?.tabBar.isHidden = true
       
        containerView.isHidden = false
        pickertype = 1
        picker.reloadAllComponents()
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.isHidden = false
        view.endEditing(true)
        
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
        if pickertype == 1{
            return cityData[row]
        }else {
            return genderdata[row]
        }
    }

    @objc func cancelAction() {
    self.dobTF.resignFirstResponder()
}
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        picker.isHidden = true
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickertype == 1{
          city = String(cityData[row])
            cityLabel.textColor = UIColor(hexFromString: "205072")
        }
        else {
           gender  = String(genderdata[row])
            genderLabel.textColor = UIColor(hexFromString: "205072")
        }
                            
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
    func validation() {
        
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
        if emiratesTF.text?.isEmpty == true {
            emiratesTF.placeholderColor = UIColor.red
            BannerNotification.failureBanner(message: "Please Fill the highlighted fields")
        }
//        if fileNumberTF.text?.isEmpty == true {
//            fileNumberTF.placeholderColor = UIColor.red
//            BannerNotification.failureBanner(message: "please enter your File Number")
//        }
        if firstNameTF.text?.isEmpty == true {
            firstNameTF.placeholderColor = UIColor.red
            BannerNotification.failureBanner(message: "Please enter your first Name")
        }
        if lastNameTF.text?.isEmpty == true {
            lastNameTF.placeholderColor = UIColor.red
            BannerNotification.failureBanner(message: "Please enter your lastname")
        }
        if  emailIDTF.text?.isValidEmail() == false  {
            emailIDTF.placeholderColor = UIColor.red
            BannerNotification.failureBanner(message: "please enter  valid emailid")
        }
        
        if genderLabel.text == "Select Gender"   {
            genderLabel.textColor = UIColor.red
            BannerNotification.failureBanner(message: "please select your gender")
        }
        if dobTF.text?.isEmpty == true {
            dobTF.placeholderColor = UIColor.red
            BannerNotification.failureBanner(message: "please enter your date of birth")
        }
        if cityLabel.text == "Select City" {
            cityLabel.textColor = UIColor.red
            BannerNotification.failureBanner(message: "please select the city")
            
        }
        if emiratesTF.text?.isEmpty == false && fileNumberTF.text?.isEmpty == false && firstNameTF.text?.isEmpty == false && lastNameTF.text?.isEmpty == false && emailIDTF.text?.isValidEmail() == true && genderLabel.text != "Select Gender" && dobTF.text?.isEmpty == false && cityLabel.text != "Select City"   {
            addmember()
        }
        else {
            BannerNotification.failureBanner(message: "Please Fill the highlighted fields")
        }
    }
        else {
            gender = "حدد نوع الجنس"
            city = "اختر مدينة"
            if emiratesTF.text?.isEmpty == true {
                emiratesTF.placeholderColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء ملء الحقول المميزة")
            }
            if fileNumberTF.text?.isEmpty == true {
                fileNumberTF.placeholderColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء إدخال رقم ملفك")
            }
            if firstNameTF.text?.isEmpty == true {
                firstNameTF.placeholderColor = UIColor.red
                BannerNotification.failureBanner(message: "يرجى ادخال الاسم الاول")
            }
            if lastNameTF.text?.isEmpty == true {
                lastNameTF.placeholderColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء إدخال اسمك الأخير")
            }
            if  emailIDTF.text?.isValidEmail() == false  {
                emailIDTF.placeholderColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء إدخال البريد الإلكتروني الصحيح")
            }
            
            if genderLabel.text == "حدد نوع الجنس"   {
                genderLabel.textColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء تحديد جنسك")
            }
            if dobTF.text?.isEmpty == true {
                dobTF.placeholderColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء ادخال تاريخ ميلادك")
            }
            if cityLabel.text == "اختر مدينة" {
                cityLabel.textColor = UIColor.red
                BannerNotification.failureBanner(message: "الرجاء تحديد المدينة")
                
            }
            if emiratesTF.text?.isEmpty == false  && firstNameTF.text?.isEmpty == false && lastNameTF.text?.isEmpty == false && emailIDTF.text?.isValidEmail() == true && genderLabel.text != "حدد نوع الجنس" && dobTF.text?.isEmpty == false && cityLabel.text != "اختر مدينة"   {
                addmember()
            }
            else {
                BannerNotification.failureBanner(message: "الرجاء ملء الحقول المميزة")
            }
            
        }

}
}
