//
//  AppointmentBookingDetailVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 10/04/2023.
//

import UIKit

class AppointmentBookingDetailVC: UIViewController {
    var bookingId:String?
    var detailModel:appointmentbookingModel?
    var bookingdetailmodel:AppointmentdetailModel?
    var indexpath:IndexPath?
    var appointmentstatus:String?
    var delegate:appointmentdelegate?
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientEmailLabel: UILabel!
    @IBOutlet weak var patientPhoneNumberLabel: UILabel!
    @IBOutlet weak var clinicNameLabel: UILabel!
    @IBOutlet weak var consultationtypeLabel: UILabel!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var scheduleStackView: UIStackView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doctorView: UIView!
    
    @IBOutlet weak var rescheduleButton: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getappointmentdetail()
        if appointmentstatus == "Confirmed"{
            rescheduleButton.isHidden = false
            cancelButton.isHidden = false
            scheduleStackView.isHidden = false
        }
       
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        delegate?.reloadtable()
        navigationController?.popViewController(animated: false)
        delegate?.reloadtable()
    }
    @IBAction func rescheduleButtonAction(_ sender: UIButton){
        reschedulealert()
    }
  
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        cancelalert()
    }
    private func reschedulealert() {
        let alertController = UIAlertController(title: "Reschedule", message: "Do you wish to reschedule your Appointment?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.rescheduleappointment()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    private func cancelalert() {
        let alertController = UIAlertController(title: "Delete", message: "Do you wish to cancel your appointment", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.deleteappointment()
        }

        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }


}
