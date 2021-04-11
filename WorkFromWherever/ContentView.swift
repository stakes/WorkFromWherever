//
//  ContentView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI

struct ChannelList: Codable {
    var channels: [Channel]
}

struct Channel: Codable, Identifiable {
    var id = UUID()
    var title: String
    var sounds: [Sound]?
}

struct Sound: Codable, Identifiable {
    var id = UUID()
    var title: String
    var path: String
    var volume: CGFloat
}

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


class ContentLoader {
    static private var plistURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("content.plist")
    }

    static func load() -> ChannelList {
        let decoder = PropertyListDecoder()

        guard let data = try? Data.init(contentsOf: plistURL),
            let preferences = try? decoder.decode(ChannelList.self, from: data)
        else {
            let channelList = ChannelList(channels: channelData)
            ContentLoader.write(channelList: channelList)
            return channelList
        }
        return preferences
    }
    
    static func write(channelList: ChannelList) {
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(channelList) {
//            print(data)
            if FileManager.default.fileExists(atPath: plistURL.path) {
                // Update that existing plist
                try? data.write(to: plistURL)
            } else {
                // Create a new plist
                FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
            }
        }
    }
}

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
