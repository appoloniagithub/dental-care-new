//
//  FamilyMembersVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 28/10/2022.
//

import UIKit
import Kingfisher

class FamilyMembersVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var isfromselection:Bool?
    var isfromappointment:Bool?
    var familymodels:familymodel?
    var dummyFileNumberAR  = ["1010101","112233","114455","22334455"]
    var name:String?
     var delegate:profiledelegate?
    @IBOutlet weak var memberTV: UITableView!
    @IBOutlet weak var backImage: UIImageView!
    var familyar = [familymembermodel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getfamilymember()
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
        }
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ProfileSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddMemberVC") as! AddMemberVC
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        delegate?.tabbar()
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familymodels?.foundFamily.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "familyMemberTVC") as! familyMemberTVC
//        if familymodels?.foundFamily[indexPath.row].fileNumber == "" {
//            cell.FileNumberlabel.text = "file Number:\(familymodels?.foundFamily[indexPath.row].fileNumber ?? "")"
//        }else {
        cell.FileNumberlabel.text = "File number:\(familymodels?.foundFamily[indexPath.row].fileNumber ?? "")"
       // }
       // cell.proimage.kf.setImage(with: URL(string: familymodels?.foundFamily[indexPath.row].image ?? ""))
        
        cell.proimage.layer.cornerRadius = cell.proimage.frame.size.width/2
        cell.proimage.kf.setImage(with:  URL(string:familymodels?.foundFamily[indexPath.row].image.first ?? ""))
      
      
        name = "\(familymodels?.foundFamily[indexPath.row].firstName ?? "")" + " \(familymodels?.foundFamily[indexPath.row].lastName ?? "")"
        cell.Membername.text = name

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isfromselection == true {
            let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannSelectionVC") as! ScannSelectionVC
         
            UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].userId, forKey: "userid")
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].image, forKey: "proimage")
            UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].assignedDoctorName, forKey: "doctor")
            navigationController?.navigationBar.isHidden = true
            tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(vc, animated: true)
        } else if isfromappointment == true {
            let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppontmentDeptSelectionVC")   as! AppontmentDeptSelectionVC
          
    //        vc.scantype = .teethScanwithHelp
    //        vc.onlyTeethScan = true
            
            UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].userId, forKey: "userid")
            UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].firstName, forKey: "name")
            UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].image, forKey: "proimage")
            UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].email, forKey: "email")
            UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].assignedDoctorName, forKey: "doctor")
            tabBarController?.tabBar.isHidden = true
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(vc, animated: true)
        }else  {
        let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc") as! CustomTabBarvc
        UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].userId, forKey: "userid")
        UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].firstName, forKey: "name")
        UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].image, forKey: "proimage")
        UserDefaults.standard.set(self.familymodels?.foundFamily[indexPath.row].assignedDoctorName, forKey: "doctor")

       // UserDefaults.standard.set(self.loginmodel?.countryCode, forKey: "countryCode")

            tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    }

}
class familyMemberTVC:UITableViewCell {
    @IBOutlet weak var Membername: UILabel!
    @IBOutlet weak var FileNumberlabel: UILabel!
    @IBOutlet weak var proimage:UIImageView!
}
