//
//  TrackView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 3/15/21.
//

import SwiftUI

struct TrackView: View {
    var soundManager:SoundManager
    @ObservedObject var content:ContentViewModel
    @State var track:Track
    @State var sound:Sound
    
    init(soundManager:SoundManager, content:ContentViewModel, sound:Sound) {
        self.soundManager = soundManager
        self.content = content
        _sound = /*State<Sound>*/.init(initialValue: sound)
        _track = .init(initialValue: Track(sound: sound))
        soundManager.addTrack(track)
//        print("Creating Fader for \(sound.path)")
    }

    var body: some View {
        VStack {
            FaderView(content: content, sound: $sound, value: $track.volume, label: self.sound.title)
//            HStack {
//                Text(sound.title).font(.system(size: 11, design: .monospaced)).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center).padding(.horizontal, 12)
//            }.frame(height: 42, alignment: .top)
        }.onDisappear() {
            soundManager.removeTrack(self.track)
        }
    }
}

//struct TrackView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackView()
//    }
//}