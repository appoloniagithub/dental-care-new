//
//  ReviewPopUpVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 28/10/2022.
//

import UIKit
import Kingfisher

class ReviewPopUpVC: UIViewController {
    @IBOutlet weak var backImage: UIImageView!
    var screenshot:UIImage?
    @IBOutlet weak var backGroundimage: UIImageView!
    @IBOutlet weak var propic: UIImageView!
    @IBOutlet weak var roundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        roundView.layer.cornerRadius = roundView.frame.size.width/2
        roundView.clipsToBounds = true
        
        propic.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage") ?? ""))
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
            
        }
       
    }
    
    @IBAction func backbuttonAction(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")  as! CustomTabBarvc//Tabbar  Drtab Home DoctorSB
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
        
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
