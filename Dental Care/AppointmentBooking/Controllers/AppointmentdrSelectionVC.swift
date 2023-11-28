//
//  AppointmentdrSelectionVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 14/09/2023.
//

import UIKit

class AppointmentdrSelectionVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var drmodel:Drmodel?
    var drID:String?
    var doctorselected:Int?
    var doctorsid:String?
    var firstname:String?
    var secondname:String?
    var name:String?
    var clinicname:String?
    var consultationtype:String?
    var timestring:String?
    var servicename:String?
    var preffereddate:String?
    var isfromreschedule:Bool?
    var appointmentModel:SignupModel!
    var bookingid:String?
    
    @IBOutlet weak var doctortv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     getdoctor()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func submitButtonAction(_ sender: Any) {
        if drID == nil {
            BannerNotification.failureBanner(message: "Please select your preffered doctor")
        }else
                    if isfromreschedule == true {
                        rescheduleappointment()
                    }else {
                        bookappointment()
                    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drmodel?.doctors.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentdoctorTVC") as? appointmentdoctorTVC
        if doctorselected == indexPath.row {
            cell?.drimage.layer.cornerRadius = (cell?.drimage.frame.size.width ?? 0)/2
            cell?.drimage.clipsToBounds = true
            let image = image_baseURL + (drmodel?.doctors[indexPath.row].image.first ?? "")
            cell?.drimage.kf.setImage(with: URL(string: image))
         firstname = drmodel?.doctors[indexPath.row].firstName
            secondname = drmodel?.doctors[indexPath.row].lastName
            name = "\(firstname ?? "")" + " \(secondname ?? "")"
            cell?.drNameLabel.text = name //drmodel?.doctors[indexPath.row].firstName
            cell?.drRoleLabel.text = drmodel?.doctors[indexPath.row].speciality
            cell?.selectionimage.image = UIImage(named: "Ellipse 2-1")
        }else {
            cell?.drimage.layer.cornerRadius = (cell?.drimage.frame.size.width ?? 0)/2
            cell?.drimage.clipsToBounds = true
            let image = image_baseURL + (drmodel?.doctors[indexPath.row].image.first ?? "")
            cell?.drimage.kf.setImage(with: URL(string: image))
         firstname = drmodel?.doctors[indexPath.row].firstName
            secondname = drmodel?.doctors[indexPath.row].lastName
            name = "\(firstname ?? "")" + " \(secondname ?? "")"
            cell?.drNameLabel.text = name //drmodel?.doctors[indexPath.row].firstName
            cell?.drRoleLabel.text = drmodel?.doctors[indexPath.row].speciality
            cell?.selectionimage.image = UIImage(named: "Ellipse 4")
            
        }
       
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        doctorselected = indexPath.row
        drID = drmodel?.doctors[indexPath.row]._id
        doctortv.reloadData()
    }

}
class appointmentdoctorTVC:UITableViewCell {
    @IBOutlet weak var drNameLabel: UILabel!
    @IBOutlet weak var drRoleLabel: UILabel!
    @IBOutlet weak var drimage: UIImageView!
    @IBOutlet weak var selectionimage: UIImageView!
    
}
