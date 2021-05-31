//
//  Models.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 5/31/21.
//

import Foundation

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
