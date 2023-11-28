//
//  AppointmentPopUpVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 30/03/2023.
//

import UIKit

class AppointmentPopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func appointmentButtonAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentAllBookVC")   as! AppointmentAllBookVC
//        vc.scantype = .teethScanwithHelp
//        vc.onlyTeethScan = true
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
  
    @IBAction func homeButtonaction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")  as! CustomTabBarvc//Tabbar  Drtab Home DoctorSB
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
