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
    let mixer = Mixer()
    
    let soundStub = [
        "Sounds/OS_ORG_Field_Atmos_Coffee_House.wav",
        "Sounds/BRS_Activity_Bartender_The_Boat_Clean_Up_Bg_Crowd.wav",
        "Sounds/LZ_vocal_group_prismizer_chords_120_C.wav"
    ]
    var players:[AudioPlayer] = []
    
    init() {
        
        soundStub.forEach { sound in
            let snd = AudioSource(sound)
            let buffer = snd.sourceBuffer
            let player = AudioPlayer()
            player.buffer = buffer
            player.isLooping = true
            players.append(player)
            mixer.addInput(player)
        }
        
        engine.output = mixer
        do {
            try engine.start()
        } catch {
            Log("AudioKit did not start! \(error)")
        }
        
        players.forEach { player in
            player.play()
        }

    }
    
}

class Track {
    
    
    
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
