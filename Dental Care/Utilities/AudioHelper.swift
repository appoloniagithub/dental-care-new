//
//  AudioHelper.swift
//  Appolonia
//
//  Created by Sanju Mohamed Sageer on 24/08/2022.
//

import Foundation
import Foundation
import AVFoundation
import AudioToolbox

public final class MP3Player : NSObject {
    static let shared:MP3Player = MP3Player()
    static var player: AVAudioPlayer? = nil
    
    public func playLocalFile(name:String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            MP3Player.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = MP3Player.player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

