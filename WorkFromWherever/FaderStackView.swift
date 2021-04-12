//
//  FaderStackView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 3/15/21.
//

import SwiftUI

struct FaderStackView: View {
    let soundManager:SoundManager
    @ObservedObject var channelListViewModel:ChannelListViewModel
    @Binding var selectedChannelIndex:Int
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                Image("speaker")
                ForEach (channelListViewModel.channelList.channels[selectedChannelIndex].sounds ?? []) { sound in
                    TrackView(soundManager: soundManager, channelListViewModel: channelListViewModel, channel: channelListViewModel.channelList.channels[selectedChannelIndex], sound: sound)
                }
                MasterVolumeView()
            }
        }
    }
}

//struct FaderStackView_Previews: PreviewProvider {
//    static var previews: some View {
//        FaderStackView()
//    }
//}
