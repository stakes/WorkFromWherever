//
//  SelectorView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 3/13/21.
//

import SwiftUI

struct SelectorView: View {
    var soundManager: SoundManager
    @State var channelListViewModel:ChannelListViewModel
    @Binding var selectedChannelIndex:Int
    var body: some View {
        VStack {
            HStack {
                Text(channelListViewModel.channelList.channels[selectedChannelIndex].title).font(.system(.title3, design: .monospaced)).foregroundColor(.white).padding(8).padding(.leading, 12).opacity(0.8)
                Spacer()
                
                
                Button(action: {
                    if (self.selectedChannelIndex > 0) {
                        self.soundManager.removeAllTracks()
                        self.selectedChannelIndex -= 1
                    } else {
                        self.soundManager.removeAllTracks()
                        self.selectedChannelIndex = channelListViewModel.channelList.channels.count-1
                    }

                }) {
                    Image(systemName: "chevron.left")
                        .padding(8)
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                }.buttonStyle(PlainButtonStyle())
                Button(action: {
                    if (self.selectedChannelIndex < channelListViewModel.channelList.channels.count-1) {
                        self.soundManager.removeAllTracks()
                        self.selectedChannelIndex += 1
                    } else {
                        self.soundManager.removeAllTracks()
                        self.selectedChannelIndex = 0
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .padding(8)
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                }.buttonStyle(PlainButtonStyle())
                .padding(.trailing, 8)
                
            }.background(LinearGradient(gradient: Gradient(colors: [Color("screenColorStart"), Color("screenColorStop")]), startPoint: .bottom, endPoint: .top))
            .cornerRadius(8.0)
            .padding(.top, 32)
            .padding(.horizontal)
        }.background(Color("backgroundColor"))
    }
}

//struct SelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectorView(channels: channelData, selectedChannelIndex: .constant(0))
//    }
//}
