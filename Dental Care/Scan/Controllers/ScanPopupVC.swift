//
//  ScanPopupVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 27/01/2023.
//

import UIKit

class ScanPopupVC: UIViewController {
    var conversationid:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")  as! CustomTabBarvc//Tabbar  Drtab Home DoctorSB
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    

    @IBAction func chatbuttonAction(_ sender: UIButton) {
//        let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")  as! CustomTabBarvc//Tabbar  Drtab Home DoctorSB
//        vc.selectedIndex = 1
//        tabBarController?.tabBar.isHidden = true
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.pushViewController(vc, animated: false)
        
        let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "ChatViewController")  as! ChatViewController//Tabbar  Drtab Home DoctorSB
        tabBarController?.tabBar.isHidden = true
        vc.conversationid = conversationid
        vc.senderid =  UserDefaults.standard.string(forKey: "doctorID")!
        vc.iffromscans = true

        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
