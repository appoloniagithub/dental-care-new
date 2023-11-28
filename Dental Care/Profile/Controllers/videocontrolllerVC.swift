//
//  videocontrolllerVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 17/05/2023.
//
//
//import UIKit
//import WebRTC
//class videocontrolllerVC: UIViewController, RTCPeerConnectionDelegate {
//   
//    
//
//    
////    @IBOutlet weak var localView: UIView!
////    @IBOutlet weak var remoteView: UIView!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      
//    }
//   
//    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
//        <#code#>
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
//        <#code#>
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
//        <#code#>
//    }
//    
//    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
//        <#code#>
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
//        <#code#>
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
//        <#code#>
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
//        <#code#>
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
//        <#code#>
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
//        <#code#>
//    }
//}
//import WebRTC
//
//class VideoCallViewController: UIViewController, RTCPeerConnectionDelegate {
//    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
//        <#code#>
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
//        <#code#>
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
//        <#code#>
//    }
//    
//    // Create local variables
//    var peerConnectionFactory: RTCPeerConnectionFactory!
//    var localVideoTrack: RTCVideoTrack!
//    var remoteVideoTrack: RTCVideoTrack!
//    var peerConnection: RTCPeerConnection!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Initialize WebRTC
//        let factoryOptions = RTCPeerConnectionFactoryOptions()
//        peerConnectionFactory = RTCPeerConnectionFactory(options: factoryOptions)
//        
//        // Configure and start local media capture
//        let videoSource = peerConnectionFactory.videoSource()
//        let videoTrack = peerConnectionFactory.videoTrack(with: videoSource, trackId: "video")
//        let capturer = RTCCameraVideoCapturer(delegate: videoSource)
//        
//        // Add local video renderer
//        let localRenderer = RTCMTLVideoView(frame: self.view.frame)
//        localRenderer.videoContentMode = .scaleAspectFill
//        view.addSubview(localRenderer)
//        videoTrack.add(localRenderer)
//        
//        // Create peer connection
//        let rtcConfig = RTCConfiguration()
//        peerConnection = peerConnectionFactory.peerConnection(with: rtcConfig, constraints: RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil), delegate: self)
//        
//        // Add local video track to peer connection
//        peerConnection.add(videoTrack, streamIds: ["stream"])
//        
//        // Create offer and set local description
//        peerConnection.offer(for: RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil), completionHandler: { (sessionDescription, error) in
//            if let error = error {
//                print("Error creating offer: \(error.localizedDescription)")
//                return
//            }
//            
//            self.peerConnection.setLocalDescription(sessionDescription, completionHandler: { (error) in
//                if let error = error {
//                    print("Error setting local description: \(error.localizedDescription)")
//                    return
//                }
//                
//                // Send the offer to the remote peer
//                self.sendOfferToRemotePeer(sessionDescription!)
//            })
//        })
//    }
//    
//    // Implement RTCPeerConnectionDelegate methods
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
//        // Send the ICE candidate to the remote peer
//        sendIceCandidateToRemotePeer(candidate)
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
//        // Handle signaling state changes
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
//        // Handle remote stream
//        remoteVideoTrack = stream.videoTracks.first
//        let remoteRenderer = RTCMTLVideoView(frame: self.view.frame)
//        remoteRenderer.videoContentMode = .scaleAspectFill
//        view.addSubview(remoteRenderer)
//        remoteVideoTrack.add(remoteRenderer)
//    }
//    
//    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
//        // Handle remote stream removal
//        remoteVideoTrack = nil
//    }
//    
//    // Helper methods for signaling
//    
//    func sendOfferToRemotePeer(_ offer: RTCSessionDescription) {
//        // Send the offer to the remote peer (e.g., via signaling server)
//    }
//    
//    func sendIceCandidateToRemotePeer(_ candidate: RTCIceCandidate) {
//        // Send the ICE candidate to the remote peer (e.g., via signaling server)
//    }
//}
