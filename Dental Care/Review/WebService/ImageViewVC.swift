//
//  ImageViewVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 28/10/2022.
//

import UIKit
import Kingfisher

class ImageViewVC: UIViewController {
    @IBOutlet weak var backImage: UIImageView!
    var scan64:String?
    var scanimage:UIImage?
    var isbase64:Bool?
    var isfromreview:Bool?
    @IBOutlet weak var backgroundImage: UIImageView!
    var screenshot:UIImage?
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //  backgroundImage.image = screenshot
        if isfromreview == true {
            image.image = scanimage
            image.transform = image.transform.rotated(by: .pi/2)
            
        }else {
            if isbase64 == true {
                image.image = convertBase64ToImage(imageString: scan64 ?? "")
            }
            else {
                image.kf.setImage(with: URL(string:image_baseURL + scan64!))
            }
        }
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
           
        }
        
    }
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    

}
