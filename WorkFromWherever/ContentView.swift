//
//  ContentView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI

struct Sound: Hashable {
    var title: String
}

struct Place: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var places: [Place]?
}

let placeData:[Place] = [
    Place(title: "Coffee Shop"),
    Place(title: "Office"),
    Place(title: "Bar"),
    Place(title: "Airport Lounge")
]

struct ContentView: View {
    var places = placeData
    var body: some View {
        NavigationView {
            Sidebar(places: places, selectedPlace: places[0])
            ZStack {
                EmptyView()
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
    @State var selectedPlace: Place?
    var body: some View {
        List {
            Group {
                Text("Work from the").foregroundColor(.gray)
                
            }
            ForEach (places) { place in
                NavigationLink(destination: MainView(place: place), tag: place, selection: $selectedPlace) {
                    Text(place.title)
                }.navigationTitle(place.title)
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
        VStack {
            Text(place.title).font(.largeTitle)
            HStack {
                Fader(sound: Sound(title: "Background"))
                Fader(sound: Sound(title: "Ambiance"))
            }
        }.navigationTitle(place.title)
    }
}

func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct Fader: View {
    @State var sound:Sound
    @State private var volume = 50.0
    var body: some View {
        VStack {
            Slider(value: $volume, in: 0...100)
            Text(sound.title)
        }
    }
}
