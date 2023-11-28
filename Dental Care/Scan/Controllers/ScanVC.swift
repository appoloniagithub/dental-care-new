//
//  ScanVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 26/10/2022.
//

import UIKit
import ARKit
import AVKit

class ScanVC: UIViewController,FinalReviewdelegate {
    func viewscanback() {
        comebackfunc()
    }
    
    var faceTimer = Timer()
    var scantimer = Timer()
    var faceMasktimer = Timer()
    var faceMaskTimerCount = 5
    var facetimer = 0
    var scantimercount = 0
    var progresss:Float = 0.0
    var scantype:scanType?
    var manualmode:Bool?
    var facescanAlone:Bool?
    var teethtimer = Timer()
    var teethclicktimer = Timer()
    var teethtimercount = 0
    var startscaning:Bool? = false
    var teethclicktimercount = 0
    var facescan64:[String] = []
    var teethscan64:[String] = []
    var teethScanArray:[UIImage] = []
    var faceimgarr:[UIImage] = []
    var isteethreload:Bool = false
    var facescanhelptimer = Timer()
    var facescanhelptimercount = 0
    var onlyTeethScan:Bool?
    var isfromreview = false
    var scananimation = false
    var doubleline:Bool?
    var  fromreload:Bool?
    var teethimage:String?
    var onlyfacescan:Bool?
    var isfacescanalone:Bool?
    
    var iscompletedback:Bool?
    var dummyimagEAR:[UIImage] = [UIImage(named: "images")!,UIImage(named: "images")!,UIImage(named: "images")!]
    var dummyfacear:[UIImage] = [UIImage(named: "images")!,UIImage(named: "images")!,UIImage(named: "images")!,UIImage(named: "images")!,UIImage(named: "images")!]
    var avpController = AVPlayerViewController()
    @IBOutlet weak var teethScanindicationLabel: UILabel!
    @IBOutlet weak var logoView: UIView!
   
    @IBOutlet weak var faceindicationLabel: UILabel!
    @IBOutlet weak var scanViewButtton: UIButton!
    @IBOutlet weak var ScanerView: UIView!
    @IBOutlet weak var scanControlLabel: UILabel!
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var retakeview: UIView!
    @IBOutlet weak var viewScanview: UIView!
    @IBOutlet weak var teethscanindicationimage: UIImageView!
    @IBOutlet weak var teethscanindicationView: UIView!
    @IBOutlet weak var faceScanIndicationimg: UIImageView!
    @IBOutlet weak var facescanindicationview: UIView!
    @IBOutlet weak var scanInfoLabel: UILabel!
    @IBOutlet weak var distanceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var distanceInstructionLabel: UILabel!
    @IBOutlet weak var distanceInstructionView: UIView!
    @IBOutlet weak var cameraView: ARSCNView!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var scanHeadLabel: UILabel!
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var progressView: GradientHorizontalProgressBar!
    @IBOutlet weak var RetakeButton: UIButton!
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var maskLabel: UILabel!
    func comebackfunc() {
        scanInfoLabel.text = ""
      //  cameraView.session.pause()
        doneView.isHidden = true
        logoView.isHidden = true
        maskView.isHidden = false
        scanControlLabel.text = "Review Scan"
        retakeview.isHidden = false
        RetakeButton.isHidden = false
        viewScanview.isHidden = false
        scanViewButtton.isHidden = false
        
        fromreload = true
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            maskLabel.text = "if you are satisfied with the scan move on to next step or retake the scan"
            backImage.image = UIImage(named: "Group 106")
        }else {
            maskLabel.text = "إذا كنت راضيًا عن الفحص ، فانتقل إلى الخطوة التالية أو أعد إجراء الفحص"
            backImage.image = UIImage(named: "right-arrow(1)")
        }
        
        
        //ScanerView.removeFromSuperview()
        
    }
    var currentfacestate:faceScaningState = .straight {
        didSet {
            DispatchQueue.main.async {
                self.updateUIforFaceScaningState()
            }
        }
    }
    var currentTeethState:TeethScaningState = .straight {
        didSet {
            DispatchQueue.main.async {
                self.updateUIforTeethScaningstate()
            }
        }
    }
    var currentfacehelpState: facetrackingwithhelp = .straight {
        didSet {
            DispatchQueue.main.async {
                self.updateUIForFaceScanHelpScaningState()
            }
        }
    }
    var currentsmilestate:smiledface = .straight {
        didSet {
            DispatchQueue.main.async {
                self.updateuiforsmilescaning()
            }
        }
    }
    var nextState:faceScaningState {
        switch currentfacestate {
        case .straight:
            return .right
        case .right:
            return .completed
//        case .left:
//            return .completed
        case .completed:
            return .completed
//        case .middle:
//            return .left
            
        }
    }
    var nextTeethScaningState :TeethScaningState {
        switch currentTeethState {
            
        case .straight:
            return .left
        case .left:
            return .right
        case .right:
            return .middle
        case .middle:
            return .openup
        case .openup:
            return .opendown
        case .opendown:
            return .completed
        case .completed:
            return .completed
        }
    }
    private var nextFaceScanHelpState:facetrackingwithhelp {
        switch currentfacehelpState {
        case .straight:
            return .right
      //  case .left:
      //      return .right
        case .right:
            return .smiled
        case .completed:
            return .completed
        case .smiled:
            return .completed
        }
    }
 var nextsmilestate:smiledface {
        switch currentsmilestate {
        case .straight:
            return .smilecompleted
        case .smilecompleted:
            return .smilecompleted
        }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInitialLoad()
        
    }
    
    func updateUIforFaceScaningState() {
        
        
        faceTimer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] (timer) in
            
//            if currentfacestate == .middle {
//                
//                cameraView.session.pause()
//                
//                maskView.isHidden = false
//                maskLabel.text = currentfacestate.instructionText
//                faceMasktimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] (timer) in
//                    if DCLanguageManager.sharedInstance.getLanguage() == "en" {
//                        maskLabel.text = "\(currentfacestate.instructionText) "
//                    }else {
//                        maskLabel.text = "\(currentfacestate.arabicfaceinstruction)"
//                    }
//                    faceMaskTimerCount -= 1
//                    if faceMaskTimerCount == -2 {
//                        faceMasktimer.invalidate()
//                        faceMaskTimerCount = 5
//                        cameraView.session.run(cameraView.session.configuration!)
//                        maskView.isHidden = true
//                    }
//                }
//            }
            facetimer += 1
            if facetimer == 3 {
                
                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    if onlyfacescan == true {
                        if currentfacestate == .completed {
                            scantype = .smiledface
                            if facescanAlone == true {
                                scanInfoLabel.text = "please review the scan and submit it to doctor"
                                MP3Player.shared.playLocalFile(name:"smileteeth" )
                            }else {
                                scanInfoLabel?.text = currentfacestate.instructionText
                                MP3Player.shared.playLocalFile(name: currentfacestate.audioCommand)
                            }
                        }else {
                            scanInfoLabel?.text = currentfacestate.instructionText
                            MP3Player.shared.playLocalFile(name: currentfacestate.audioCommand)
                        }
                    }else {
                        scanInfoLabel?.text = currentfacestate.instructionText
                        MP3Player.shared.playLocalFile(name: currentfacestate.audioCommand)
                    }
                }
                else {
                    scanInfoLabel.text = currentfacestate.arabicfaceinstruction
                    MP3Player.shared.playLocalFile(name: currentfacestate.arfaceaudio)
                }
                doneView?.isHidden = true
                logoView.isHidden = true
                scanInfoLabel?.isHidden = false
                distanceInstructionView.isHidden = false
                timer.invalidate()
                facetimer = 0
                
                
                
            }
            
            
        }
        if currentfacestate == .completed {
            scantype = .smiledface
            currentsmilestate = .straight
            if onlyfacescan == true {
                
                scantype = .smiledface
                currentsmilestate = .straight
//                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
//                    scanControlLabel?.text = "Review Scan"
//                }else {
//                    scanControlLabel?.text = "مراجعة المسح"
//                }
//                doneView?.isHidden = false
//                logoView?.isHidden = false
//                retakeview?.isHidden = false
//                viewScanview?.isHidden = false
//                scanViewButtton?.isHidden = false
//                RetakeButton?.isHidden = false
//                ScanerView?.isHidden = true
                
            //    scanInfoLabel.text = "please review the scan and  submit it to doctor"
                
            }else {
                scantype = .smiledface
                currentsmilestate = .straight
//                progresss += 1/4
//                progressView.progress = CGFloat(progresss)
//                scanView?.backgroundColor = UIColor(hexFromString: "20507B")
//                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
//                    scanControlLabel?.text = "Start Teeth Scan"
//                    scanInfoLabel?.text =  "Please click on Start Teeth Scan when ready"
//                }
//                else {
//                    scanControlLabel?.text = "ابدأ فحص الأسنان"
//                    scanInfoLabel?.text = "يرجى النقر فوق بدء فحص الأسنان عندما تكون جاهزًا"
//                }
//
//                scanButton?.isHidden = false
//                if currentfacestate == .middle {
//                    distanceViewHeight.constant = 50
//                    distanceInstructionLabel.isHidden = false
//                }
//                else {
//                    distanceViewHeight.constant = 0
//                    distanceInstructionLabel.isHidden = true
//                }
                
                
//                faceScanIndicationimg.tintColor = UIColor.lightGray
//                faceindicationLabel.textColor = UIColor.lightGray
//                retakeview?.isHidden = false
//                faceindicationLabel.textColor = UIColor.gray
//                viewScanview?.isHidden = false
//                scanViewButtton?.isHidden = false
//                RetakeButton?.isHidden = false
                
                
            }
            
        }
        
    }
    func viewInitialLoad() {
        UIApplication.shared.isIdleTimerDisabled = true
        
        if scantype == .faceScanAlone {
            
            distanceViewHeight.constant = 0
            distanceInstructionLabel.isHidden = true
            MP3Player.shared.playLocalFile(name: "startScan")
            // scanInfoLabel?.text = currentfacestate.instructionText
            
            
            facescanAlone = true
            resetTracking()
            cameraView.delegate = self
            
            ScanerView?.isHidden = true
            facescanindicationview.borderWidth = 3
            facescanindicationview.borderColor = UIColor.white
            viewScanview?.isHidden = true
            // scanViewButtton.isHidden = true
            RetakeButton?.isHidden = true
            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                scanHeadLabel.text = "Face Scan"
                scanControlLabel?.text = "Start Scan"
                //MP3Player.shared.playLocalFile(name:"FaStraight" )
                MP3Player.shared.playLocalFile(name: "startScan")
            }else {
                scanHeadLabel.text = "مسح الوجه"
                scanControlLabel?.text = "ابدأ المسح"
                MP3Player.shared.playLocalFile(name:"arfacealonestraight" )
            }
        }
        else if scantype == .faceScanHelp  {
            distanceInstructionLabel.isHidden = true
            cameraView.delegate = self
            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                MP3Player.shared.playLocalFile(name:"FHStraight" )
                scanHeadLabel.text = "Face Scan"
                scanControlLabel?.text = "Take Photo"
            }
            else {
                MP3Player.shared.playLocalFile(name:"arfacehelpStraight" )
                scanHeadLabel.text = "مسح الوجه"
                scanControlLabel?.text = "تصوير"
            }
            
            ScanerView?.isHidden = true
            facescanindicationview.borderWidth = 3
            facescanindicationview.borderColor = UIColor.white
            maskView.isHidden = true
            resetTracking()
            distanceViewHeight.constant = 0
            distanceInstructionLabel.isHidden = true
            
            
            //            MP3Player.shared.playLocalFile(name: currentfacehelpState.audiocommands)
            //            scanInfoLabel?.text = currentfacehelpState.instructiontext
            retakeview?.isHidden = true
            viewScanview?.isHidden = true
            scanViewButtton?.isHidden = true
            RetakeButton?.isHidden = true
            
        }
        else if scantype == .teethScan {
            
            cameraView.delegate = self
            //scanInfoLabel?.text = currentTeethState.instructiontext
            // MP3Player.shared.playLocalFile(name: currentTeethState.stateAudioCommands)
            maskView.isHidden = true
            // -      distanceViewHeight.constant = 0
            distanceInstructionLabel.isHidden = false
            videoView.isHidden = true
            
            resetTracking()
            
            facescanindicationview.borderWidth = 0
            faceScanIndicationimg.tintColor = UIColor.lightGray
            faceindicationLabel.textColor = UIColor.lightGray
            teethscanindicationimage.tintColor = UIColor.white
            teethScanindicationLabel.textColor =  UIColor.white
            teethscanindicationView.borderWidth = 3
            teethscanindicationView.borderColor = UIColor.white
            retakeview?.isHidden = true
            viewScanview?.isHidden = true
            scanViewButtton?.isHidden = true
            RetakeButton?.isHidden = true
            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                scanInfoLabel?.text = "Please attach the scope to your phone camera and press start scan"
                MP3Player.shared.playLocalFile(name: "TsAttatch")
                
                scanHeadLabel.text = "Teeth Scan"
            }else {
                MP3Player.shared.playLocalFile(name:"tsarStraight" )
                scanControlLabel?.text = "ابدأ المسح"
                scanHeadLabel.text = "فحص الأسنان"
            }
        }
    }
    
    func resetTracking() {
        if scantype == .faceScanAlone {
            guard ARFaceTrackingConfiguration.isSupported else { return }
            let configuration = ARFaceTrackingConfiguration()
            if #available(iOS 13.0, *) {
                configuration.maximumNumberOfTrackedFaces = 1
            }
            configuration.isLightEstimationEnabled = true
            cameraView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            // configuration.isAutoFocusEnabled = true
            
        } else {
            guard ARWorldTrackingConfiguration.isSupported else { return }
            let configuration = ARWorldTrackingConfiguration()
            if #available(iOS 13.0, *) {
                configuration.isLightEstimationEnabled = true
                configuration.isAutoFocusEnabled = true
                configuration.accessibilityElementIsFocused()
                configuration.wantsHDREnvironmentTextures = true
                cameraView.pointOfView?.camera?.focusDistance = 1.5
                cameraView.pointOfView?.camera?.focalLength = 30
               // configuration.automaticallyUpdatesLighting = true
                
               // configuration.userFaceTrackingEnabled = true
                //configuration.accessibilityElementIsFocused.toggle()
                //  configuration.maximumNumberOfTrackedFaces = 1
            }
            configuration.isLightEstimationEnabled = true
            configuration.isAutoFocusEnabled = true
            configuration.accessibilityElementIsFocused()
            configuration.wantsHDREnvironmentTextures = true
           
            cameraView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            
            cameraView.automaticallyUpdatesLighting = true
            
        }
        
    }
        func teethscanstart() {
            
            progresss = 0
            progressView.progress = CGFloat(progresss)
            //MP3Player.shared.playLocalFile(name:"TS-Straight")
            ScanerView?.isHidden = false
            retakeview?.isHidden = true
            viewScanview?.isHidden = true
            scanViewButtton?.isHidden = true
            RetakeButton?.isHidden = true
            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                scanControlLabel?.text = "Scanning..."
            }else {
                scanControlLabel?.text = "يتم المسح..."
            }
            
            
            if currentTeethState == .completed {
                
                let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
                navigationController?.navigationBar.isHidden = true
                vc.delegate = self
                
                
                // vc.faceImgarr = faceimgarr
                // vc.teethimagearr = teethScanArray
                //  vc.onlyTeethScan = onlyTeethScan
                // vc.scanedimagearr = datateethscanarr + datafaceimagear
                //vc.imagebase64 = scanedDataimgarr
                //  vc.testingvar = testingvar
                // vc.scanimgarr = faceimgarr + teethScanArray
                vc.faceScan64 = facescan64
                vc.teethScan64 = teethscan64
                vc.isfromreview = true
                vc.teethimage = teethimage
                vc.onlyTeethScan = onlyTeethScan
                //vc.isfromfacescan == true
                
                if onlyTeethScan == true {
                    vc.isfromteethscan = true
                    vc.scanimgarr = dummyimagEAR + teethScanArray
                    vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
                }
                else {
                    vc.isallscans = true
                    vc.scanimgarr = faceimgarr + teethScanArray
                    vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
                }
                navigationController?.pushViewController(vc, animated: true)
            }
            else  if currentTeethState == .middle {
                scheduledTimerWithTimeInterval()
                scanInfoLabel?.text = "Scanning..."
                scanButton?.isHidden = true
                toggleTorch(on: true)
                doneView.isHidden = true
                logoView.isHidden = true
                currentTeethState = nextTeethScaningState
                scanView?.backgroundColor = UIColor.lightGray
                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    scanInfoLabel?.text = "Scanning..."
                }else {
                    scanInfoLabel?.text = "يتم المسح..."
                }
            }
            else {
                
                
                if scananimation == true {
                    ScanerView?.isHidden = true
                    "Scanning..."
                    scanButton?.isHidden = true
                    //toggleTorch(on: true)
                    ScanerView?.isHidden = false
                    scanView?.backgroundColor = UIColor.lightGray
                    toggleTorch(on: true)
                    scheduledTimerWithTimeInterval()
                    distanceViewHeight.constant = 0
                    distanceInstructionLabel.isHidden = true
                    if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                        scanControlLabel?.text  = "Scanning..."
                    }else {
                        scanControlLabel?.text = "يتم المسح..."
                    }
                }else{
                    currentTeethState = .straight
                    ScanerView?.isHidden = true
                    scanButton?.isHidden = true
                    //toggleTorch(on: true)
                    ScanerView?.isHidden = false
                    scanView?.backgroundColor = UIColor.lightGray
                    toggleTorch(on: true)
                    scheduledTimerWithTimeInterval()
                    // -            distanceViewHeight.constant = 0
                    distanceInstructionLabel.isHidden = true
                    if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                        scanControlLabel?.text  = "Scanning..."
                    }else {
                        scanControlLabel?.text = "يتم المسح..."
                    }
                }
                
                
                
            }
            
        }
        func facescanhelpbuttonAction() {
            if currentfacehelpState == .completed {
                if onlyfacescan == true {
                    let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
                    navigationController?.navigationBar.isHidden = true
                    vc.delegate = self
                    vc.faceScan64 = facescan64
                    vc.isfromreview = true
                    vc.isfromfacescan = true
                    vc.scanimgarr = faceimgarr + dummyfacear
                    vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
                    navigationController?.pushViewController(vc, animated: true)
                }
                else {
                    
                    let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeethScanVC") as! TeethScanVC
                    vc.scanimgarr = faceimgarr
                    vc.facescan64 = facescan64
                    if manualmode == true {
                        vc.scantype = .teethScanwithHelp
                    }else if manualmode == false {
                        vc.scantype = .teethScan
                    }
                    navigationController?.navigationBar.isHidden = true
                    navigationController?.pushViewController(vc, animated: false)
                    //                    scantype = .teethScan
                    //                    resetTracking()
                    //
                    //                    facescanindicationview.borderWidth = 0
                    //                    scanHeadLabel.text = "Teeth Scan"
                    //                    faceScanIndicationimg.tintColor = UIColor.lightGray
                    //                    faceindicationLabel.textColor = UIColor.lightGray
                    //                    teethscanindicationimage.tintColor = UIColor.white
                    //                    teethScanindicationLabel.textColor =  UIColor.white
                    //                    teethscanindicationView.borderWidth = 3
                    //                    teethscanindicationView.borderColor = UIColor.white
                    //                    progresss = 0
                    //                    retakeview?.isHidden = false
                    //                    viewScanview?.isHidden = false
                    //                    scanViewButtton?.isHidden = false
                    //                    RetakeButton?.isHidden = false
                    //                    if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    //                        scanControlLabel?.text = "Start Scan"
                    //                        scanInfoLabel?.text = "Please attach the scope to your phone camera and press start scan"
                    //                        MP3Player.shared.playLocalFile(name: "TsAttatch")
                    //                    }else {
                    //                        scanControlLabel?.text = "ابدأ المسح"
                    //                        scanInfoLabel?.text = "يرجى إرفاق النطاق بكاميرا هاتفك والضغط على بدء المسح"
                    //                    }
                    //                }
                }
            }
            else {
                progresss += 1/4
                progressView.progress = CGFloat(progresss)
                doneView?.isHidden = false
                logoView.isHidden = false
                
                captureimg()
                
                currentfacehelpState = nextFaceScanHelpState
                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    MP3Player.shared.playLocalFile(name: "its-Done")
                    scanControlLabel?.text = "Take Photo"
                }else {
                    MP3Player.shared.playLocalFile(name: "its-DoneAr")
                    scanControlLabel?.text = "تصوير"
                }
            }
        }
        
        
        
        
        
        
        @IBAction func scanButtonAction(_ sender: UIButton) {
            
            
            
            if scantype == .faceScanAlone {
                videoView.isHidden = true
                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    scanControlLabel?.text = "Scanning.."
                }else {
                    scanControlLabel?.text =   "يتم المسح.."
                }
                
                cameraView.session.run(cameraView.session.configuration!)
                
                startscaning = true
                if currentfacestate == .completed {
                    if onlyfacescan == true {
                        let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
                        navigationController?.navigationBar.isHidden = true
                        vc.delegate = self
                        vc.faceScan64 = facescan64
                        vc.isfromreview = true
                        vc.isfromfacescan = true
                        vc.scanimgarr = faceimgarr + dummyfacear
                        vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
                        navigationController?.pushViewController(vc, animated: true)
                        
                    }else {
                        scantype = .smiledface
                       
                        resetTracking()
                        
                        facescanindicationview.borderWidth = 0
                        faceScanIndicationimg.tintColor = UIColor.lightGray
                        distanceViewHeight.constant = 0
                        distanceInstructionLabel.isHidden = true
                        teethscanindicationimage.tintColor = UIColor.white
                        teethScanindicationLabel.textColor =  UIColor.white
                        teethscanindicationView.borderWidth = 3
                        teethscanindicationView.borderColor = UIColor.white
                        progresss = 0
                        retakeview?.isHidden = true
                        viewScanview?.isHidden = true
                        scanViewButtton?.isHidden = true
                        RetakeButton?.isHidden = true
                        
                        //                videoView.isHidden = false
                        //                playVideo()
                        //                avpController.player?.play()
                        
                        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                            scanControlLabel?.text = "Start Scan"
                            //                            scanInfoLabel?.text = "Please attach the scope to your phone camera and press start scan"
                            scanHeadLabel.text = "Teeth Scan"
                        }else {
                            scanControlLabel?.text = "ابدأ المسح"
                            //                            scanInfoLabel?.text = "Please attach the scope to your phone camera and press start scan"
                            scanHeadLabel.text = "فحص الأسنان"
                            
                            
                        }
                        
                    }
                }
               
            }else if scantype == .smiledface {
                smilesbuttonaction()
            }
            else if scantype == .teethScan {
                teethscanstart()
                
                
                
            }else if scantype == .faceScanHelp  {
                
                facescanhelpbuttonAction()
            }else if currentsmilestate == .smilecompleted {
                if onlyfacescan == true {
                    let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
                    navigationController?.navigationBar.isHidden = true
                    vc.delegate = self
                    vc.faceScan64 = facescan64
                    vc.isfromreview = true
                    vc.isfromfacescan = true
                    vc.scanimgarr = faceimgarr + dummyfacear
                    vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
                    navigationController?.pushViewController(vc, animated: true)
                }
                else
                {
                    let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeethScanVC") as! TeethScanVC
                    navigationController?.navigationBar.isHidden = true
                    navigationController?.pushViewController(vc, animated: false)
                  
//                    scantype = .teethScan
//                    resetTracking()
//
//                    facescanindicationview.borderWidth = 3
//                    faceScanIndicationimg.tintColor = UIColor.white
//                    distanceViewHeight.constant = 50
//                    distanceInstructionLabel.isHidden = false
//                    teethscanindicationimage.tintColor = UIColor.gray
//                    teethScanindicationLabel.textColor =  UIColor.gray
//                    teethscanindicationView.borderWidth = 0
//                    teethscanindicationView.borderColor = UIColor.gray
//                    progresss = 0
//                    retakeview?.isHidden = true
//                    viewScanview?.isHidden = true
//                    scanViewButtton?.isHidden = true
//                    RetakeButton?.isHidden = true
                    
                }
            }
        }
    func updateuiforsmilescaning() {
        scanInfoLabel.text = currentsmilestate.instructiontext
        if currentsmilestate == .smilecompleted {
            if onlyfacescan == true {
                doneView?.isHidden = false
                logoView?.isHidden = false
                retakeview?.isHidden = false
                viewScanview?.isHidden = false
                scanViewButtton?.isHidden = false
                RetakeButton?.isHidden = false
                ScanerView?.isHidden = true
                
                scanInfoLabel.text = "please review the scan and  submit it to doctor"
                scanControlLabel?.text = "Review Scan"
                MP3Player.shared.playLocalFile(name: "facealonecompleted")
            }else {
                scanControlLabel?.text = "Start Teeth Scan"
                scanInfoLabel?.text =  "Please click on Start Teeth Scan when ready"
                doneView?.isHidden = false
                logoView?.isHidden = false
                retakeview?.isHidden = false
                viewScanview?.isHidden = false
                scanViewButtton?.isHidden = false
                RetakeButton?.isHidden = false
                ScanerView?.isHidden = true
            }
        }
    }
    
        
        @IBAction func retakeButtonAction(_ sender: UIButton) {
            retake()
        }
        
        @IBAction func backButtonAction(_ sender: UIButton) {
            cameraView.session.pause()
            if iscompletedback == true {
                navigationController?.popToViewController(ofClass: ScannSelectionVC.self)
                
            }else {
                navigationController?.popViewController(animated: true)
            }
        }
        
        @IBAction func viewscanButton(_ sender: UIButton) {
            
            if scantype == .teethScan {
                let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
                navigationController?.navigationBar.isHidden = true
                vc.delegate = self
                vc.teethimagearr =  teethScanArray
                //   vc.reviewHeadLabel.text = "Teeth Scan"
                //vc.teethimagearr.insert(UIImage(named: "Group 160")!, at: 4)
                vc.faceScan64 = facescan64
                vc.teethScan64 = teethscan64
                vc.isfromteethscan = true
                vc.isfromviewscan = true
                navigationController?.pushViewController(vc, animated: false)
            }
            else {
                let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
                navigationController?.navigationBar.isHidden = true
                vc.delegate = self
                vc.scanimgarr = teethScanArray
                // vc.reviewHeadLabel.text = "Face Scan"
                vc.faceimagearr =  faceimgarr
               // vc.isfacethscanalone =
                // vc.faceimagearr.insert(UIImage(named: "Group 160")!, at: 4)
                vc.isfacescanalone = isfacescanalone
                vc.isfromviewscan = true
                navigationController?.pushViewController(vc, animated: false)
                
            }
        }
    
        
    func smilesbuttonaction() {
        
            if currentsmilestate == .smilecompleted {
                if onlyfacescan == true {
                let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
                navigationController?.navigationBar.isHidden = true
                vc.delegate = self
                vc.faceScan64 = facescan64
                vc.isfromreview = true
                vc.isfromfacescan = true
                vc.scanimgarr = faceimgarr + dummyfacear
                vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
                navigationController?.pushViewController(vc, animated: true)
                }else {
                    let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeethScanVC") as! TeethScanVC
                    vc.facescan64 = facescan64
                    vc.scanimgarr = faceimgarr
                    if manualmode == true {
                        vc.scantype = .teethScanwithHelp
                    }
                    else if manualmode == false {
                        vc.scantype = .teethScan
                    }
                    navigationController?.navigationBar.isHidden = true
                    navigationController?.pushViewController(vc, animated: false)
//                    resetTracking()
//
//                    facescanindicationview.borderWidth = 0
//                    faceScanIndicationimg.tintColor = UIColor.lightGray
//                    distanceViewHeight.constant = 0
//                    distanceInstructionLabel.isHidden = true
//                    teethscanindicationimage.tintColor = UIColor.white
//                    teethScanindicationLabel.textColor =  UIColor.white
//                    teethscanindicationView.borderWidth = 3
//                    teethscanindicationView.borderColor = UIColor.white
//                    progresss = 0
//                    retakeview?.isHidden = true
//                    viewScanview?.isHidden = true
//                    scanViewButtton?.isHidden = true
//                    RetakeButton?.isHidden = true
//                    scanHeadLabel.text = "Teeth Scan"
//                    scantype = .teethScan
                }
        }
    }
        
        
        
    }
 
