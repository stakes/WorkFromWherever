//
//  SoundManager.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import Foundation
import AVFoundation

class SoundManager: ObservableObject {
    let engine = AVAudioEngine()
    let mixer = AVAudioMixerNode()
    var tracks:[Track] = []
    
    init() {
        engine.attach(mixer)
        engine.connect(mixer, to: engine.outputNode, format: nil)
        do {
            try engine.start()
        } catch {
            print("Engine didn't start: \(error)")
        }
//        engine.mainMixerNode.installTap(onBus: 0, bufferSize: 1024, format: nil) { (buffer, time) in
//            self.processAudioData(buffer: buffer)
//        }
    }
    
    func addTrack(_ track:Track) {
        let i = tracks.first { $0.sound.id == track.sound.id }
        if (i == nil) {
            engine.attach(track.player)
            engine.connect(track.player, to: mixer, format: nil)
            tracks.append(track)
            track.play()
        }
    }
    
    func removeTrack(_ track:Track) {
        engine.detach(track.player)
    }
    
    func removeAllTracks() {
        tracks.forEach { track in
            engine.detach(track.player)
        }
        tracks = []
    }
    
    func isTrackForSoundPlaying(_ sound: Sound) -> Bool {
        tracks.forEach { track in
            print(track)
        }
        return false
    }
    
//    func processAudioData(buffer: AVAudioPCMBuffer){
//        guard let channelData = buffer.floatChannelData?[0] else {return}
//        let frames = buffer.frameLength
//        print(frames)
//    }
}
