//
//  TeethScanLanVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 23/03/2023.
//

import UIKit
import AVFoundation

class TeethScanLanVC: UIViewController, FinalReviewdelegate {
   
    
    let session = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()
    var videoDeviceInput: AVCaptureDeviceInput!
    let sessionQueue = DispatchQueue(label: "session queue",
                                     attributes: [],
                                     target: nil)
    var setupResult: SessionSetupResult = .success
    var previewLayer : AVCaptureVideoPreviewLayer!
    var imagear:[UIImage] = []
    var image64:[String] = []
    var teethtimer = Timer()
    var isteethreload:Bool?
    var retaketimer = Timer()
    var  retaketimercount:Int = 0
    var teethclicktimer = Timer()
    var teethtimercount = 0
    var teethclicktimercount = 0
    var fromretake:Bool?
    var needcapture:Bool? = false
    var imageNumber:Int?
    var teethscanauto:Bool?
    var scantype:scanType?
    var retakecompleted:Bool?
    var retaketimers:Bool?
    var teethimage:[UIImage] = []
    var teethscan64:[String] = []
    var facescan64:[String] = []
    var scanimgarr:[UIImage] = []
    var onlyTeethScan:Bool?
    var fromreview:Bool? = true
    var progresss:Float = 0.0
    var dummyimagEAR:[UIImage] = [UIImage(named: "images")!,UIImage(named: "images")!,UIImage(named: "images")!]
    var dummyfacear:[UIImage] = [UIImage(named: "images")!,UIImage(named: "images")!,UIImage(named: "images")!,UIImage(named: "images")!,UIImage(named: "images")!]
    var scananimation:Bool?
    @IBOutlet weak var viewscanButton: UIButton!
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var scanerView: UIView!
    @IBOutlet weak var scanInfoLabel: UILabel!
    @IBOutlet weak var scanControlLabel: UILabel!
    @IBOutlet weak var retakeLabel: UILabel!
    @IBOutlet weak var viewScanLabel: UILabel!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var viewScanView: UIView!
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var retakeView: UIView!
    @IBOutlet weak var scanButton: UIButton!
    var fromreload:Bool?
    var currentTeethState:TeethScaningState = .straight {
        didSet {
            DispatchQueue.main.async {
                self.updateUIforTeethScaningstate()
            }
        }
    }
    var currentteethstatewithhelp:teethScanWithHelp = .straight {
        didSet {
            DispatchQueue.main.async {
                self.updateuiforteethmanualstate()
            }
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
    var nextteethscaningmanualstate:teethScanWithHelp{
        switch currentteethstatewithhelp {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        scanInfoLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        scanControlLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        doneView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        viewScanLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        retakeLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            MP3Player.shared.playLocalFile(name: self.currentteethstatewithhelp.audiocommands)
            toggleTorch()
        }
        if fromretake == true {
            retake()
            scanerView.isHidden = true
        }else {
            //MP3Player.shared.playLocalFile(name: "startScan")
            scanerView.isHidden = false
        }
        checkAuthorization()
        MP3Player.shared.playLocalFile(name: "startScan")
        //photoSettings.flashMode = .on
        sessionQueue.async { [unowned self] in
            self.configureSession()
        }
        if scantype == .teethScan {
            scanInfoLabel.text = "Please look straight and click start scan when ready"
            scanControlLabel.text = "Start scan"
            //
           
           
            DispatchQueue .main.async { [unowned self] in
               // MP3Player.shared.playLocalFile(name: "startScan")
                let layer = createScannerGradientLayer(for: scanerView!)
                scanerView!.layer.insertSublayer(layer, at: 0)
                let animation = createAnimation(for: layer)
                layer.add(animation, forKey: nil)
            }
        }else {
            scanInfoLabel.text = currentteethstatewithhelp.instructiontext
            scanControlLabel.text = "Capture"
            //scanerView.isHidden = false
            DispatchQueue .main.async { [unowned self] in
                let layer = createScannerGradientLayer(for: scanerView!)
                scanerView!.layer.insertSublayer(layer, at: 0)
                let animation = createAnimation(for: layer)
                layer.add(animation, forKey: nil)
            }
//            DispatchQueue .main.async { [unowned self] in
//
//
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                MP3Player.shared.playLocalFile(name: self.currentteethstatewithhelp.audiocommands)
                toggleTorch()
            }

            
        }

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sessionQueue.async {
            switch self.setupResult {
            case .success:
                // Only start the session running if setup succeeded.
                DispatchQueue.main.async { [unowned self] in
                    self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                    self.previewLayer.videoGravity = .resizeAspectFill
                    self.previewLayer.frame = self.cameraView.bounds
                    self.cameraView.layer.addSublayer(self.previewLayer)
                    DispatchQueue.global(qos: .background).async {
                        self.session.startRunning()
                    }
                    
                   
                   
                    
                    
                }
                
            case .notAuthorized:
                DispatchQueue.main.async { [unowned self] in
                    let changePrivacySetting = "AVCam doesn't have permission to use the camera, please change privacy settings"
                    let message = NSLocalizedString(changePrivacySetting, comment: "Alert message when the user has denied access to the camera")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                            style: .cancel,
                                                            handler: nil))
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"),
                                                            style: .`default`,
                                                            handler: { _ in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            case .configurationFailed:
                DispatchQueue.main.async { [unowned self] in
                    let alertMsg = "Alert message when something goes wrong during capture session configuration"
                    let message = NSLocalizedString("Unable to capture media", comment: alertMsg)
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                            style: .cancel,
                                                            handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        sessionQueue.async { [unowned self] in
            if self.setupResult == .success {
                self.session.stopRunning()
            }
        }
        
        super.viewWillDisappear(animated)
    }
    func viewscanback() {
        comebackfunc()
    }
    @IBAction func retakeButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "RetakeVC") as! RetakeVC
        vc.retakeimagear = teethimage
        vc.teethimage64 = teethscan64
        vc.facescan64 = facescan64
        vc.facescanimage = scanimgarr
        
        vc.onlyteethscan = onlyTeethScan
        if scantype == .teethScan {
            vc.teethscanauto = true
        }else if scantype == .teethScanwithHelp {
            vc.teethscanauto = false
        }
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
  
    @IBAction func scanViewButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
        navigationController?.navigationBar.isHidden = true
        vc.delegate = self
        vc.teethimagearr =  teethimage
        //   vc.reviewHeadLabel.text = "Teeth Scan"
        //vc.teethimagearr.insert(UIImage(named: "Group 160")!, at: 4)
        vc.faceScan64 = facescan64
        vc.teethScan64 = teethscan64
        fromreview = true
        vc.isfromteethscan = true
        vc.isfromviewscan = true
        
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func scanButtonAction(_ sender: UIButton) {
        teethscanstart()
    }
    func updateuiforteethmanualstate() {
        
        scanInfoLabel.text = currentteethstatewithhelp.instructiontext
        MP3Player.shared.playLocalFile(name: currentteethstatewithhelp.audiocommands)
        if currentteethstatewithhelp == .completed {
            doneView?.isHidden = false
            logoView?.isHidden = false
            retakeView?.isHidden = false
            viewScanView?.isHidden = false
            viewscanButton.isHidden = false
            scanButton?.isHidden = false
            retakeButton?.isHidden = false
            scanerView?.isHidden = true
            scanControlLabel?.text = "Review Scan"
        }
        
        
    }
    func updateUIforTeethScaningstate() {
        scanInfoLabel.text = currentTeethState.instructiontext
        MP3Player.shared.playLocalFile(name: currentTeethState.stateAudioCommands)
        if currentTeethState == .straight {
            //         if isteethreload == false {
            // if scananimation == false {
            
            if isteethreload == false {
                let layer = createScannerGradientLayer(for: scanerView!)
                scanerView!.layer.insertSublayer(layer, at: 0)
                let animation = createAnimation(for: layer)
                layer.add(animation, forKey: nil)
                //            }
            }
            
        }
        if currentTeethState == .middle {
            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                scanControlLabel?.text = "Start Scan"
                doneView?.isHidden = false
                logoView.isHidden = false
            }
        }
        if currentTeethState == .completed {
           doneView?.isHidden = false
           logoView?.isHidden = false
           retakeView?.isHidden = false
           viewScanView?.isHidden = false
            viewscanButton.isHidden = false
           scanButton?.isHidden = false
           retakeButton?.isHidden = false
           scanerView?.isHidden = true
           if DCLanguageManager.sharedInstance.getLanguage() == "en" {
               scanControlLabel?.text = "Review Scan"
           }else {
               scanControlLabel?.text = "مراجعة الفحص"
           }
           
           
       }
       
       if currentTeethState == .completed {
           // MP3Player.shared.playLocalFile(name: "")
           teethtimer.invalidate()
           teethclicktimer.invalidate()
           teethtimercount = 0
           teethclicktimercount = 0
         //  toggleTorch()
           
           scanView?.backgroundColor = UIColor.clear
           scanButton?.isHidden = false
       }else if  currentTeethState == .middle {
           teethtimer.invalidate()
           teethclicktimer.invalidate()
           teethtimercount = 0
           teethclicktimercount = 0
          // toggleTorch()
           
           scanView?.backgroundColor = UIColor.clear
           scanButton?.isHidden = false
       }
        
        
    }

func teethscanstart() {
    if fromretake == true {
        retake()
       
    }else {
    if scantype == .teethScan {
        if currentTeethState == .straight {
           // toggleTorch()
        }
        
        progresss = 0
        //  progressView.progress = CGFloat(progresss)
        //MP3Player.shared.playLocalFile(name:"TS-Straight")
        scanerView?.isHidden = false
        retakeView?.isHidden = true
        viewScanView?.isHidden = true
        viewscanButton?.isHidden = true
        retakeButton?.isHidden = true
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            scanControlLabel?.text = "Scanning..."
        }else {
            scanControlLabel?.text = "يتم المسح..."
        }
        
        
        if currentTeethState == .completed {
            
            let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
            vc.delegate = self
            navigationController?.navigationBar.isHidden = true
            // vc.delegate = self
            fromreview = true
            
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
            vc.teethimagearr =  teethimage
            vc.onlyTeethScan = onlyTeethScan
            //vc.isfromfacescan == true
            
            if onlyTeethScan == true {
                vc.isfromteethscan = true
                vc.scanimgarr = dummyimagEAR + teethimage
                vc.teethScan64 = teethscan64
                vc.faceScan64 = facescan64
                vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
                
            }
            else {
                vc.isallscans = true
                vc.scanimgarr = scanimgarr + teethimage
                vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
            }
            navigationController?.pushViewController(vc, animated: true)
        }
        else  if currentTeethState == .middle {
            scheduledTimerWithTimeInterval()
            scanInfoLabel?.text = "Scanning..."
            scanButton?.isHidden = true
            // toggleTorch(on: true)
            doneView.isHidden = true
            logoView.isHidden = true
            currentTeethState = nextTeethScaningState
            scanView?.backgroundColor = UIColor.clear
            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                scanInfoLabel?.text = "Scanning..."
            }else {
                scanInfoLabel?.text = "يتم المسح..."
            }
        }
        else {
            
            
            if scananimation == true {
                scanerView?.isHidden = true
                //  "Scanning..."
                scanButton?.isHidden = true
                //toggleTorch(on: true)
                scanerView?.isHidden = false
                scanView?.backgroundColor = UIColor.clear
                //  toggleTorch(on: true)
                scheduledTimerWithTimeInterval()
                // distanceViewHeight.constant = 0
              //  distanceInstructionLabel.isHidden = true
                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    scanControlLabel?.text  = "Scanning..."
                }else {
                    scanControlLabel?.text = "يتم المسح..."
                }
            }else{
                currentTeethState = .straight
                scanerView?.isHidden = true
                scanButton?.isHidden = true
                //toggleTorch(on: true)
                scanerView?.isHidden = false
                scanView?.backgroundColor = UIColor.clear
                // toggleTorch(on: true)
                scheduledTimerWithTimeInterval()
                // -            distanceViewHeight.constant = 0
                //distanceInstructionLabel.isHidden = true
                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    scanControlLabel?.text  = "Scanning..."
                }else {
                    scanControlLabel?.text = "يتم المسح..."
                }
            }
            
            
            
        }
    }else if scantype == .teethScanwithHelp {
        if currentteethstatewithhelp == .completed {
            
            scanControlLabel?.text = "Review Scan"
            let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinalReviewVC") as! FinalReviewVC
            vc.delegate = self
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(vc, animated: true)
            // vc.delegate = self
            fromreview = true
            vc.faceScan64 = facescan64
            vc.teethScan64 = teethscan64
            vc.isfromreview = true
            vc.teethimagearr =  teethimage
            vc.onlyTeethScan = onlyTeethScan
            if onlyTeethScan == true {
                vc.isfromteethscan = true
                vc.scanimgarr = dummyimagEAR + teethimage
                vc.teethScan64 = teethscan64
                vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
                
            }
            else {
                vc.isallscans = true
                vc.scanimgarr = scanimgarr + teethimage
                vc.scanimgarr.insert(UIImage(named: "Group 160")!, at: 4)
            }
        }else if currentteethstatewithhelp == .middle {
            currentteethstatewithhelp = nextteethscaningmanualstate
            scanControlLabel.text = "Capture"
        }else {
            captureimage()
            currentteethstatewithhelp = nextteethscaningmanualstate
            scanControlLabel.text = "Capture"
            
        }
    }
}
}

    
}


extension TeethScanLanVC:AVCapturePhotoCaptureDelegate {
    enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
    
    func checkAuthorization() {
        /*
         Check video authorization status. Video access is required and audio
         access is optional. If audio access is denied, audio is not recorded
         during movie recording.
         */
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            // The user has previously granted access to the camera.
            break
            
        case .notDetermined:
            /*
             The user has not yet been presented with the option to grant
             video access. We suspend the session queue to delay session
             setup until the access request has completed.
             
             Note that audio access will be implicitly requested when we
             create an AVCaptureDeviceInput for audio during session setup.
             */
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [unowned self] granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })
            
        default:
            // The user has previously denied access.
            setupResult = .notAuthorized
        }
    }
    private func configureSession() {
        if setupResult != .success {
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.photo
        
        // Add video input.
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            // Choose the back dual camera if available, otherwise default to a wide angle camera.
            let dualCameraDeviceType: AVCaptureDevice.DeviceType
            if #available(iOS 11, *) {
                dualCameraDeviceType = .builtInUltraWideCamera
                // toggleTorch(on: true)
                toggleTorch()
            } else  if #available(iOS 15.4, *){
                dualCameraDeviceType = .builtInTripleCamera
            }else{
                dualCameraDeviceType = .builtInTripleCamera
            }
            
            //            if let dualCameraDevice = AVCaptureDevice.default(dualCameraDeviceType, for: AVMediaType.video, position: .back)
            let dualCameraDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualWideCamera], mediaType: AVMediaType.video, position: .back)
            
            if let device = dualCameraDevice.devices.first
            {
                try device.lockForConfiguration()
                defaultVideoDevice = device
                // device.videoZoomFactor = 2.0
                //  defaultVideoDevice?.focusMode = .continuousAutoFocus
                device.unlockForConfiguration()
            } else if let backCameraDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInUltraWideCamera, for: AVMediaType.video, position: .back) {
                // If the back dual camera is not available, default to the back wide angle camera.
                defaultVideoDevice = backCameraDevice
                defaultVideoDevice?.focusMode = .continuousAutoFocus
                
                //   defaultVideoDevice?.deviceType = .builtInDualWideCamera
            } else if let frontCameraDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
                /*
                 In some cases where users break their phones, the back wide angle camera is not available.
                 In this case, we should default to the front wide angle camera.
                 */
                defaultVideoDevice = frontCameraDevice
            }
            
            let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice!)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
            } else {
                print("Could not add video device input to the session")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
        } catch {
            print("Could not create video device input: \(error)")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        session.commitConfiguration()
        // Add photo output.
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            
            photoOutput.isHighResolutionCaptureEnabled = true
            photoOutput.isLivePhotoCaptureEnabled = photoOutput.isLivePhotoCaptureSupported
        } else {
            print("Could not add photo output to the session")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        session.commitConfiguration()
    }


//func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
//
//    if let error = error {
//        print("Error capturing photo: \(error)")
//    } else {
//        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
//
//            if let image = UIImage(data: dataImage) {
//                //                    self.capturedImage.image = image
//                if let data = image.jpegData(compressionQuality: 1) {
//                    let base64 = data.base64EncodedString(options: .lineLength64Characters)
//                    // testingvar.append(base64)
//                    //scanedDataimgarr.append(base64)
//                    // teethimage = base64
//                    image64.append(base64)
//                }
//            }
//        }
//    }
//
//}
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print("Error capturing photo: \(error)")
        } else {
            if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
                
                if let image = UIImage(data: dataImage) {
                    //   self.capturedImage.image = image
                    if let image = UIImage(data: dataImage) {
                        if fromretake == true {
                            // teethimage.append(logo)
                            //  teethimage.insert(UIImage(named: "Group 160")!, at: 4)
                            teethimage.remove(at: imageNumber ?? 0)
                            teethimage.insert(image, at: imageNumber ?? 0)
                            
                        }else {
                            teethimage.append(image)
                            
                        }
                        //                    self.capturedImage.image = image
                        if let data = image.jpegData(compressionQuality: 1) {
                            let base64 = data.base64EncodedString(options: .lineLength64Characters)
                            // testingvar.append(base64)
                            //scanedDataimgarr.append(base64)
                            // teethimage = base64
                            if fromretake == true {
                                teethscan64.remove(at: imageNumber ?? 0)
                                teethscan64.insert(base64, at: imageNumber ?? 0)
                                fromretake = false
                                if teethscanauto == true {
                                    
                                }else {
                                    currentteethstatewithhelp = .completed
                                }
                            }else {
                                teethscan64.append(base64)
                            }
                        }
                    }
                }
            }
            
        }
    }

func toggleTorch() {
    
    let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualWideCamera], mediaType: AVMediaType.video, position: .back)
    
    guard let device = deviceDiscoverySession.devices.first
    else {return}
    
    if device.hasTorch {
        do {
            try device.lockForConfiguration()
            let on = device.isTorchActive
            if on != true && device.isTorchModeSupported(.on) {
                try device.setTorchModeOn(level: 1.0)
            } else if device.isTorchModeSupported(.off){
                device.torchMode = .off
            } else {
                print("Torch mode is not supported")
            }
            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used")
        }
    } else {
        print("Torch is not available")
    }
}
    func retake() {
        if teethscanauto == true {
            if imageNumber == 0 {
                currentTeethState = .straight
               
                
            }else if imageNumber == 1 {
                currentTeethState = .left
                
            }else if imageNumber == 2 {
                currentTeethState = .right
              
            }else if imageNumber == 3 {
                currentTeethState = .openup
              
            }else if imageNumber == 4 {
                currentTeethState = .opendown
               
            }
            
            if retaketimers == true {
                retaketimerFunc()
                scanerView.isHidden = false
                scanControlLabel.text = "Scanning"
                updateUIforTeethScaningstate()
            }
            retaketimers = true
        }
        else {
            if imageNumber == 0 {
                currentteethstatewithhelp = .straight
            }else if imageNumber == 1 {
                currentteethstatewithhelp = .left
            }else if imageNumber == 2 {
                currentteethstatewithhelp = .right
            }else if imageNumber == 3 {
                currentteethstatewithhelp = .opendown
            }else if imageNumber == 4 {
                currentteethstatewithhelp = .openup
            }
            updateuiforteethmanualstate()
            if needcapture == true {
                captureimage()
                scantype = .teethScanwithHelp
                currentteethstatewithhelp = .completed
            }else if needcapture == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.toggleTorch()
            }
            }
            needcapture = true
            
        }
        
    }
    func retaketimerFunc() {
        retaketimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [self] (timer) in
            retaketimercount += 1
            scanView.isHidden = false
            if retaketimercount == 8 {
                captureimage()
                currentTeethState = .completed
            }
        }
    }
    func captureimage() {
        //     if scantype == .teethScan {
        //        DispatchQueue.main.async { [unowned self] in
        //            // scheduletimer.invalidate()
        //            if let img: CVPixelBuffer = self.cameraView.currentFrame?.capturedImage {
        //                // scheduletimer.invalidate()
        //
        //                let ciimg = CIImage(cvImageBuffer: img)
        //                var myimg = (UIImage(ciImage: ciimg ))
        //              //  let rotatedImage = myimg.rotate(radians: .pi)
        //
        //
        //                if let data = myimg.jpegData(compressionQuality: 1) {
        //                    let base64 = data.base64EncodedString(options: .lineLength64Characters)
        //                   // testingvar.append(base64)
        //                    //scanedDataimgarr.append(base64)
        //                    teethimage = base64
        //                    teethscan64.append(base64)
        //                }
        //
        //                self.teethScanArray.append(UIImage(ciImage: ciimg ))
        //
        //            }
        //        }
        
        //  }
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        //        if self.videoDeviceInput.device.isFlashAvailable {
        //           // photoSettings.flashMode = .on
        //
        //        }
        
        if let firstAvailablePreviewPhotoPixelFormatTypes = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: firstAvailablePreviewPhotoPixelFormatTypes]
        }
        
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    func scheduledTimerWithTimeInterval(){
        
        teethtimer =  Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [self] (timer) in
            
            teethtimercount += 1
            // toggleTorch(on: true)
            scanView?.isHidden = false
            
            if teethtimercount == currentTeethState.timercount {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    timer.invalidate()
                    teethclicktimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [self] (clicktimer) in
                        teethclicktimercount += 2
                        
                        
                        
                       // progressView.progress = CGFloat(progresss)
                        
                        
                        
                        
                        
                        if teethclicktimercount == 6 {
                            //                            if currentState == .left {
                            //                                captureimg()
                            //
                            //                            }
                         //   MP3Player.shared.playLocalFile(name: "click")
                            //scannerView.isHidden = fale
                            
                            captureimage()
                            doneView?.isHidden = true
                            logoView.isHidden = true
                            teethclicktimer.invalidate()
                            teethclicktimercount = 0
                            currentTeethState = nextTeethScaningState
                            teethtimer.invalidate()
                            // progresss += 1/2
                            //                           progressspercent = Int(progresss * 100)
                            scanView?.isHidden = false
                            teethtimercount = 0
                            scheduledTimerWithTimeInterval()
                            if currentTeethState == .openup || currentTeethState == .opendown || currentTeethState == .completed {
                                progresss += 1/2
                                //progressspercent = Int(progresss * 100)
                               // progressView.progress = CGFloat(progresss)
                                
                                // progressPercent.text = "\(progressspercent)%"
                            } else {
                                progresss += 1/3
                                //     progressspercent = Int(progresss * 100)
                               // progressView.progress = CGFloat(progresss)
                                
                                //progressPercent.text = "\(progressspercent)%"
                            }
                            
                        }
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                }
            }
        }
    }
//@available(iOS 11.0, *)
//func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//
//    guard let data = photo.fileDataRepresentation(),
//          let image =  UIImage(data: data)
//
//
//    else {
//        return
//    }
//    imagear.append(image)
//    //  if let image = UIImage(data: image) {
//    //                    self.capturedImage.image = image
//    if let data = image.jpegData(compressionQuality: 1) {
//        let base64 = data.base64EncodedString(options: .lineLength64Characters)
//        // testingvar.append(base64)
//        //scanedDataimgarr.append(base64)
//        // teethimage = base64
//        image64.append(base64)
//    }
//}
    func createScannerGradientLayer(for view: UIView) -> CAGradientLayer {
       
        let height = 5 // + 10
        
        let opacity: Float = 0.5
        let width = scanerView!.frame.width  //view.frame.width
        let topColor = {UIColor.red}
        let bottomColor = topColor()
        
        let layer = CAGradientLayer()
        layer.colors = [topColor().cgColor, bottomColor.cgColor]
        layer.opacity = opacity
        layer.frame = CGRect(x: 0, y: 0, width: Int(width), height: Int(height)) //Int(height))
        return layer
        
    }
    
    func createAnimation(for layer: CAGradientLayer) -> CABasicAnimation {
        guard let superLayer = layer.superlayer else {
            fatalError("Unable to create animation, layer should have superlayer")
        }
        let superLayerWidth = scanerView!.frame.height
        let layerWidth = layer.frame.height

        let value = superLayerWidth - layerWidth
        
        let initialYPosition = layer.position.y
        let finalYPosition = initialYPosition + value
        let duration: CFTimeInterval = 4
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = initialYPosition as NSNumber
        animation.toValue = finalYPosition as NSNumber
        animation.duration = duration
        animation.repeatCount = .infinity
        return animation
    }
    func comebackfunc() {
        scanInfoLabel.text = ""
      //  cameraView.session.pause()
        doneView.isHidden = true
        logoView.isHidden = true
        //maskView.isHidden = false
        scanControlLabel.text = "review"
        retakeView.isHidden = false
        retakeButton.isHidden = false
        viewScanView.isHidden = false
        viewscanButton.isHidden = false
        fromreview = false
        fromreload = true
//            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
//                maskLabel.text = "if you are satisfied with the scan move on to next step or retake the scan"
//                backImage.image = UIImage(named: "Group 106")
//            }else {
//                maskLabel.text = "إذا كنت راضيًا عن الفحص ، فانتقل إلى الخطوة التالية أو أعد إجراء الفحص"
//                backImage.image = UIImage(named: "right-arrow(1)")
//            }
        
        
        //ScanerView.removeFromSuperview()
        
    }


}
