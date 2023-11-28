//
//  ScanTestVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 24/01/2023.
//

import UIKit
import ARKit
import KVSpinnerView

class ScanTestVC: UIViewController, ARSCNViewDelegate {
   
    @IBOutlet weak var scanLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var scanerView: UIView!
    let session = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()
    var imagear:[UIImage] = []
    var image64:[String] = []
    let photoSettings = AVCapturePhotoSettings()
    let sessionQueue = DispatchQueue(label: "session queue",
                                     attributes: [],
                                     target: nil)
    
    var previewLayer : AVCaptureVideoPreviewLayer!
    var videoDeviceInput: AVCaptureDeviceInput!
    var setupResult: SessionSetupResult = .success
    // var flash: AVCaptureDevice.FlashMode = .on
    //    var currentTeethState:TeethScaningState = .straight {
    //        didSet {
    //            DispatchQueue.main.async {
    //                self.updateUIforTeethScaningstate()
    //            }
    //        }
    //    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // DispatchQueue.global(qos: .background).async { [unowned self] in
        self.configureSession()
        //AVCaptureDevice.FlashMode.on
        self.flashActive()
        createlabel()
        testLabel.text = "Please ask the patient to open the mouth and look down so we can capture lower teeth. Press capture button when ready."
        
        testLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        scanLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
       
        DispatchQueue .main.async { [unowned self] in
           // MP3Player.shared.playLocalFile(name: "startScan")
            let layer = createScannerGradientLayer(for: scanerView!)
            scanerView!.layer.insertSublayer(layer, at: 0)
            let animation = createAnimation(for: layer)
            layer.add(animation, forKey: nil)
        }
        
        
        //  }
    }
    func createlabel() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = "Hello World!"

        // Set the font and color of the label
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black

        // Apply a rotation transform to the label
        let radians = CGFloat(-45.0 * Double.pi / 180.0)
        let transform = CGAffineTransform(rotationAngle: radians)
        label.transform = transform

        // Set the leading as height and trailing as width
        let leading = label.frame.height
        let trailing = label.frame.width
        label.frame = CGRect(x: label.frame.minX, y: label.frame.minY, width: trailing, height: leading)

        // Add the label to a view
        self.view.addSubview(label)
    }
    override func viewWillDisappear(_ animated: Bool) {
        sessionQueue.async { [unowned self] in
            if self.setupResult == .success {
                self.session.stopRunning()
            }
        }
        
        super.viewWillDisappear(animated)
    }
    
    
    @IBAction func torch(_ sender: UIButton) {
        toggleTorch()
    }
    @IBAction func clickAction(_ sender: UIButton) {
        DispatchQueue.global(qos: .background).async {
            
        }
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
    
    
    
    
    @IBAction func uploadAction(_ sender: UIButton) {
        toggleTorch()
        //        DispatchQueue.global(qos: .background).async {
        
        //        DispatchQueue.main.async {
        uploadscanedimage()
        //        }
    }
    //        if let img: CVPixelBuffer = self.previewView.session.currentFrame?.capturedImage {
    //            let ciimg = CIImage(cvImageBuffer: img)
    //            var myimg = (UIImage(ciImage: ciimg ))
    //        }
    //
    //        }
    
    
    // }
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
    func flashActive() {
        if let currentDevice = AVCaptureDevice.default(for: AVMediaType.video), currentDevice.hasTorch {
            do {
                try currentDevice.lockForConfiguration()
                let torchOn = !currentDevice.isTorchActive
                try currentDevice.setTorchModeOn(level:1.0)//Or whatever you want
                currentDevice.torchMode = torchOn ? .on : .off
                currentDevice.unlockForConfiguration()
            } catch {
                print("error")
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
}
extension ScanTestVC: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print("Error capturing photo: \(error)")
        } else {
            if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
                
                if let image = UIImage(data: dataImage) {
                    //                    self.capturedImage.image = image
                    if let data = image.jpegData(compressionQuality: 1) {
                        let base64 = data.base64EncodedString(options: .lineLength64Characters)
                        // testingvar.append(base64)
                        //scanedDataimgarr.append(base64)
                        // teethimage = base64
                        image64.append(base64)
                    }
                }
            }
        }
        
    }
    
    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let data = photo.fileDataRepresentation(),
              let image =  UIImage(data: data)
                
                
        else {
            return
        }
        imagear.append(image)
        //  if let image = UIImage(data: image) {
        //                    self.capturedImage.image = image
        if let data = image.jpegData(compressionQuality: 1) {
            let base64 = data.base64EncodedString(options: .lineLength64Characters)
            // testingvar.append(base64)
            //scanedDataimgarr.append(base64)
            // teethimage = base64
            image64.append(base64)
        }
    }
    
    
    //self.capturedImage.image = image
}

extension ScanTestVC {
    func uploadscanedimage() {
        
        
        
        
        let parameters = [
            
            "userId" : "63f73807bcbef437789ddf67",
            "doctorId" : "63e4c47c04e38fdd944f3176",
            "doctorName":"agsuydgaishgud",
            "faceScanImages" :"",
            "teethScanImages": [image64]
        ] as [String : Any]
        let header = ["Authorization":UserDefaults.standard.string(forKey: "access_token")!,"lang":"en"]
        
        
        KVSpinnerView.show(saying: "Please wait while your scan is getting submitted which takes approx. 10 - 30 seconds")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/scans/submitscans", methodeType: .post,parameter: parameters,headerType: header) { (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                BannerNotification.failureBanner(message: "No network Connection")
                print("network error")
                
                
            case .success :
                KVSpinnerView.dismiss()
                print("success")
                //      print(response["data"]!)
                if let data = response["data"] as? Json{
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
                        
                    }
                    else {
                        // self.uploadmodel = submitscanmodel(fromData: data)
                        
                        BannerNotification.successBanner(message: "\(response["message"]!)")
                        
                        
                    }
                }
                
                
            case .failure :
                print("failure")
                
                KVSpinnerView.dismiss()
                BannerNotification.failureBanner(message: "\(response["message"]!)")
            case .unknown:
                print("unknown")
                KVSpinnerView.dismiss()
                if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
                }else {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
                    
                    
                }
            }
            
        }    }
    
}

