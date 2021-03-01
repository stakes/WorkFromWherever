//
//  SoundManager.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import Foundation
import AudioKit
import AVFoundation

class SoundManager {
    let engine = AVAudioEngine()
    let mixer = AVAudioMixerNode()
    
    init() {
        engine.attach(mixer)
        engine.connect(mixer, to: engine.outputNode, format: nil)
        do {
            try engine.start()
        } catch {
            Log("Engine didn't start: \(error)")
        }
//        engine.mainMixerNode.installTap(onBus: 0, bufferSize: 1024, format: nil) { (buffer, time) in
//            self.processAudioData(buffer: buffer)
//        }
    }
    
    func addTrack(_ track:Track) {
        engine.attach(track.player)
        engine.connect(track.player, to: mixer, format: nil)
        track.play()
    }
    
//    func processAudioData(buffer: AVAudioPCMBuffer){
//        guard let channelData = buffer.floatChannelData?[0] else {return}
//        let frames = buffer.frameLength
//        print(frames)
//    }
}
