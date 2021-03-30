//
//  ContentView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI

struct Content: Codable {
    var channels: [Channel]?
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
        else { return Content(channels: channelData) }

        return preferences
    }
    
    static func write(content: Content) {
        let encoder = PropertyListEncoder()

        if let data = try? encoder.encode(content) {
            if FileManager.default.fileExists(atPath: plistURL.path) {
                // Update an existing plist
                try? data.write(to: plistURL)
            } else {
                // Create a new plist
                FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
            }
        }
    }
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

let appData = ContentLoader.load()

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
