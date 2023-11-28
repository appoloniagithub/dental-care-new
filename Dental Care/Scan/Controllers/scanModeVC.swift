//
//  scanModeVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 12/01/2023.
//

import UIKit

class scanModeVC: UIViewController {
    var  onlyTeethScan:Bool?
    var onlyfacescan:Bool?
    var facescanmodeAlone:Bool?
    var manualmode:Bool? = false

    @IBOutlet weak var scanModeView: UIView!
   
    @IBOutlet weak var faceandteethscangradientView: GradientBlueView!

    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var aloneButton: UIButton!
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var faceonlyButton: UIButton!
    @IBOutlet weak var bothbutton: UIButton!
    
    @IBOutlet weak var teethonlybutton: UIButton!
    
    @IBOutlet weak var facescangradientView: GradientBlueView!
    @IBOutlet weak var teethscangradientView: GradientBlueView!
    @IBOutlet weak var alonegradientView: GradientBlueView!
    @IBOutlet weak var helpscangradientView: GradientBlueView!
    override func viewDidLoad() {
        super.viewDidLoad()
viewinitiaload()        // Do any additional setup after loading the view.
    }
    func viewinitiaload() {
        
        
       
        
        
        
       
        
        teethscangradientView.isHidden = true
        faceandteethscangradientView.isHidden = true
        facescangradientView.isHidden = false
        scanModeView.isHidden = false
        aloneButton.isEnabled = true
        helpButton.isEnabled = true
        onlyfacescan = true
        onlyTeethScan = false
        helpscangradientView.isHidden = true
        facescanmodeAlone = true
    }
    @IBAction func faceteethscanButtonAction(_ sender: UIButton) {
        teethscangradientView.isHidden = true
        faceandteethscangradientView.isHidden = false
        facescangradientView.isHidden = true
        scanModeView.isHidden = false
        aloneButton.isEnabled = true
        helpButton.isEnabled = true
        onlyTeethScan = false
        onlyfacescan = false
    }
    
    @IBAction func facescanButtonAction(_ sender: UIButton) {
        teethscangradientView.isHidden = true
        faceandteethscangradientView.isHidden = true
        facescangradientView.isHidden = false
        scanModeView.isHidden = false
        aloneButton.isEnabled = true
        helpButton.isEnabled = true
        onlyfacescan = true
        onlyTeethScan = false
    }
    
    @IBAction func teethscanButtonAction(_ sender: UIButton) {
        faceandteethscangradientView.isHidden = true
        teethscangradientView.isHidden = false
        facescangradientView.isHidden = true
      //  scanModeView.isHidden = true
      //  aloneButton.isEnabled = false
      //  helpButton.isEnabled = false
        onlyTeethScan = true
        onlyfacescan = false
    }
    
    @IBAction func withHelpButttonAction(_ sender: UIButton) {
        helpscangradientView.isHidden = false
        alonegradientView.isHidden = true
        facescanmodeAlone = false
        manualmode = true
    }
    @IBAction func aloneButtonAction(_ sender: UIButton) {
        helpscangradientView.isHidden = true
        alonegradientView.isHidden = false
        facescanmodeAlone = true
        manualmode = false
    }
    
    @IBAction func backButtonaction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startButtomAction(_ sender: UIButton) {
        if onlyTeethScan == true{
            let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeethScanVC") as! TeethScanVC
            vc.onlyTeethScan = true
            if manualmode == true {
                vc.scantype = .teethScanwithHelp
            }else {
                vc.scantype = .teethScan
            }
            navigationController?.pushViewController(vc, animated: true)
          
            
            
            
        }
        
        else{
            let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanVC") as! ScanVC
            
            
            
            if onlyfacescan == true {
                vc.onlyfacescan = true
                if facescanmodeAlone == true {
                    vc.scantype = .faceScanAlone
                    vc.isfacescanalone = true
                    
                }
                else {
                    vc.scantype = .faceScanHelp
                    
                    
                    
                    
                }
            } else {
                if facescanmodeAlone == true {
                    vc.scantype = .faceScanAlone
                    vc.isfacescanalone = true
                    vc.manualmode = manualmode
                    
                }
                else {
                    vc.scantype = .faceScanHelp
                    vc.manualmode = manualmode
                    
                    
                    
                    
                }
            }
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
