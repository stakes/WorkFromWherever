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
        
        engine.output = mixer
        do {
            try engine.start()
        } catch {
            Log("AudioKit did not start! \(error)")
        }
        
//        soundStub.forEach { sound in
//            addTrack(sound)
//        }
//
//        players.forEach { p in
//            p.play()
//        }


    }
    
    func addTrack(_ track:Track) {
        players.append(track.player)
        mixer.addInput(track.player)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            track.player.start()
        }
    }
    
    func createAndAddTrack(_ path:String) {
        let track = Track(path: path)
        players.append(track.player)
        
        mixer.addInput(track.player)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            track.player.start()
        }

    }
    
}

class Track:ObservableObject {
    let player = AudioPlayer()
    
    @Published var volume: Float = 0.5 {
        didSet {
            player.volume = volume
        }
    }
    
    init(path:String) {
        let snd = AudioSource(path)
        try! player.load(url: snd.fileUrl!)
        player.isLooping = true
        player.volume = volume
    }
}

struct AudioSource {
    var audioFile: AVAudioFile?
    var sourceBuffer: AVAudioPCMBuffer?
    var fileUrl: URL?
    init(_ file: String) {
        guard let url = Bundle.main.resourceURL?.appendingPathComponent(file) else { return }
        fileUrl = url
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
