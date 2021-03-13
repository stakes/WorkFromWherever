//
//  WorkFromWhereverApp.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI

//final class AppDelegate: NSObject, NSApplicationDelegate {
//    func applicationDidFinishLaunching(_ notification: Notification) {
//        if let window = NSApplication.shared.windows.first {
//            window.titlebarAppearsTransparent = true
//            window.backgroundColor = NSColor.white
//        }
//    }
//}

@main
struct WorkFromWhereverApp: App {
//    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 540, height: 240)
                .background(Color("backgroundColor"))
        }
    }
}
