//
//  DoctorSelectionVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import UIKit
import Kingfisher

class DoctorSelectionVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var drTable: UITableView!
    var drmodel:Drmodel?
    var load:Int?
    var name:String?
    var firstname:String?
    var secondname:String?
    var isfromappointments:Bool?
    var timestring:String?
    var preffereddate:String?
    var isfromreschedule:Bool?
    var bookingid:String?
    
    @IBOutlet weak var backImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

      getdoctor()
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
        }
        
        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if load == 1 {
            return drmodel?.doctors.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrListTVC") as! DrListTVC
        
        if load == 1 {
            cell.drimage.layer.cornerRadius = cell.drimage.frame.size.width/2
            cell.drimage.clipsToBounds = true
            let image = image_baseURL + (drmodel?.doctors[indexPath.row].image.first ?? "")
            cell.drimage.kf.setImage(with: URL(string: image))
         firstname = drmodel?.doctors[indexPath.row].firstName
            secondname = drmodel?.doctors[indexPath.row].lastName
            name = "\(firstname ?? "")" + " \(secondname ?? "")"
            cell.drNameLabel.text = name //drmodel?.doctors[indexPath.row].firstName
                        cell.drRoleLabel.text = drmodel?.doctors[indexPath.row].speciality
            
            
           
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannSelectionVC") as!
        ScannSelectionVC
        name =  "\(drmodel?.doctors[indexPath.row].firstName ?? "")" + " \(drmodel?.doctors[indexPath.row].lastName ?? "" )"
           
        UserDefaults.standard.set(name, forKey: "doctor")
        UserDefaults.standard.set(self.drmodel?.doctors[indexPath.row]._id, forKey: "doctorID")
        UserDefaults.standard.set(self.drmodel?.doctors[indexPath.row].image.first, forKey: "doctorimage") 
        navigationController?.navigationBar.isHidden = true
       
        navigationController?.pushViewController(vc, animated: true)
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class DrListTVC:UITableViewCell {
    @IBOutlet weak var drNameLabel: UILabel!
    @IBOutlet weak var drRoleLabel: UILabel!
    @IBOutlet weak var drimage: UIImageView!
    
}
