//
//  ContentView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI

struct Sound: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var path: String
}

struct Place: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var sounds: [Sound]?
}

let coffeeShopSounds = [
    Sound(title: "background", path: "Sounds/OS_ORG_Field_Atmos_Coffee_House.wav"),
    Sound(title: "foreground", path: "Sounds/BRS_Activity_Bartender_The_Boat_Clean_Up_Bg_Crowd.wav"),
    Sound(title: "music", path: "Sounds/LZ_vocal_group_prismizer_chords_120_C.wav")
]

let placeData:[Place] = [
    Place(title: "Coffee Shop"),
    Place(title: "Office"),
    Place(title: "Bar"),
    Place(title: "Airport Lounge")
]

struct ContentView: View {
    var sm = SoundMachine()
    var places = placeData
    var body: some View {
        NavigationView {
            Sidebar(soundMachine: sm, places: places, selectedPlace: places[0])
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
    var soundMachine:SoundMachine
    @State var places:[Place]
    @State var selectedPlace: Place?
    var body: some View {
        List {
            Group {
                Text("Work from the").foregroundColor(.gray)
                
            }
            ForEach (places) { place in
                NavigationLink(destination: MainView(soundMachine: soundMachine, place: place), tag: place, selection: $selectedPlace) {
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
    var soundMachine:SoundMachine
    @State var place:Place
    var body: some View {
        VStack {
            Text(place.title).font(.largeTitle)
            HStack {
                ForEach (coffeeShopSounds) { sound in
                    Fader(soundMachine: soundMachine, sound: sound)
                }
            }
        }.navigationTitle(place.title)
    }
}

func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct Fader: View {
    var soundMachine:SoundMachine
    @State var track:Track
    @State var sound:Sound
    @State private var volume = 0.5
    
    init(soundMachine:SoundMachine, sound:Sound) {
        self.soundMachine = soundMachine
        _sound = /*State<Sound>*/.init(initialValue: sound)
        _track = .init(initialValue: Track(path: sound.path))
        soundMachine.addTrack(track)
    }

    var body: some View {
        VStack {
            
            Slider(value: $track.volume, in: 0...1)
            Text(sound.title)
        }
    }
}
