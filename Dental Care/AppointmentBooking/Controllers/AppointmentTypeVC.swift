//
//  AppointmentTypeVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 30/03/2023.
//

import UIKit
import SkyFloatingLabelTextField
import DropDown

class AppointmentTypeVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate {
    var consultationtype:String = "Face to Face"
    var clinicname:String?
    var servicename:String?
    var appointmentModel:SignupModel!
    let datePickerView:UIDatePicker = UIDatePicker()
    let dropDown = DropDown()
    var drmodel:Drmodel?
    var timear = ["Please select time","9:00 AM","9:30 AM","10:00 AM","10:30 AM","11:00 AM","11:30 AM","12:00 PM","12:30 PM","1:00 PM","1:30 PM","2:00 PM","2:30 PM","3:00 PM","3:30 PM","4:00 PM","4:30 PM","5:00 PM","5:30 PM","6:00 PM","6:30 PM","7:00 PM","7:30 PM","8:00 PM","8:30 PM"]
    var timestring:String = "Please select time"
    var preffereddate:String?
    var isfromreschedule:Bool?
    var bookingid:String?
    @IBOutlet weak var remoteView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var remoteImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var dateTF: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBOutlet weak var remoteLabel: UILabel!
    @IBOutlet weak var f2fView: UIView!
    @IBOutlet weak var F2FLabel: UILabel!
    @IBOutlet weak var F2FImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        datePickerView.datePickerMode = .date
        self.dateTF.datePicker(target: self,
                                  doneAction: #selector(doneAction),
                                  cancelAction: #selector(cancelAction),
                                  datePickerMode: .date)
        
    }
    @IBAction func dateButtonAction(_ sender: UIButton) {
        picker.isHidden = false
        
        containerView.isHidden = false
        submitButton.isHidden = true
        //tabBarController?.tabBar.isHidden = true
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.reloadAllComponents()
      
        view.endEditing(true)

    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    @IBAction func face2faceButtonAction(_ sender: UIButton) {
        f2fView.borderWidth = 1
        F2FImage.tintColor = UIColor.white
        F2FLabel.textColor = UIColor.white
        
        remoteView.borderWidth = 0
        remoteImage.tintColor = UIColor.gray
        remoteLabel.textColor = UIColor.gray
        consultationtype = "Face to Face"
        
    }
    @objc func cancelAction() {
    self.dateTF.resignFirstResponder()
}
    @IBAction func doneButtonAction(_ sender: UIButton) {
        containerView.isHidden = true
        //tabBarController?.tabBar.isHidden = false
        submitButton.isHidden = false
            timeLabel.text =  timestring
           
        
        

    }
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        containerView.isHidden = true
        submitButton.isHidden = false
        //tabBarController?.tabBar.isHidden = false
    }
    @objc func doneAction() {
    if let datePickerView = self.dateTF.inputView as? UIDatePicker {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: datePickerView.date)
        self.dateTF.text = dateString
        preffereddate = dateString
        
        print(datePickerView.date)
        print(dateString)
        
        self.dateTF.resignFirstResponder()
    }
}
    @IBAction func remoteButtonAction(_ sender: UIButton) {
        f2fView.borderWidth = 0
        F2FImage.tintColor = UIColor.gray
        F2FLabel.textColor = UIColor.gray
        remoteView.borderWidth = 1
        remoteImage.tintColor = UIColor.white
        remoteLabel.textColor = UIColor.white
        remoteView.borderColor = UIColor.white
        consultationtype = "Remote"
    }
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if timestring == "Please select time" || dateTF.text?.isEmpty == true {
            BannerNotification.failureBanner(message: "please select preffered date and time")
        }else {
            let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentdrSelectionVC")   as! AppointmentdrSelectionVC
            vc.consultationtype = consultationtype
            vc.clinicname = clinicname
            vc.preffereddate = preffereddate
            vc.timestring = timestring
            vc.servicename = servicename
            vc.isfromreschedule = isfromreschedule
            vc.bookingid = bookingid
            navigationController?.pushViewController(vc, animated: true)
//            if isfromreschedule == true {
//                rescheduleappointment()
//            }else {
//                bookappointment()
//            }
            
            
          
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timear.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return timear[row]
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timestring = String(timear[row])
        
    }
}
