//
//  AppontmentDeptSelectionVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 29/03/2023.
//

import UIKit

class AppontmentDeptSelectionVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var appointmentTable: UITableView!
    var delegate:profiledelegate?
    var appointmentgetmodel:Appointmentmodel?
    var isfromreschedule:Bool?
    var bookingid:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getbookingdata()
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        delegate?.tabbar()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentgetmodel?.services.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentDeptTVC") as! appointmentDeptTVC
        cell.serviceLabel.text = appointmentgetmodel?.services[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentQueryVC")   as! AppointmentQueryVC
        if isfromreschedule == true {
            vc.isfromreschedule = true
            vc.bookingid = bookingid
          
            
        }

        vc.servicetype = appointmentgetmodel?.services[indexPath.row] ?? ""
        vc.clinicname = appointmentgetmodel!.clinic
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
class appointmentDeptTVC:UITableViewCell {
    @IBOutlet weak var serviceLabel: UILabel!
    
}
