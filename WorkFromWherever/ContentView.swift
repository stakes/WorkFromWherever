//
//  ContentView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/21/21.
//

import SwiftUI
import Sliders

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
    Sound(title: "background", path: "Sounds/OS_ORG_Field_Atmos_Coffee_House.wav"),
    Sound(title: "foreground", path: "Sounds/BRS_Activity_Bartender_The_Boat_Clean_Up_Bg_Crowd.wav"),
]

let officeSounds = [
    Sound(title: "office vibe", path: "Sounds/OfficeWallaLight_SFXB.128.wav"),
    Sound(title: "printer", path: "Sounds/PrinterPrint_S08OF.407.wav"),
    Sound(title: "clicky keyboard", path: "Sounds/ESM_Computer_Keyboard_Typing_3_Office_Click_Secretary_Working_Homework_Clacking.wav")
]

let barSounds = [
    Sound(title: "music", path: "Sounds/LZ_vocal_group_prismizer_chords_120_C.wav")
]

let planeSounds = [
    Sound(title: "engines", path: "Sounds/AirplaneInterior_SFXB.4192.wav"),
    Sound(title: "people", path: "Sounds/BRS_Crowd_Office_Wardrop_Guy_on_Phone.wav")
]

let placeData:[Place] = [
    Place(title: "Coffee Shop", sounds: coffeeShopSounds),
    Place(title: "Office", sounds: officeSounds),
    Place(title: "Bar", sounds: barSounds),
    Place(title: "Airplane", sounds: planeSounds)
]

struct ContentView: View {
    var places = placeData
    var body: some View {
        VStack {
            SelectorView(places: placeData)
            FaderStack(place: placeData[0]).padding(0).padding(.top, -8)
        }.background(Color("backgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SelectorView: View {
    @State var places:[Place]
//    @State var selectedPlace: Place =
    var body: some View {
        VStack {
            HStack {
                Text(places[0].title).font(.system(.title3, design: .monospaced)).foregroundColor(Color.white).padding(8).padding(.leading, 12).opacity(0.8)
                Spacer()
            }.background(LinearGradient(gradient: Gradient(colors: [Color("screenColorStart"), Color("screenColorStop")]), startPoint: .bottom, endPoint: .top))
            .cornerRadius(8.0)
            .padding(.top, 32)
            .padding(.horizontal)
        }.background(Color("backgroundColor"))
    }
}

//struct Sidebar: View {
//    @State var places:[Place]
//    @State var selectedPlace: Place?
//    var body: some View {
//        List {
//            Group {
//                Text("Work from the").foregroundColor(.gray)
//
//            }
//            ForEach (places) { place in
//                NavigationLink(destination: LinkPresenter { MainView(place: place) }, tag: place, selection: $selectedPlace) {
//                    Text(place.title)
//                }.navigationTitle(place.title)
//            }
//        }
//        .listStyle(SidebarListStyle())
//        .frame(minWidth: 192, idealWidth: 192, maxWidth: 256, maxHeight: .infinity)
//        .toolbar{
//            //Toggle Sidebar Button
//            ToolbarItem(placement: .navigation){
//                Button(action: toggleSidebar, label: {
//                    Image(systemName: "sidebar.left")
//                })
//            }
//        }
//    }
//}

struct FaderStack: View {
    let soundManager = SoundManager()
    @State var place:Place
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                Image("speaker")
                ForEach (place.sounds ?? []) { sound in
                    TrackView(soundManager: soundManager, sound: sound)
                }
            }
        }.navigationTitle(place.title)
    }
}

func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct TrackView: View {
    var soundManager:SoundManager
    @State var track:Track
    @State var sound:Sound
    
    init(soundManager:SoundManager, sound:Sound) {
        self.soundManager = soundManager
        _sound = /*State<Sound>*/.init(initialValue: sound)
        _track = .init(initialValue: Track(path: sound.path))
        soundManager.addTrack(track)
//        print("Creating Fader for \(sound.path)")
    }

    var body: some View {
        VStack {
            FaderView(value: $track.volume)
//            Text(sound.title)
        }
    }
}

struct LinkPresenter<Content: View>: View {
    let content: () -> Content

    @State private var invalidated = false
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        Group {
            if self.invalidated {
                EmptyView()
            } else {
                content()
            }
        }
        .onDisappear { self.invalidated = true }
    }
}
