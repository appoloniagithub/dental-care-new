//
//  VideoCallVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 20/06/2023.
//

import UIKit
import WKWebViewRTC
import WebRTC
import WebKit
import SocketIO

class VideoCallVC: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var webRTCManager: WebRTCManager!
    var roomid:String?
   
    @IBOutlet weak var backbutton: UIButton!
    var socket: SocketIOClient? = nil
    
    @IBOutlet weak var backicon: UIImageView!
    @IBOutlet weak var videocallView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupWebView()
        webView.navigationDelegate = self
        //requestMediaDeviceAccess()
       let managers = SocketManager(socketURL: URL(string: "https://appolonia-rtc-d4683cd32c2c.herokuapp.com/chat")!, config: [.log(false), .compress])
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        { [self] in
            socket = managers.defaultSocket
            socket?.connect()
            //socket?.emit("connection",roomid ?? "")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){ [self] in
            let roomconnection = ["room":roomid]
            self.socket?.emit("create or join",roomconnection)
        }
       
    }
    override func viewDidAppear(_ animated: Bool) {
        socket?.on("message") {
            (dataarray, socketAck) in
            
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Get the current URL after the web view finishes loading
        if let currentURL = webView.url {
            print("Current URL: \(currentURL)")
              let url = currentURL.absoluteString
                let callvariable = url.suffix(4)
                if callvariable == "call" {
                   navigationController?.popViewController(animated: false)
                
            }
        }
    }
    
    @IBAction func backbutton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func cutthecall() {
        socket?.on("bye") {(dataarray, socketAck) in 
            
        }
    }
  
    func setupWebView() {
        let webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.allowsInlineMediaPlayback = true
        webViewConfiguration.mediaTypesRequiringUserActionForPlayback = []


        let userContentController = WKUserContentController()
        webViewConfiguration.userContentController = userContentController
//        if let webViewContainer = videocallView {
//
//                    // Initialize:
//                    let webView = WKWebView(frame: webViewContainer.bounds, configuration: WKWebViewConfiguration()) // Create a new web view
//                    webView.translatesAutoresizingMaskIntoConstraints = false // This needs to be called due to manually adding constraints
//
//                    // Add as a subview:
//                    webViewContainer.addSubview(webView)
//
//                    // Add constraints to be the same as webViewContainer
//            webViewContainer.addConstraint(NSLayoutConstraint(item: webView, attribute: .leading, relatedBy: .equal, toItem: webViewContainer, attribute: .leading, multiplier: 1.0, constant: 5.0))
//                    webViewContainer.addConstraint(NSLayoutConstraint(item: webView, attribute: .trailing, relatedBy: .equal, toItem: webViewContainer, attribute: .trailing, multiplier: 1.0, constant: 0.0))
//                    webViewContainer.addConstraint(NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: webViewContainer, attribute: .top, multiplier: 1.0, constant: 0.0))
//                    webViewContainer.addConstraint(NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: webViewContainer, attribute: .bottom, multiplier: 1.0, constant: 0.0))
//
//                    // Assign web view for reference
//                    self.webView = webView
//                }
            

        webView = WKWebView(frame: videocallView.bounds, configuration: webViewConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubview(webView)
        view.bringSubviewToFront(backbutton)
        view.bringSubviewToFront(backicon)

        let urlStr = "https://appolonia-rtc-d4683cd32c2c.herokuapp.com/chat?roomId=\(roomid ?? "")"
        let trimmedUrl = urlStr.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: trimmedUrl) // Replace with your actual URL
        
        let request = URLRequest(url: url!)
        webView.load(request)

        webRTCManager = WebRTCManager(webView: webView)
    }
//    func requestMediaDeviceAccess() {
//           let script = """
//           navigator.mediaDevices.getUserMedia({ video: true, audio: true })
//             .then(function(stream) {
//               console.log('Media device access granted');
//             })
//             .catch(function(error) {
//               console.log('Media device access denied:', error);
//             });
//           """
//
//           webView.evaluateJavaScript(script, completionHandler: { (result, error) in
//               if let error = error {
//                   print("Error requesting media device access:", error.localizedDescription)
//               } else {
//                   print("Media device access requested successfully")
//               }
//           })
//       }
}
class WebRTCManager: NSObject {
    var webView: WKWebView!
    var rtcEngine: RTCPeerConnectionFactory!

    init(webView: WKWebView) {
        super.init()
        self.webView = webView
        self.setupRTC()
    }

    func setupRTC() {
        let rtcConfig = RTCConfiguration()
        rtcConfig.iceServers = [RTCIceServer(urlStrings: ["stun:13.48.124.194:3478"])]

        rtcEngine = RTCPeerConnectionFactory()
        let rtcDelegate = RTCWebViewDelegate(webView: webView)
        rtcDelegate.configureRTC(factory: rtcEngine, configuration: rtcConfig)
    }
}

class RTCWebViewDelegate: NSObject, WKScriptMessageHandler {
    private var factory: RTCPeerConnectionFactory?
    private var configuration: RTCConfiguration?
    private weak var webView: WKWebView?

    init(webView: WKWebView) {
        super.init()
        self.webView = webView
        webView.configuration.userContentController.add(self, name: "webrtc")
    }

    func configureRTC(factory: RTCPeerConnectionFactory, configuration: RTCConfiguration) {
        self.factory = factory
        self.configuration = configuration
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "webrtc", let rtcConfig = configuration {
            // Handle WebRTC signaling messages here
        }
    }
}
