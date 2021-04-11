//
//  TrackView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 3/15/21.
//

import SwiftUI

struct TrackView: View {
    var soundManager:SoundManager
    @ObservedObject var channelListViewModel:ChannelListViewModel
    @State var track:Track
    @State var sound:Sound
    @State var channel:Channel
    
    init(soundManager:SoundManager, channelListViewModel:ChannelListViewModel, channel:Channel, sound:Sound) {
        self.soundManager = soundManager
        self.channelListViewModel = channelListViewModel
        _channel = /*State<Channel>*/.init(initialValue: channel)
        _sound = /*State<Sound>*/.init(initialValue: sound)
        _track = .init(initialValue: Track(sound: sound))
        soundManager.addTrack(track)
    }

    var body: some View {
        VStack {
            FaderView(channelListViewModel: channelListViewModel, channel: $channel, sound: $sound, value: $track.volume, label: self.sound.title)
        }
    }
}

//struct TrackView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackView()
//    }
//}
