//
//  ScannSelectionVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 27/10/2022.
//

import UIKit

class ScannSelectionVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var onlyTeethScan:Bool?
    var onlyfacescan:Bool?
    var facescanmodeAlone:Bool?
    var delegate:profiledelegate?
    var pickedImages:UIImage?
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var aloneButton: UIButton!
    @IBOutlet weak var scanModeView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var fourView: UIView!
    @IBOutlet weak var aloneGradientView: GradientBlueView!
    @IBOutlet weak var teethScanGradientView: GradientBlueView!
    @IBOutlet weak var facescanaloneview: GradientBlueView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var bothScanGradientView: GradientBlueView!
    @IBOutlet weak var facescanonlylabel: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var helpGradientView: GradientBlueView!
    @IBOutlet weak var drName: UILabel!
    @IBOutlet weak var patientName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        teethScanGradientView.isHidden = true
        bothScanGradientView.isHidden = false
        scanModeView.isHidden = false
        aloneButton.isEnabled = true
        helpButton.isEnabled = true
        helpGradientView.isHidden = true
        aloneGradientView.isHidden = false
        facescanaloneview.isHidden = true
        facescanmodeAlone = true
        onlyTeethScan = false
        onlyfacescan = false
        patientName.text = "Patient Name: \(UserDefaults.standard.string(forKey: "name") ?? "")"
        drName.text = "Doctor Name: \(UserDefaults.standard.string(forKey: "doctor") ?? "")"
        oneView.layer.cornerRadius = oneView.frame.size.width/2
        oneView.clipsToBounds = true
        twoView.layer.cornerRadius = twoView.frame.size.width/2
        twoView.clipsToBounds = true
        threeView.layer.cornerRadius = threeView.frame.size.width/2
        threeView.clipsToBounds = true
        fourView.layer.cornerRadius = fourView.frame.size.width/2
        fourView
            .clipsToBounds = true
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
            facescanonlylabel.text = "مسح الوجه فقط"
        }
    }
    @IBAction func doctorSelectionButtonAction(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "ScanSB", bundle:      Bundle.main).instantiateViewController(withIdentifier: "DoctorSelectionVC")  as! DoctorSelectionVC
       // vc.isfromselection = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func faceteethScanButtonAction(_ sender: UIButton) {
        teethScanGradientView.isHidden = true
        bothScanGradientView.isHidden = false
        facescanaloneview.isHidden = true
        scanModeView.isHidden = false
        aloneButton.isEnabled = true
        helpButton.isEnabled = true
        onlyTeethScan = false
        onlyfacescan = false
    }
    
    @IBAction func teethScanOnlyButtonAction(_ sender: UIButton) {
        bothScanGradientView.isHidden = true
        teethScanGradientView.isHidden = false
        facescanaloneview.isHidden = true
        scanModeView.isHidden = true
        aloneButton.isEnabled = false
        helpButton.isEnabled = false
        onlyTeethScan = true
        onlyfacescan = false
        
    }
    
    @IBAction func aloneFaceScanButtonAction(_ sender: UIButton) {
        helpGradientView.isHidden = true
        aloneGradientView.isHidden = false
        facescanmodeAlone = true
    }
    @IBAction func ScanWithHelpButtonAction(_ sender: UIButton) {
        helpGradientView.isHidden = false
        aloneGradientView.isHidden = true
        facescanmodeAlone = false

    }
    
    @IBAction func changepatientButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ProfileSB", bundle:      Bundle.main).instantiateViewController(withIdentifier: "FamilyMembersVC")  as! FamilyMembersVC
        vc.isfromselection = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        delegate?.tabbar()
    }
    
    
    @IBAction func faceScanonlyButtonAction(_ sender: UIButton) {
        teethScanGradientView.isHidden = true
        bothScanGradientView.isHidden = true
        facescanaloneview.isHidden = false
        scanModeView.isHidden = false
        aloneButton.isEnabled = true
        helpButton.isEnabled = true
        onlyfacescan = true
        onlyTeethScan = false
    }
    
  
    @IBAction func imagepickerAction(_sender:UIButton){
        print("gausygdijhasbiudikasjdkuhoiajd;ijsiohdsiljdfoihfdsi")
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
    //            pickedimage.image = pickedImage
                }

                dismiss(animated: true, completion: nil)
            
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    @IBAction func submitButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "scanModeVC") as! scanModeVC

        navigationController?.pushViewController(vc, animated: true)
        
        

        
        
        
        
    }
}

