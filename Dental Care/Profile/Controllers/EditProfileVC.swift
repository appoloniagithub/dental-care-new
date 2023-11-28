//
//  EditProfileVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import UIKit
import SkyFloatingLabelTextField
import Kingfisher

class EditProfileVC: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    var pickertype = 1
    let datePickerView:UIDatePicker = UIDatePicker()
    var genderdata = ["Select Gender","Male","Female","Prefer not to Say"]
    var cityData = ["Select City","Abu Dhabi", "Dubai", "Sharjah", "Ajman", "Umm Al Quwain", "Ras Al Khaimah", "Fujairah"]
    var genderardata = ["حدد نوع الجنس","ذكر","أنثى","افضل عدم القول"]
    var cituDataar = ["اختر مدينة","أبو ظبي","دبي","الشارقة","عجمان","أم القيوين","رأس الخيمة","الفجيرة"]

    var profilegetmodel:profilemodel?
    var edited = false
    var gender:String?
    var city:String?
    var pickedImages: UIImage?
    var imagePicker = UIImagePickerController()
    var delegate:profiledelegate?
    var filedata:Data?
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var genderButton: UIButton!
   
    @IBOutlet weak var editicon: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var editButtonLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dobTF: SkyFloatingLabelTextField!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailidTF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var firstNameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var emiratesIDTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var backImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       editprofileget()
        
        imagePicker.delegate = self
        picker.delegate = self
        picker.dataSource = self
        datePickerView.datePickerMode = .date
        self.dobTF.datePicker(target: self,
                                  doneAction: #selector(doneAction),
                                  cancelAction: #selector(cancelAction),
                                  datePickerMode: .date)
        roundView.layer.cornerRadius = roundView.frame.size.width/2
        roundView.clipsToBounds = true
        editButtonLabel.text = "Submit"
       
    }
    
    @IBAction func GenderButtonAction(_ sender: UIButton) {
        picker.isHidden = false
        pickertype = 0
        containerView.isHidden = false
        //tabBarController?.tabBar.isHidden = true
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.reloadAllComponents()
      
        view.endEditing(true)

    }
    @IBAction func cityButtonAction(_ sender: UIButton) {
        picker.isHidden = false
        containerView.isHidden = false
        pickertype = 1
        //tabBarController?.tabBar.isHidden = true
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.reloadAllComponents()
        view.endEditing(true)
    }
    func initialviewload() {
        firstNameTF.text = profilegetmodel?.userData.firstName
        lastNameTF.text =  profilegetmodel?.userData.lastName
        emailidTF.text = profilegetmodel?.userData.email
        imagePicked.kf.setImage(with: URL(string:image_baseURL + (profilegetmodel?.userData.image.first ?? "") ?? ""))
        editButton.isEnabled = true
        editicon.isHidden = false
       
        emiratesIDTF.text = profilegetmodel?.userData.emiratesId
        cityLabel.text = profilegetmodel?.userData.city
        genderLabel.text = profilegetmodel?.userData.gender
        dobTF.text = profilegetmodel?.userData.dob
       // maskView.isHidden = true
     genderButton.isEnabled = true
       cityButton.isEnabled = true
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
            emiratesIDTF.placeholder = "أدخل هوية الإمارات الخاصة بك"
            emiratesIDTF.selectedTitle = "هويه الإمارات"
            emiratesIDTF.title = "هويه الإمارات"
            firstNameTF.placeholder = "أدخل اسمك الأول"
            firstNameTF.title = "الاسم الاول"
            firstNameTF.selectedTitle = "الاسم الاول"
            lastNameTF.placeholder = "أدخل اسمك الأخير"
            lastNameTF.selectedTitle = "اسم العائلة"
            lastNameTF.title = "اسم العائلة"
            dobTF.placeholder = "أدخل تاريخ ميلادك"
            dobTF.title = "تاريخ الولادة"
            dobTF.selectedTitle = "تاريخ الولادة"
            
            
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
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        delegate?.tabbar()
    }
    
   
    
    @IBAction func imagePickerAction(_ sender: UIButton) {
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
            imagePicked.image = pickedImage
            imagePicked.contentMode = .scaleAspectFill
           // pickedImages.append(pickedImage)
//                pickedimage.contentMode = .scaleAspectFill
//            pickedimage.image = pickedImage
            }

            dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        containerView.isHidden = true
        //tabBarController?.tabBar.isHidden = false
        if pickertype == 1{
            cityLabel.text = city
           
        }
        else {
            genderLabel.text  = gender
           
        }

    }
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        containerView.isHidden = true
        //tabBarController?.tabBar.isHidden = false
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            if pickertype == 1{
                return  cityData.count
            }
            else {
                return  genderdata.count
            }
        }else {
            if pickertype == 1{
                return  cituDataar.count
            }
            else {
                return  genderardata.count
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickertype == 1{
            return cityData[row]
        }else {
            return genderdata[row]
        }
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        //if edited == false {
            //editingenabled()
           
            
      //  }
      //  else {
            textValidation()
            
     //   }
        
    }
    func editingenabled() {
        BannerNotification.successBanner(message: "Edit only necessary fields")
        lastNameTF.isEnabled = true
        firstNameTF.isEnabled = true
        emailidTF.isEnabled = true
        emiratesIDTF.isEnabled = true
        genderButton.isEnabled = true
        cityButton.isEnabled = true
//        maskView.isHidden = true
        editButton.isEnabled = true
        editicon.isHidden = false
        edited = true
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            BannerNotification.successBanner(message: "Edit only necessary fields")
        }else {
            BannerNotification.successBanner(message: "تحرير الحقول الضرورية فقط")
        }
    }
        
    func textValidation() {
       
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            if emiratesIDTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "please enter your emirates id")
            }
            else if  firstNameTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "please enter firstname")
            }
            else if lastNameTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "please enter your lastname")
                
            }
            else if emailidTF.text?.isValidEmail() == false {
                BannerNotification.failureBanner(message: "please enter valid Email-ID")
            }
            
            
            else {
                if pickedImages == nil {
                    editprofilepost()
                }
                else {
                    editprofileimage()
                }
                
            }
        }else {
            if emiratesIDTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "الرجاء إدخال هوية الإمارات الخاصة بك")
            }
            else if  firstNameTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "الرجاء إدخال الاسم الأول")
            }
            else if lastNameTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "الرجاء إدخال اسمك الأخير")
                
            }
            else if emailidTF.text?.isValidEmail() == false {
                BannerNotification.failureBanner(message: "الرجاء إدخال البريد الإلكتروني الصحيح")
            }
            
            
            else {
                if pickedImages == nil {
                    editprofilepost()
                }
                else {
                    editprofileimage()
                }
                
            }
        }
    }

    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        picker.isHidden = true
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if  DCLanguageManager.sharedInstance.getLanguage() == "en" {
            if pickertype == 1{
                city = String(cityData[row])
                
            }
            else {
                gender  = String(genderdata[row])
                
            }
            
        }else {
            if pickertype == 1{
                city = String(cituDataar[row])
                
            }
            else {
                gender  = String(genderardata[row])
                
            }
            
        }
    }
   

}
