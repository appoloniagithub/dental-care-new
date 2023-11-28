//
//  contactUsVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 25/10/2022.
//

import UIKit
import SkyFloatingLabelTextField
import KVSpinnerView
import Alamofire

class contactUsVC:UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var fileurl:URL?
    var fileimage:UIImage?
    var imagePicker = UIImagePickerController()
    var pickedImages: UIImage?
    var pickedar:[UIImage] = []
    var filedata:Data?
    var filedataar:[Data] = []
    var appversion: AnyObject?
    var phoneOSversion:Any?
    var problem:String? = "Select issue"
    var delegate:profiledelegate?
    var fromhome:Bool?
    var email:String?
    var name:String?
    var indexa:Int?
   

    @IBOutlet weak var backimage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var ImageViewCV: UICollectionView!
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var emaILTf: SkyFloatingLabelTextField!
    @IBOutlet weak var messageHeadLabel: UILabel!
    @IBOutlet weak var nameTf: SkyFloatingLabelTextField!
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var donebutton: UIButton!
    var problemData = ["Select Issue","Login issue","Can't remember mobile number"," App issues","Others"]
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        imagePicker.delegate = self
        appversion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject?
        phoneOSversion = UIDevice.current.systemVersion
        problemLabel.text = "Select issue"
        if fromhome == true {
            EmailView.isHidden = true
            nameView.isHidden = true
            
        }
        ImageViewCV.isHidden = true
        
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backimage.image = UIImage(named: "Group 106")
        }else {
            backimage.image = UIImage(named: "right-arrow(1)")
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func imageremoveButtonAction(_ sender: UIButton) {
     
        
    }
    
    func textvalidation() {
        if fromhome == true {
            if problemLabel.text == "Select issue" {
                BannerNotification.failureBanner(message: "Please Select issue")
            }
            if messageText.text.isEmpty == true {
                messageHeadLabel.textColor = UIColor.red
            }
            if  problemLabel.text == "Select issue" {
                problemLabel.textColor = UIColor.red
            }
            if  problemLabel.text != "Select issue" && messageText.text.isEmpty == false  {
                if fromhome == true {
                    name = UserDefaults.standard.string(forKey: "name")
                    email = UserDefaults.standard.string(forKey: "email")
                    contactus()
                    
                }
            }
        }else {
                
                if nameTf.text?.isEmpty ==  true {
                    nameTf.placeholderColor = UIColor.red
                    nameTf.titleColor  = UIColor.red
                    BannerNotification.failureBanner(message: "Please fill all the highlighted field")
                }
                if emaILTf.text?.isValidEmail() == false {
                    emaILTf.placeholderColor = UIColor.red
                    emaILTf.titleColor = UIColor.red
                    BannerNotification.failureBanner(message: "Please fill all the highlighted field")
                    
                    
                }
                if problemLabel.text == "Select issue" {
                    BannerNotification.failureBanner(message: "Please Select issue")
                    problemLabel.textColor = UIColor.red
                }
                if messageText.text.isEmpty == true {
                    messageHeadLabel.textColor = UIColor.red
                }
                if nameTf.text?.isEmpty == false && emaILTf.text?.isValidEmail() == true && problemLabel.text != "Select issue" && messageText.text.isEmpty == false  {
               
                        name = nameTf.text
                        email = emaILTf.text
                        contactus()
                    
                }
            }
            
        }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        pickerContainerView.isHidden = true
        donebutton.isEnabled = false
        cancelButton.isEnabled = false
        tabBarController?.tabBar.isHidden = false
    }
    @IBAction func doneButtonAction(_ sender: UIButton) {
        pickerContainerView.isHidden = true
        donebutton.isEnabled = false
        cancelButton.isEnabled = false
        problemLabel.text = problem
        problemLabel.textColor = UIColor.black
        tabBarController?.tabBar.isHidden = false
    }
    @IBAction func submitButtonAction(_ sender: UIButton) {
      textvalidation()
    }
    @IBAction func backbuttonAction(_ sender: UIButton) {
        delegate?.tabbar()
        navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func attatchFileButtonAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                  
                   
                   
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                   //imag.mediaTypes = [kUTTypeImage];
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
               }
    }
    
    @IBAction func subjectButtonAction(_ sender: UIButton) {
        pickerContainerView.isHidden = false
        donebutton.isEnabled = true
        cancelButton.isEnabled = true
        picker.isHidden = false
        tabBarController?.tabBar.isHidden = true
        view.endEditing(true)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image picker delegate")
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickedImages  = pickedImage
            pickedar.append(pickedImages!)
            ImageViewCV.isHidden = false
            ImageViewCV.reloadData()
           // ImageViewCV.backgroundColor = UIColor.red
           // countLabel.isHidden = false
//            countLabel.text = "No of file Attatched: \(pickedar.count)"
//                pickedimage.contentMode = .scaleAspectFill
//            pickedimage.image = pickedImage
            }

            dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        problemData.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        return problemData[row]
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
           problem = String(problemData[row])
           
        
                            
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return pickedar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagepickedCVC", for: indexPath) as! ImagepickedCVC
        cell.pickedimages.image = pickedar[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width/2.5
        return CGSize(width: width, height: 10
        )
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        ImageViewCV.backgroundColor = UIColor.red
//        pickedar.remove(at: indexPath.row)
//        ImageViewCV.reloadData()
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pickedar.remove(at: indexPath.row)
      
       ImageViewCV.reloadData()
    }
}
extension contactUsVC {
    func contactus() {

        let parameters = [
            "name":name!,
            "contactInfo":email!,
            "subject":problemLabel.text!,
            "message":messageText.text!,
            "appVersion":appversion! as! String,
            "appOsVersion":phoneOSversion! as! String,
            "source":"iphone"

          

        ] as [String : String]

        do {
            if pickedImages != nil {
                for item in pickedar {
                    filedata = try item.jpegData(compressionQuality: 1.0)
                    filedataar.append(filedata!)
                }
            }
          //Data(contentsOf: fileimage!)
            KVSpinnerView.show(saying: "Please Wait")
            Alamofire.upload(multipartFormData: {  multipart in
               
                if self.filedataar != nil {
                    for item in self.filedataar {
                        multipart.append(item, withName: "files", fileName: "file.png", mimeType: "image/png")
                    }
                }
                for (key, value ) in parameters {
                    multipart.append(value.data(using: .utf8)!, withName: key)
                }
                    
                
                
            }, to: URL(string: remote_Base_URL + "api/user/contact")!) { result in
                switch  result {
                    
                case .success(request: let request, streamingFromDisk: let streamingFromDisk, streamFileURL: let streamFileURL):
                 
                   
                    request.uploadProgress { progress in
                       debugPrint(progress)
                    }
                    request.responseJSON { jsonresponse in
                        debugPrint(jsonresponse)
                        BannerNotification.successBanner(message:"We have received your message and will respond within 24-48 Hrs")
                        self.navigationController?.popViewController(animated: true)
                    }
                   
                    KVSpinnerView.dismiss()
                   
                case .failure(let error):
                    print("failure,\(error.localizedDescription)")
                    BannerNotification.failureBanner(message: error.localizedDescription)
                    KVSpinnerView.dismiss()
                }
               
            }
        }
        catch {
          print("error")
        }
    }
     
}


class ImagepickedCVC:UICollectionViewCell {
    @IBOutlet weak var pickedimages: UIImageView!
}

