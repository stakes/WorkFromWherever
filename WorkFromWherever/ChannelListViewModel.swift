//
//  ChannelListViewModel.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 5/31/21.
//

import Foundation

class ChannelListViewModel: ObservableObject {
    @Published var channelList: ChannelList {
        didSet {
            ContentLoader.write(channelList: channelList)
        }
    }
    init() {
        self.channelList = ContentLoader.load()
    }
    func update(channel: Channel, sound: Sound, volume: CGFloat) {
        let channelIndex = channelList.channels.firstIndex { $0.title == channel.title }!
        let soundIndex = (channelList.channels[channelIndex].sounds?.firstIndex { $0.title == sound.title })!
        self.channelList.channels[channelIndex].sounds?[soundIndex].volume = volume
    }
}
