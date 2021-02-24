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

    var tracks:[Track] = []
    var players:[AudioPlayer] = []
    
    init() {
        engine.output = mixer
        do {
            try engine.start()
        } catch {
            Log("AudioKit did not start! \(error)")
        }
    }
    
    func addTrack(_ track:Track) {
        print("add \(track)")
        print(mixer.connections)
        tracks.append(track)
        mixer.addInput(track.player)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            track.player.start()
        }
    }
    
    func createAndAddTrack(_ path:String) {
        let track = Track(path: path)
        tracks.append(track)
        mixer.addInput(track.player)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            track.player.start()
        }
    }
    
    func removeAllTracks() {
        mixer.removeAllInputs()
        tracks = []
        players = []
    }
    
}


