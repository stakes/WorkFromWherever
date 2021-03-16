//
//  TrackView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 3/15/21.
//

import SwiftUI

struct TrackView: View {
    var soundManager:SoundManager
    @State var track:Track
    @State var sound:Sound
    
    init(soundManager:SoundManager, sound:Sound) {
        self.soundManager = soundManager
        _sound = /*State<Sound>*/.init(initialValue: sound)
        _track = .init(initialValue: Track(path: sound.path))
        soundManager.addTrack(track)
        print("Creating Fader for \(sound.path)")
    }

    var body: some View {
        VStack {
            FaderView(value: $track.volume)
//            Text(sound.title)
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
