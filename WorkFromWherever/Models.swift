//
//  Models.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 3/29/21.
//

import Foundation

struct Channel: Codable, Identifiable, Hashable {
    var id = UUID()
    var title: String
    var sounds: [Sound]?
}

struct Sound: Codable, Identifiable, Hashable {
    var id = UUID()
    var title: String
    var path: String
    var volume: CGFloat
}
