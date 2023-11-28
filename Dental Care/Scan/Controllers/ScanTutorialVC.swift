//
//  ScanTutorialVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 27/10/2022.
//

import UIKit
import AVFoundation
import AVKit

class ScanTutorialVC: UIViewController {
    var scanType:scanType?
    var onlyteethscan:Bool?
    var avpController = AVPlayerViewController()
    @IBOutlet weak var videoview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
      // playVideo()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func playVideo() {

        guard let path = Bundle.main.path(forResource: "RPReplay_Final1660553592 2", ofType:"mov") else {
            debugPrint("video.mov not found")
            return
       // let url = URL(string:myURL)
        }
       let player = AVPlayer(url: URL(fileURLWithPath: path))

        avpController.player = player
        avpController.showsPlaybackControls = false
        
        avpController.view.frame.size.height = videoview.frame.size.height

        avpController.view.frame.size.width = videoview.frame.size.width

        self.videoview.addSubview(avpController.view)
        


    }
    @IBAction func startScanButtonAction(_ sender: UIButton) {
      
            let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanVC") as! ScanVC
              vc.scantype = scanType
            vc.onlyTeethScan = onlyteethscan
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(vc, animated: false)
            
      
        
    }}
