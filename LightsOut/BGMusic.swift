    //
    //  BGMusic.swift
    //  LightsOut
    //
    //  Created by Arthur Ford on 1/29/22.
    //

import AVFoundation
import Foundation

class BGMusic {
    static let shared = BGMusic()
    var audioPlayer: AVAudioPlayer?
    
    func startBGMusic() {
        if let bundle = Bundle.main.path(forResource: "bgaudio", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func stopBGMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}
