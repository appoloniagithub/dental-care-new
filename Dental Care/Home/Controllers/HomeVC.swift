//
//  HomeVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 25/10/2022.
//

import UIKit
import Kingfisher
import KVSpinnerView
import Instructions
import FirebaseMessaging


class HomeVC: UIViewController,profiledelegate,CoachMarksControllerDataSource, CoachMarksControllerDelegate{
  
    @IBOutlet weak var scanDueView: UIView!
    @IBOutlet weak var notificationButton: UIButton!
    
    
    
    
    
    @IBOutlet weak var scanDueButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var scanProImage: UIImageView!
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var profileimageview: UIImageView!
    var profilegetmodel:profilemodel?
    var name:String?
    let coachMarksController = CoachMarksController()
    let indexpath:IndexPath? = nil

  

    override func viewDidLoad() {
        super.viewDidLoad()
//    self.coachMarksController.dataSource = self
//    self.coachMarksController.delegate = self
       
            

        
        
        roundView.layer.cornerRadius = roundView.frame.size.width/2
        roundView.clipsToBounds = true
        notificationView.layer.cornerRadius = notificationView.frame.size.width/2
        notificationView.clipsToBounds = true
        scanProImage.layer.cornerRadius = scanProImage.frame.size.width/2
        scanProImage.clipsToBounds = true
        profileimageview.layer.cornerRadius = profileimageview.frame.size.width/2
        profileimageview.clipsToBounds = true
        greetingsLabel.text = "\(getGreeting())"
        nameLabel.text = "\(UserDefaults.standard.string(forKey: "name") ?? "")"
        profileimageview.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage") ?? ""))
        scanProImage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage") ?? ""))
            editprofileget()
   // RefreshTocken.shared.refreshtokenapi()

        let skipView =  CoachMarkSkipDefaultView()
        skipView.setTitle("Skip", for: .normal)
        self.coachMarksController.skipView = skipView
        
    }
    override func viewWillAppear(_ animated: Bool) {
        editprofileget()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.coachMarksController.start(in: .viewController(self))
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.coachMarksController.stop(immediately: true)
        
    }
    func tabbar() {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannSelectionVC") as! ScannSelectionVC
        //vc.delegate = self
     //   vc.scantype = .teethScan
        vc.delegate = self
        tabBarController?.tabBar.isHidden = true
          navigationController?.navigationBar.isHidden = true
          navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func appointmentButtonAction(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentAllBookVC")   as! AppointmentAllBookVC
        vc.delegate = self

        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
        
        
        
        
        
        
//        let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppontmentDeptSelectionVC")   as! AppontmentDeptSelectionVC
//        vc.delegate = self
////        vc.scantype = .teethScanwithHelp
////        vc.onlyTeethScan = true
//        tabBarController?.tabBar.isHidden = true
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.pushViewController(vc, animated: true)
//        let vc = UIStoryboard.init(name: "CustomStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "videocontrolllerVC")   as! videocontrolllerVC
//  //  vc.delegate = self
////        vc.scantype = .teethScanwithHelp
////        vc.onlyTeethScan = true
//        tabBarController?.tabBar.isHidden = true
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.pushViewController(vc, animated: true)
//        
    }
    
    @IBAction func notificationButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
            vc.delegate = self
          navigationController?.navigationBar.isHidden = true
          tabBarController?.tabBar.isHidden = true
          navigationController?.pushViewController(vc, animated: false)

    }
    @IBAction func scanselectionButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannSelectionVC") as! ScannSelectionVC
          vc.delegate = self
          navigationController?.navigationBar.isHidden = true
          tabBarController?.tabBar.isHidden = true
          navigationController?.pushViewController(vc, animated: false)

    }
    func numberOfCoachMarks(for coachMarksController: Instructions.CoachMarksController) -> Int {
        return 2
    }
    func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkAt index: Int) -> Instructions.CoachMark {
        switch index {
        case 0: return coachMarksController.helper.makeCoachMark(for: notificationButton)
        case 1:  return coachMarksController.helper.makeCoachMark(for: scanDueButton)
            
            
            
            
        default:
            return coachMarksController.helper.makeCoachMark()
        }
    }
    func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: Instructions.CoachMark) -> (bodyView: (UIView & Instructions.CoachMarkBodyView), arrowView: (UIView & Instructions.CoachMarkArrowView)?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachViews.bodyView.hintLabel.text = "Hello! this is a segmented control you can toggle dark and light mode here!"
            coachViews.bodyView.nextLabel.text = "OK!!"
            
        case 1 :
            coachViews.bodyView.hintLabel.text = "Hello! this is a segmented control you can toggle dark and light mode here!"
            coachViews.bodyView.nextLabel.text = "OK!!"
           // coachViews.bodyView.previousLabel.text = "Previous!"
           // coachViews.bodyView.hintLabel.text = "afusygdagsiduq"
        default:
            break
        }
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }

}
extension HomeVC  {
    func editprofileget() {
       
            let parameters = [
        
                "userId" : UserDefaults.standard.string(forKey: "userid")!
            ] as [String : Any]
        let header = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)",
                    "lang":"en"]
        
       // KVSpinnerView.show(saying: "Please Wait")
            NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/profileget", methodeType: .post,parameter: parameters,headerType:header ) { (status, response) in
                print(response)
                switch status {
                case .noNetwork:
                    print("network error")
                    BannerNotification.failureBanner(message: "No network Connection")
                    
                case .success :
                    //KVSpinnerView.dismiss()
                    print("success")
                    //      print(response["data"]!)
                    if let data = response["data"] as? Json{
                      //
                        if response["authError"] as? String  == "1" {
                            RefreshTocken.shared.refreshtokenapi()
                            BannerNotification.failureBanner(message: "You Must Login First")
                           UserDefaults.standard.set("", forKey: "fileID")
                           UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                           UserDefaults.standard.set("", forKey: "userid")
                           let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "LoginVC")   as! LoginVC
                           self.navigationController?.navigationBar.isHidden = true
                           self.navigationController?.tabBarController?.tabBar.isHidden = true
                           self.navigationController?.pushViewController(vc, animated: false)
                          
                            
                        }else {
                            self.profilegetmodel = profilemodel(fromData: data)
                            self.name = "\(self.profilegetmodel?.userData.firstName ?? "")" + " \(self.profilegetmodel?.userData.lastName ?? "")"
                            UserDefaults.standard.set( self.name, forKey: "name")
                          //  let proimage = image_baseURL + (self.profilegetmodel?.userData.image.first)!
                            let proimage = image_baseURL + (self.profilegetmodel?.userData.image.first ?? "")
                            UserDefaults.standard.set(proimage, forKey: "proimage")
//                            self.greetingsLabel.text =  "Hello \( UserDefaults.standard.string(forKey: "name") ?? "")"
                            self.nameLabel.text = "\(UserDefaults.standard.string(forKey: "name") ?? "")"
                            self.profileimageview.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage") ?? ""))
                            if self.profilegetmodel?.scans.isEmpty == true {
                                self.scanDueButton.isHidden = true
                                self.scanDueView.isHidden = true
                            }else if self.profilegetmodel?.scans[self.indexpath?.row ?? 0].scanDue == "0" {
                                self.scanDueButton.isHidden = true
                                self.scanDueView.isHidden = true
                            }else if self.profilegetmodel?.scans[self.indexpath?.row ?? 0].scanDue == "1" {
                                self.scanDueButton.isHidden = false
                                self.scanDueView.isHidden = false
                            }
                            
                        
                            self.scanProImage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "proimage") ?? ""))
                            if self.profilegetmodel?.notificationCount == 0 {
                                self.notificationLabel.isHidden = true
                                self.notificationView.isHidden = true
                            }else {
                                self.notificationLabel.isHidden = false
                                self.notificationView.isHidden = false
                                self.notificationLabel.text = "\(self.profilegetmodel?.notificationCount ?? 0)"
                            }
                            
                       
                       
                    //self.initialviewload()4
                    }
                    }
                    
                case .failure :
                    print("failure")
                    
                   // KVSpinnerView.dismiss()
                    BannerNotification.failureBanner(message: "\(response["message"]!)")
                case .unknown:
                    print("unknown")
                   // KVSpinnerView.dismiss()
                    if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")
                    }else {
                        BannerNotification.failureBanner(message: "Oops! something went wrong")

                        
                    }
                }
                
            }    }
}

