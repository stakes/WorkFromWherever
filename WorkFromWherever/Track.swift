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
    var filePath:String?
    let player = AVAudioPlayerNode()
    
    @Published var volume: Float = 0.5 {
        didSet {
            player.volume = volume
        }
    }
    
    init(path:String) {
        filePath = path
    }
    
    func play() {
        let snd = AudioSource(filePath!)
        player.scheduleFile(snd.audioFile!, at: nil, completionHandler: nil)
        player.play(at: nil)
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
