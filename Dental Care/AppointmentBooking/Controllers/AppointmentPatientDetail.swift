//
//  AppointmentPatientDetail.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 25/04/2023.
//

import UIKit

class AppointmentPatientDetail: UIViewController {
    var servicetype:String = ""
    var clinic:String = ""
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
    @IBAction func changeButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ProfileSB", bundle:      Bundle.main).instantiateViewController(withIdentifier: "FamilyMembersVC")  as! FamilyMembersVC
        vc.isfromappointment = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func nextstepButtonAction(_ sender: UIButton) {
       
            let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentTypeVC")   as! AppointmentTypeVC
            vc.clinicname = clinic
            vc.servicename  = servicetype
           
            navigationController?.pushViewController(vc, animated: true)
        
    }
  

}
