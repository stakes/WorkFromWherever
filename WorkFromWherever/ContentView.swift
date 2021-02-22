//
//  ContentView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI

struct Sound {
    var title: String
}

struct Place: Identifiable {
    var id = UUID()
    var title: String
    var sounds: [Sound]?
}

struct ContentView: View {
    
    var places:[Place] = [
        Place(title: "Coffee Shop"),
        Place(title: "Office"),
        Place(title: "Bar"),
        Place(title: "Airport Lounge")
    ]
    
    var body: some View {
        NavigationView {
            Sidebar(places: places)
            ZStack {
                MainView(place: places[0])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Sidebar: View {
    @State var places:[Place]
    var body: some View {
        List {
            Group {
                Text("Work from the").foregroundColor(.gray)
                
            }
            ForEach (places) { place in
                NavigationLink(destination: MainView(place: place)) {
                    Text(place.title)
                }
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 192, idealWidth: 192, maxWidth: 256, maxHeight: .infinity)
        .toolbar{
            //Toggle Sidebar Button
            ToolbarItem(placement: .navigation){
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.left")
                })
            }
        }
    }
}

struct MainView: View {
    
    @State var place:Place
    
    var body: some View {
        ZStack {
            Text(place.title)
        }
    }
}

// Toggle Sidebar Function
func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}
