//
//  SoundMachine.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import Foundation
import AudioKit
import AVFoundation

class SoundMachine {
    
    let engine = AudioEngine()
    var player: AudioPlayer!
    let mixer = Mixer()
    
    init() {
        
        let demo = AudioSource("Sounds/OS_ORG_Field_Atmos_Coffee_House.wav")
//        let demo = AudioSource("Sounds/BRS_Activity_Bartender_The_Boat_Clean_Up_Bg_Crowd.wav")
//        let demo = AudioSource("Sounds/LZ_vocal_group_prismizer_chords_120_C.wav")
        
        let buffer = demo.sourceBuffer
        player = AudioPlayer()
        player.buffer = buffer
        player.isLooping = true
        
        mixer.addInput(player)
        engine.output = mixer
        
        do {
            try engine.start()
        } catch {
            Log("AudioKit did not start! \(error)")
        }
        
        player.play()
        
        
    }

}

struct AudioSource {
    var audioFile: AVAudioFile?
    var sourceBuffer: AVAudioPCMBuffer?
    init(_ file: String) {
        guard let url = Bundle.main.resourceURL?.appendingPathComponent(file) else { return }
        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            Log("Could not load: \(file)")
        }
        do {
            sourceBuffer = try AVAudioPCMBuffer(file: audioFile!)
        } catch {
            Log("Could not buffer: \(file)")
        }
    }
}
