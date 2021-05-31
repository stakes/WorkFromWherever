//
//  ContentView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI

struct ContentView: View {
    let soundManager:SoundManager = SoundManager()
    var channelListViewModel = ChannelListViewModel()
    @State var selectedChannelIndex = 0
    var body: some View {
        VStack {
            SelectorView(soundManager: soundManager, channelListViewModel: channelListViewModel, selectedChannelIndex: $selectedChannelIndex)
            FaderStackView(soundManager: soundManager, channelListViewModel: channelListViewModel, selectedChannelIndex: $selectedChannelIndex).padding(0).padding(.top, -8)
        }.background(Color("backgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
