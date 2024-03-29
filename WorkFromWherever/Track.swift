//
//  Track.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/22/21.
//

import Foundation
import AVFoundation

class Track:ObservableObject, Identifiable, Equatable {

//    var filePath:String?
    @Published var sound: Sound
    let player = AVAudioPlayerNode()
    
    @Published var volume: CGFloat {
        didSet {
            player.volume = Float(volume)
        }
    }
    
    init(sound:Sound) {
        self.sound = sound
        self.volume = sound.volume
    }
    
    func play() {
        let snd = AudioSource(sound.path)
        if let file = snd.audioFile {
            player.scheduleFile(file, at: nil, completionHandler: nil)
            player.volume = Float(volume)
            player.play(at: nil)
            player.scheduleBuffer(snd.sourceBuffer!, at: nil, options:AVAudioPlayerNodeBufferOptions.loops)
        }
    }
    
    static func == (lhs: Track, rhs: Track) -> Bool {
        return lhs.sound.id == rhs.sound.id
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
            sourceBuffer = try AVAudioPCMBuffer(pcmFormat: audioFile!.processingFormat, frameCapacity: UInt32(audioFile!.length))
        } catch {
            print("Could not load: \(file)")
            return
        }
        do {
            try audioFile?.read(into: sourceBuffer!)
        } catch {
            print("Couldn't read into buffer")
            return
        }
        
    }
}
