//
//  ScanExtension.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 27/10/2022.
//

import Foundation
import ARKit
import AVKit



extension ScanVC:ARSCNViewDelegate {
    func playVideo() {

            guard let path = Bundle.main.path(forResource: "RPReplay_Final1660553592 2", ofType:"mov") else {
                debugPrint("video.mov not found")
                return
           // let url = URL(string:myURL)
            }
           let player = AVPlayer(url: URL(fileURLWithPath: path))

            avpController.player = player
            avpController.showsPlaybackControls = false
            
            avpController.view.frame.size.height = videoView.frame.size.height

            avpController.view.frame.size.width = videoView.frame.size.width

            self.videoView.addSubview(avpController.view)
            


        }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
      
        guard #available(iOS 12.0, *), let faceAnchor = anchor as? ARFaceAnchor
                
        else { return }
        
        let configuration = ARFaceTrackingConfiguration()
        let leftSmileValue = faceAnchor.blendShapes[.mouthSmileLeft] as! CGFloat
        let rightSmileValue = faceAnchor.blendShapes[.mouthSmileRight] as! CGFloat
        
        
        // 3
        print(leftSmileValue, rightSmileValue)
        
        
        if scantype == .faceScanAlone {
            print("X = \(faceAnchor.lookAtPoint.x), Y = \(faceAnchor.lookAtPoint.y), Z = \(faceAnchor.lookAtPoint.z)")
            let point = faceAnchor.lookAtPoint.asPoint3D

//            let leftSmileValue = faceAnchor.blendShapes[.mouthSmileLeft] as! CGFloat
//            let rightSmileValue = faceAnchor.blendShapes[.mouthSmileRight] as! CGFloat
//            print("x = \(leftSmileValue), y = \(rightSmileValue)")
            
            if currentfacestate.zisValid(point) {
                if startscaning == false {
                    DispatchQueue.main.async { [unowned self] in
                        scanView?.isHidden = false
                        scanButton?.isHidden = false
                       distanceViewHeight.constant = 0
                        distanceInstructionLabel.isHidden = true
//                        distanceInstructionLabel.text = "Start Scan"
//                        distanceInstructionLabel.textColor = UIColor.white
//                        distanceInstructionLabel.isHidden = false
//                        distanceInstructionView.backgroundColor = UIColor(hexFromString: "#A9C23F")
                        
                    }
                }
             else if startscaning == true {
                    
                    if currentfacestate.isValid(point) {
                        if currentfacestate == .completed {
                            DispatchQueue.main.async {
                                self.distanceViewHeight.constant = 0
                                self.distanceInstructionLabel.isHidden = true
                            }
                       }
                            //else
//                            if currentfacestate ==  .middle {
//                                DispatchQueue.main.async {
//                                    self.distanceViewHeight.constant = 50
//                                    self.distanceInstructionLabel.isHidden = false
//                                }
//
//                            }
                        
                            else {
                                DispatchQueue.main.async {
                                
                                self.distanceViewHeight.constant = 0
                                self.distanceInstructionLabel.isHidden = true
                                  
                            }
                            
                            
                            
                            
                        }
                        
                        
//                        if currentfacestate == .middle {
//                            currentfacestate = nextState
//
//                        } else {
                            
                            
                            DispatchQueue.main.async { [unowned self] in
                                
                                progresss += 1/4
                                progressView.progress = CGFloat(progresss)
                                scantimer =  Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] (timer) in
                                    scantimercount += 1
                                    if scantimercount ==  3 {
                                        captureimg()
                                        doneView?.isHidden = false
                                        scantimercount = 0
                                        logoView.isHidden = false
                                        scanInfoLabel?.isHidden = true
                                        scantimer.invalidate()
                                        MP3Player.shared.playLocalFile(name: "its-Done")
                                      
                                    }
                                    
                                }
//                                if let img: CVPixelBuffer = self.cameraView.session.currentFrame?.capturedImage {
//
//                                    let ciimg = CIImage(cvImageBuffer: img)
//
//                                    self.faceimgarr.append(UIImage(ciImage: ciimg ))
//
//                                }
                            }
                            DispatchQueue.main.async { [unowned self] in
                                
                                currentfacestate = nextState
                              
//                                distanceViewHeight.constant = 0
//                                distanceInstructionLabel.text = "agwiudhqwouadhqu"
                              
                               // distanceInstructionView.isHidden = true
                             //
//                                if currentfacestate == .completed {
//                                    distanceViewHeight.constant = 0
//                                }
                                
                                
                            }
                            
                            
                 //       }
                        
                    }
                }
                
                
            }
            else {
                if startscaning  == true {
                    DispatchQueue.main.async { [unowned self] in
                        if currentfacestate == .completed {
                            scanView?.isHidden = false
                            scanButton?.isHidden = false
                        }else {
                            scanView?.isHidden = false
                            scanButton?.isHidden = true
                        }
                    }
                }
                else {
                    DispatchQueue.main.async { [unowned self] in
                       scanView?.isHidden = true
                       scanButton?.isHidden = true
                                            }
                }
            }
        }
        
        else if scantype == .smiledface {
            let leftSmileValue = faceAnchor.blendShapes[.mouthSmileLeft] as! CGFloat
            let rightSmileValue = faceAnchor.blendShapes[.mouthSmileRight] as! CGFloat
            print(leftSmileValue, rightSmileValue)
            if currentsmilestate == .straight {
            let smileValue = (leftSmileValue + rightSmileValue)/2.0
            if smileValue > 0.7 {
               
                if currentsmilestate == .straight {
                    self.currentsmilestate = self.nextsmilestate
                    DispatchQueue.main.async {
                        self.scanButton?.isHidden = false
                        self.captureimg()
                    }
                    
                }
            }else if smileValue < 0.5 {
                DispatchQueue.main.async {
                    self.scanInfoLabel.text = "please smile with showing teeth"
                }
            }
            }
        }else if scantype == .teethScan {
            DispatchQueue.main.async {
                print(" Focal Length: \(self.cameraView.pointOfView?.camera?.focalLength)")
                print("Sensor Height: \(self.cameraView.pointOfView?.camera?.sensorHeight)")
            }
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor)  {
        guard #available(iOS 12.0, *), let faceAnchor = anchor as? ARFaceAnchor
                
        else { return }
        
        if scantype == .faceScanAlone {
            
           // if startscaning == false {
                if    faceAnchor.lookAtPoint.y >= currentfacestate.maximumRangeY || faceAnchor.lookAtPoint.z >= currentfacestate.maximumRangez  {
                   
                        if  currentfacestate == .right {
                            DispatchQueue.main.async { [unowned self] in
                            distanceViewHeight.constant = 0
                            distanceInstructionLabel.text = currentfacestate.maximumCommand
                            distanceInstructionLabel.textColor = UIColor.red
                            distanceInstructionView.backgroundColor = UIColor.clear    //UIColor(hexFromString: "#D0174E")
                            distanceInstructionLabel.isHidden = true
                        }
                    }
                    
                    else {
                        DispatchQueue.main.async { [ self] in
                            distanceViewHeight.constant = 50
                            distanceInstructionLabel.text = currentfacestate.maximumCommand
                            distanceInstructionLabel.textColor = UIColor.red
                            distanceInstructionView.backgroundColor = UIColor.clear    //UIColor(hexFromString: "#D0174E")
                            distanceInstructionLabel.isHidden = false
                        }
                    }
                }
                else
                if faceAnchor.lookAtPoint.z <= currentfacestate.minimumRangez ||  faceAnchor.lookAtPoint.z >= currentfacestate.maximumRangeY {
                    if  currentfacestate == .right {
                        DispatchQueue.main.async { [unowned self] in
                            //                instructionView.isHidden = false
                            distanceViewHeight.constant = 0
                            distanceInstructionLabel.text = currentfacestate.minimumCommand
                            distanceInstructionLabel.textColor = UIColor.red
                            distanceInstructionView.backgroundColor = UIColor.clear      //UIColor(hexFromString: "#D0174E")
                            distanceInstructionLabel.isHidden = true
                        }
                    }
                    else {
                        DispatchQueue.main.async { [unowned self] in
                            //                instructionView.isHidden = false
                            distanceViewHeight.constant = 50
                            distanceInstructionLabel.text = currentfacestate.minimumCommand
                            distanceInstructionLabel.textColor = UIColor.red
                            distanceInstructionView.backgroundColor = UIColor.clear      //UIColor(hexFromString: "#D0174E")
                            distanceInstructionLabel.isHidden = false
                        }
                    }
                    
                }
                else  {
                    
                    DispatchQueue.main.async { [unowned self] in
                        //                    distanceInstructionLabel.text = "Start Scan"
                        //                    distanceInstructionLabel.textColor = UIColor.white
                        //                    distanceInstructionView.backgroundColor = UIColor(hexFromString: "#A9C23F")
                        
                        //                    distanceViewHeight.constant = 0
                        //                    distanceInstructionLabel.isHidden = true
                        
                        
                        
                    }
                    
                }
          //  }
        }else if scantype == .teethScan {
            DispatchQueue.main.async {
                print(" Focal Length: \(self.cameraView.pointOfView?.camera?.focalLength)")
                print("Sensor Height: \(self.cameraView.pointOfView?.camera?.sensorHeight)")
            }
        }
        
    }

    func  updateUIforTeethScaningstate() {
        if isfromreview == true {
            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                scanInfoLabel?.text = "Perfect, its done. You can remove the scope from your mouth & phone now"
            } else {
                scanInfoLabel?.text = "ممتاز ، تم القيام به. يمكنك إزالة النطاق من فمك وهاتفك الآن"
            }
            isfromreview = false
            iscompletedback = true
        }else {
            if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                scanInfoLabel?.text = currentTeethState.instructiontext
            }
            else {
                scanInfoLabel?.text = currentTeethState.arabicinstructiontext
            }
        }
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            MP3Player.shared.playLocalFile(name: currentTeethState.stateAudioCommands)
            toggleTorch(on: true)
        }else {
            MP3Player.shared.playLocalFile(name: currentTeethState.statearAudioCommands)
            toggleTorch(on: true)
        }
        if currentTeethState == .straight {
            //         if isteethreload == false {
            // if scananimation == false {
            
            if isteethreload == false {
                let layer = createScannerGradientLayer(for: ScanerView!)
                ScanerView!.layer.insertSublayer(layer, at: 0)
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
            else {
                scanControlLabel?.text = "ابدأ المسح"
                doneView?.isHidden = false
                logoView.isHidden = false
            }
        }
        else if currentTeethState == .completed {
            doneView?.isHidden = false
            logoView?.isHidden = false
            retakeview?.isHidden = false
            viewScanview?.isHidden = false
            scanViewButtton?.isHidden = false
            RetakeButton?.isHidden = false
            ScanerView?.isHidden = true
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
            toggleTorch(on: false)
            
            scanView?.backgroundColor = UIColor.systemGreen
            scanButton?.isHidden = false
        }else if  currentTeethState == .middle {
            teethtimer.invalidate()
            teethclicktimer.invalidate()
            teethtimercount = 0
            teethclicktimercount = 0
            toggleTorch(on: true)
            
            scanView?.backgroundColor = UIColor.systemGreen
            scanButton?.isHidden = false
        }
        
    }
    
    func retake() {
        if scantype == .faceScanAlone {
            
            faceimgarr.removeAll()
            facescan64.removeAll()
            startscaning = false
            distanceViewHeight.constant = 60
            currentfacestate = .straight
            maskView.isHidden = true
            scanControlLabel?.text = "Start Scan"
            retakeview?.isHidden = true
            viewScanview?.isHidden = true
            scanViewButtton?.isHidden = true
            RetakeButton?.isHidden = true
            distanceInstructionLabel.isHidden = false
            faceScanIndicationimg.tintColor = UIColor(hexFromString: "20507B")
            progresss = 0
            progressView.progress = CGFloat(progresss)
            
        }
        if scantype == .faceScanHelp {
            faceimgarr.removeAll()
            facescan64.removeAll()
            currentfacehelpState = .straight
            scanControlLabel?.text = "Scan"
            maskView.isHidden = true
            retakeview?.isHidden = true
            viewScanview?.isHidden = true
            scanViewButtton?.isHidden = true
            RetakeButton?.isHidden = true
            faceScanIndicationimg.tintColor = UIColor(hexFromString: "20507B")
            progresss = 0
            progressView.progress = CGFloat(progresss)
            
            
           
            
        }
        if scantype == .teethScan {
            resetTracking()
            maskView.isHidden = true
            isteethreload = true
            teethScanArray.removeAll()
            teethscan64.removeAll()
            currentTeethState = .straight
            progresss = 0
            progressView.progress = CGFloat(progresss)
            scanControlLabel?.text = "Start Scan"
            ScanerView?.isHidden = true
            viewScanview?.isHidden = true
            scanViewButtton?.isHidden = true
            scananimation = true
            RetakeButton?.isHidden = true
            retakeview?.isHidden = true
            if fromreload == true {
                isteethreload = false
            }
//            let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "RetakeVC") as! RetakeVC
//            vc.retakeimagear = teethimage
//            
//            navigationController?.navigationBar.isHidden = true
//            navigationController?.pushViewController(vc, animated: true)
          
            
            
        }
        else if scantype == .smiledface {
            scantype = .faceScanAlone
            faceimgarr.removeAll()
            facescan64.removeAll()
            startscaning = false
            distanceViewHeight.constant = 60
            currentfacestate = .straight
            maskView.isHidden = true
            scanControlLabel?.text = "Start Scan"
            retakeview?.isHidden = true
            viewScanview?.isHidden = true
            scanViewButtton?.isHidden = true
            RetakeButton?.isHidden = true
            distanceInstructionLabel.isHidden = false
            faceScanIndicationimg.tintColor = UIColor(hexFromString: "20507B")
            progresss = 0
            progressView.progress = CGFloat(progresss)
        }
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video)
        else {return}
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    func createScannerGradientLayer(for view: UIView) -> CAGradientLayer {
       
        let height = ScanerView!.frame.height // + 10
        
        let opacity: Float = 0.5
        let width = 5  //view.frame.width
        let topColor = {UIColor.red}
        let bottomColor = topColor()
        
        let layer = CAGradientLayer()
        layer.colors = [topColor().cgColor, bottomColor.cgColor]
        layer.opacity = opacity
        layer.frame = CGRect(x: 0, y: 0, width: width, height: Int(height)) //Int(height))
        return layer
        
    }
    
    func createAnimation(for layer: CAGradientLayer) -> CABasicAnimation {
        guard let superLayer = layer.superlayer else {
            fatalError("Unable to create animation, layer should have superlayer")
        }
        let superLayerWidth = ScanerView!.frame.width
        let layerWidth = layer.frame.width
        let value = superLayerWidth - layerWidth
        
        let initialYPosition = layer.position.x
        let finalYPosition = initialYPosition + value
        let duration: CFTimeInterval = 2
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = initialYPosition as NSNumber
        animation.toValue = finalYPosition as NSNumber
        animation.duration = duration
        animation.repeatCount = .infinity
        return animation
    }
    func updateUIForFaceScanHelpScaningState() {
        distanceViewHeight.constant = 0
        distanceInstructionLabel.isHidden = true
        videoView.isHidden = true
        cameraView.session.run(cameraView.session.configuration!)
        facescanhelptimer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] (facescanhelptimer) in
           
            facescanhelptimercount += 1
            if facescanhelptimercount == 3 {
                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    if currentfacehelpState == . completed {
                        if onlyfacescan == true {
                            scanInfoLabel.text = "please review the scan and submit it to doctor"
                            MP3Player.shared.playLocalFile(name: "facealonecompleted")
                        }else {
                            MP3Player.shared.playLocalFile(name: currentfacehelpState.audiocommands)
                            scanInfoLabel?.text = currentfacehelpState.instructiontext
                        }

                    }else {
                        MP3Player.shared.playLocalFile(name: currentfacehelpState.audiocommands)
                        scanInfoLabel?.text = currentfacehelpState.instructiontext
                    }
                }else {
                    MP3Player.shared.playLocalFile(name: currentfacehelpState.arabicaudiocommands)
                    scanInfoLabel?.text = currentfacehelpState.arabicfaceinstructionwithhelp
                }
       
        doneView?.isHidden = true
                logoView.isHidden = true
                facescanhelptimer.invalidate()
                facescanhelptimercount = 0
        }
        }
        if currentfacehelpState == .completed {
            if onlyfacescan == true {
               
               
                retakeview?.isHidden = false
                viewScanview?.isHidden = false
                scanViewButtton?.isHidden = false
                RetakeButton?.isHidden = false
                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    scanControlLabel?.text = "Review Scan"
                }else {
                    scanControlLabel?.text = "مراجعة الفحص"
                }
            }else {
                
                retakeview?.isHidden = false
                viewScanview?.isHidden = false
                scanViewButtton?.isHidden = false
                RetakeButton?.isHidden = false
                if DCLanguageManager.sharedInstance.getLanguage() == "en" {
                    scanControlLabel?.text = "Start Teeth Scan"
                }else {
                    scanControlLabel?.text = "بدء فحص الأسنان"
                }
                
            }

        }
    }

    


    func scheduledTimerWithTimeInterval(){
        
        teethtimer =  Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [self] (timer) in
            
            teethtimercount += 1
            toggleTorch(on: true)
            scanView?.isHidden = false
            
            if teethtimercount == currentTeethState.timercount {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    timer.invalidate()
                    teethclicktimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [self] (clicktimer) in
                        teethclicktimercount += 2
                        
                        
                        
                                             progressView.progress = CGFloat(progresss)
                        
                        
                        
                        
                        
                        if teethclicktimercount == 6 {
                            //                            if currentState == .left {
                            //                                captureimg()
                            //
                            //                            }
                          //  MP3Player.shared.playLocalFile(name: "click")
                            //scannerView.isHidden = fale
                           
                            captureimg()
                            doneView?.isHidden = true
                            logoView.isHidden = true
                            teethclicktimer.invalidate()
                            teethclicktimercount = 0
                            currentTeethState = nextTeethScaningState
                            teethtimer.invalidate()
//                             progresss += 1/2
//                            progressspercent = Int(progresss * 100)
                            scanView?.isHidden = false
                            teethtimercount = 0
                            scheduledTimerWithTimeInterval()
                            if currentTeethState == .openup || currentTeethState == .opendown || currentTeethState == .completed {
                                                                progresss += 1/2
//progressspercent = Int(progresss * 100)
                                                                progressView.progress = CGFloat(progresss)
                                
                                // progressPercent.text = "\(progressspercent)%"
                            } else {
                                                                progresss += 1/3
                                                           //     progressspercent = Int(progresss * 100)
                                                                progressView.progress = CGFloat(progresss)
                                
                                  //progressPercent.text = "\(progressspercent)%"
                            }
                            
                        }
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                }
            }
        }
    }
    func captureimg() {
        if scantype == .teethScan {
        DispatchQueue.main.async { [unowned self] in
            // scheduletimer.invalidate()
            if let img: CVPixelBuffer = self.cameraView.session.currentFrame?.capturedImage {
                // scheduletimer.invalidate()
                
                let ciimg = CIImage(cvImageBuffer: img)
                var myimg = (UIImage(ciImage: ciimg ))
              //  let rotatedImage = myimg.rotate(radians: .pi)

                
                if let data = myimg.jpegData(compressionQuality: 1) {
                    let base64 = data.base64EncodedString(options: .lineLength64Characters)
                   // testingvar.append(base64)
                    //scanedDataimgarr.append(base64)
                    teethimage = base64
                    teethscan64.append(base64)
                }
                
                self.teethScanArray.append(UIImage(ciImage: ciimg ))
        
            }
        }
        
    }
        else {
            DispatchQueue.main.async { [unowned self] in
                // scheduletimer.invalidate()
                if let img: CVPixelBuffer = self.cameraView.session.currentFrame?.capturedImage {
                    // scheduletimer.invalidate()
                    
                    let ciimg = CIImage(cvImageBuffer: img)
                    var myimg = (UIImage(ciImage: ciimg ))
                    let rotatedImage = myimg.rotate(radians: .pi/2)
                    if let data = rotatedImage.jpegData(compressionQuality: 1) {
                        let base64 = data.base64EncodedString(options: .lineLength64Characters)
                        //scanedDataimgarr.append(base64)
                        facescan64.append(base64)
                        // testingvar.append(base64)
                        // print(base64)
                        
                    }
                    
                    self.faceimgarr.append(UIImage(ciImage: ciimg ))
                }
                    if scantype == .smiledface {
                        progresss += 1/4
                        progressView.progress = CGFloat(progresss)
                        //currentsmilestate = nextsmilestate
//                        if onlyfacescan == false {
//                            progresss += 1/4
//                            progressView.progress = CGFloat(progresss)
//                        }
                    }
                }
            }
            
        }
    }
   
//}
