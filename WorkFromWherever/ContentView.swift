//
//  ContentView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI

struct Content: Codable {
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



//class ContentViewModel: ObservableObject {
//    @Published var content: Content
//    init(_ content: Content) {
//        self.content = content
//    }
//    func updateVolumeForSound(channel: Channel, sound: Sound, value: CGFloat) {
//        // should probably do this in a safer way
//        let channelIndex = content.channels.firstIndex { $0.title == channel.title }!
//        let soundIndex = (content.channels[channelIndex].sounds?.firstIndex { $0.title == sound.title })!
//        content.channels[channelIndex].sounds?[soundIndex].volume = value
//        ContentLoader.write(content: content)
//    }
//}

class ContentViewModel: ObservableObject {
    @Published var content: Content
    init(_ content: Content) {
        self.content = content
    }
}



class ContentLoader {
    static private var plistURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("content.plist")
    }

    static func load() -> Content {
        let decoder = PropertyListDecoder()

        guard let data = try? Data.init(contentsOf: plistURL),
            let preferences = try? decoder.decode(Content.self, from: data)
        else {
            let content = Content(channels: channelData)
            ContentLoader.write(content: content)
            return content
        }
        return preferences
    }
    
    static func write(content: Content) {
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(content) {
            print(data)
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

let appData = ContentLoader.load()

struct ContentView: View {
    let soundManager:SoundManager = SoundManager()
    var cvm = ContentViewModel(appData)
    @State var selectedChannelIndex = 0
    var body: some View {
        VStack {
            SelectorView(channels: cvm.content.channels, selectedChannelIndex: $selectedChannelIndex)
            FaderStackView(soundManager: soundManager, cvm: cvm, channels: cvm.content.channels, selectedChannelIndex: $selectedChannelIndex).padding(0).padding(.top, -8)
        }.background(Color("backgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
