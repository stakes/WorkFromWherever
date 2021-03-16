//
//  Track.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/22/21.
//

import Foundation
import AVFoundation

class Track:ObservableObject {
    var filePath:String?
    let player = AVAudioPlayerNode()
    
    @Published var volume: CGFloat = 1.0 {
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
        if let file = snd.audioFile {
            player.scheduleFile(file, at: nil, completionHandler: nil)
            player.volume = Float(volume)
            player.play(at: nil)
            player.scheduleBuffer(snd.sourceBuffer!, at: nil, options:AVAudioPlayerNodeBufferOptions.loops)
        }
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
//
//
//let file = try AVAudioFile(forReading: url)
//let audioFileBuffer = AVAudioPCMBuffer(PCMFormat: file.fileFormat, frameCapacity: file.length)
//try? read(into buffer: audioFileBuffer )
//audioFilePlayer.scheduleBuffer(audioFileBuffer, atTime: nil, options:.Loops, completionHandler: nil)
//audioFilePlayer.play()
