//
//  ContentLoader.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 5/31/21.
//

import Foundation

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
