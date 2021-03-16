//
//  Track.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/22/21.
//

import Foundation
//import AudioKit
import AVFoundation

class Track:ObservableObject {
    var filePath:String?
    let player = AVAudioPlayerNode()
    
    @Published var volume: CGFloat = 0.0 {
        didSet {
            print(volume)
            player.volume = Float(volume)
        }
    }
    
    init(path:String) {
        filePath = path
    }
    
    func play() {
        let snd = AudioSource(filePath!)
        player.scheduleFile(snd.audioFile!, at: nil, completionHandler: nil)
        player.volume = Float(volume)
        player.play(at: nil)
    }
}

struct AudioSource {
    var audioFile: AVAudioFile?
//    var sourceBuffer: AVAudioPCMBuffer?
    var fileUrl: URL?
    
    init(_ file: String) {
        guard let url = Bundle.main.resourceURL?.appendingPathComponent(file) else { return }
        fileUrl = url
        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            print("Could not load: \(file)")
        }
//        do {
//            sourceBuffer = try AVAudioPCMBuffer(file: audioFile!)
//        } catch {
//            print("Could not buffer: \(file)")
//        }
    }
}
