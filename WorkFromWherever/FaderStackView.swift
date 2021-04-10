//
//  FaderStackView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 3/15/21.
//

import SwiftUI

struct FaderStackView: View {
    let soundManager:SoundManager
    @ObservedObject var cvm:ContentViewModel
    @State var channels:[Channel]
    @Binding var selectedChannelIndex:Int
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                Image("speaker")
                ForEach (channels[selectedChannelIndex].sounds ?? []) { sound in
                    TrackView(soundManager: soundManager, cvm: cvm, channel: channels[selectedChannelIndex], sound: sound)
                }
            }
        }
    }
}

//struct FaderStackView_Previews: PreviewProvider {
//    static var previews: some View {
//        FaderStackView()
//    }
//}
