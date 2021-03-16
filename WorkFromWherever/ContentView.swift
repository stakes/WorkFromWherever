//
//  ContentView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI
import Sliders

struct Sound: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var path: String
}

struct Channel: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var sounds: [Sound]?
}

let appData = channelData


struct ContentView: View {
    let soundManager:SoundManager = SoundManager()
    var channels = appData
    @State var selectedChannelIndex = 0
    var body: some View {
        VStack {
            SelectorView(channels: channelData, selectedChannelIndex: $selectedChannelIndex)
            FaderStackView(soundManager: soundManager, channels: channelData, selectedChannelIndex: $selectedChannelIndex).padding(0).padding(.top, -8)
        }.background(Color("backgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
