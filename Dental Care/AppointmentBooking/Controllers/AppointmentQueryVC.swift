//
//  AppointmentQueryVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 29/03/2023.
//

import UIKit

class AppointmentQueryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var servicetype:String = ""
    var clinicname:[clinicmodel] = []
    var clinicclicked:Int?
    var clinic:String = ""
    var servicename:String?
    var isfromreschedule:Bool?
    var bookingid:String?
   
    @IBOutlet weak var clinicTV: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emiratesIdLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = UserDefaults.standard.string(forKey: "name")
       
        phoneNoLabel.text =  UserDefaults.standard.string(forKey: "phoneNumber")
        emailLabel.text = UserDefaults.standard.string(forKey: "email")
        emiratesIdLabel.text = UserDefaults.standard.string(forKey: "emiratesId")
       
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ProfileSB", bundle:      Bundle.main).instantiateViewController(withIdentifier: "FamilyMembersVC")  as! FamilyMembersVC
        vc.isfromappointment = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextstepButtonAction(_ sender: UIButton) {
        if clinic == "" {
            BannerNotification.failureBanner(message: "please select clinic")
        }else {
            let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentTypeVC")   as! AppointmentTypeVC
            vc.clinicname = clinic
            vc.servicename  = servicetype
            if isfromreschedule == true{
                vc.isfromreschedule = true
                vc.bookingid = bookingid
            }
           
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clinicname.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentqueryTVC") as! appointmentqueryTVC
        cell.clinicLAbel.text = clinicname[indexPath.row].city
        cell.clinicAdressLabel.text = clinicname[indexPath.row].address
        if clinicclicked == indexPath.row {
            cell.radioimage.image = UIImage(named: "radio")
        }else {
            cell.radioimage.image = UIImage(named: "radio-button")
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clinicclicked = indexPath.row
        clinicTV.reloadData()
        clinic = clinicname[indexPath.row].city ?? ""
    }
    

    

}
class appointmentqueryTVC:UITableViewCell {
    @IBOutlet weak var clinicLAbel: UILabel!
    @IBOutlet weak var radioimage: UIImageView!
    @IBOutlet weak var clinicAdressLabel: UILabel!
}
