//
//  LogoutVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import UIKit

class LogoutVC: UIViewController {
    var isfromdelete:Bool?
    var isfromlogout:Bool?
    @IBOutlet weak var backgoundimage: UIImageView!
    var screenshot:UIImage?
    var delegate:profiledelegate?
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var proImage: UIImageView!
    @IBOutlet weak var roundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backgoundimage.image = screenshot
        roundView.layer.cornerRadius = roundView.frame.size.width/2
        roundView.clipsToBounds = true
        proImage.layer.cornerRadius = proImage.frame.size.width/2
        proImage.clipsToBounds = true
        proImage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage") ?? ""))
        if isfromdelete == true {
            titleText.text = "Are you sure?"
            messageLabel.text = "All your personal details, scans & chats will be deleted if you continue & your account will be disabled. Do you want to continue?"
        }
        else {
            messageLabel.isHidden = true
        }

    }
    

    @IBAction func yesButtonAction(_ sender: UIButton) {
        if isfromdelete == true {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
            vc.fromdelete = true
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if isfromlogout == true{
        logout()
    }
    
    }
    @IBAction func noButtonAction(_ sender: Any) {
        delegate?.tabbar()
        navigationController?.popViewController(animated: true)
    }
}
