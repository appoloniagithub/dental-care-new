//
//  RetakeViewImageVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 10/03/2023.
//

import UIKit

class RetakeViewImageVC: UIViewController {
    var image:UIImage?
    var teethscanmanual:Bool?
    var teethscan:Bool?
    var facescan:Bool?
    var facescanManual:Bool?
    var index:Int?
    var teethimage:[UIImage] = []
    var teeth64image:[String] = []
    var facescanimage:[UIImage] = []
    var facescan64:[String] = []
    var onlyteethscan:Bool?
    var onlyfacescan:Bool?
    @IBOutlet weak var retakeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retakeImage.image = image
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func retakeButtonAction(_ sender: UIButton) {
        if teethscan == true {
            let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeethScanVC") as! TeethScanVC
            vc.fromretake = true
            vc.imageNumber = index
            vc.teethscanauto = true
            vc.scantype = .teethScan
            vc.teethimage = teethimage
            vc.teethscan64 = teeth64image
            vc.onlyTeethScan = onlyteethscan
            vc.facescan64 = facescan64
            vc.scanimgarr = facescanimage
            navigationController?.pushViewController(vc, animated: true)
        }else if teethscanmanual == true {
            let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeethScanVC") as! TeethScanVC
            vc.fromretake = true
            vc.imageNumber = index
            vc.teethscanauto = false
            vc.scantype = .teethScan
            vc.teethimage = teethimage
            vc.teethscan64 = teeth64image
            vc.facescan64 = facescan64
            vc.scanimgarr = facescanimage
            vc.onlyTeethScan = onlyteethscan
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
