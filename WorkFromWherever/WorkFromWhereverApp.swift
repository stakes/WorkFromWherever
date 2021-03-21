//
//  WorkFromWhereverApp.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.titlebarAppearsTransparent = true // as stated
                window.titleVisibility = .hidden         // no title - all in content
            window.styleMask.remove(.resizable)
        }
    }
}

@main
struct WorkFromWhereverApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 518)
                .background(Color.blue)
                .edgesIgnoringSafeArea(.all)
                .padding(.top, -32)
        }.windowStyle(DefaultWindowStyle()).windowToolbarStyle(ExpandedWindowToolbarStyle())
    }
}
