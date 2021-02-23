//
//  Track.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/22/21.
//

import Foundation
import AudioKit
import AVFoundation

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
