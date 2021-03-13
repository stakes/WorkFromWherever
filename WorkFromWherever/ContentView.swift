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
//        VerticalSliderExamplesView()
//            .environmentObject(model)
        NavigationView {
            Sidebar(places: places, selectedPlace: places[0])
//                .background(Color(NSColor.textBackgroundColor))
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
                NavigationLink(destination: LinkPresenter { MainView(place: place) }, tag: place, selection: $selectedPlace) {
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
    let soundManager = SoundManager()
    @State var place:Place
    var body: some View {
        VStack {
            Text(place.title).font(.largeTitle)
            HStack {
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
        print("Creating Fader for \(sound.path)")
    }

    var body: some View {
        VStack {
//            Slider(value: $track.volume, in: 0...1)
            FaderView(value: $track.volume)
            Text(sound.title)
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

//
//struct VerticalSliderExamplesView: View {
//    @EnvironmentObject var model: Model
//
//    var body: some View {
//        ScrollView(.horizontal) {
//            HStack {
//                Group {
//                    ValueSlider(value: $model.value1)
//                        .valueSliderStyle(
//                            VerticalValueSliderStyle()
//                        )
//
//                    ValueSlider(value: $model.value2)
//                        .valueSliderStyle(
//                            VerticalValueSliderStyle(thumbSize: CGSize(width: 16, height: 32))
//                        )
//
//                    ValueSlider(value: $model.value3)
//                        .valueSliderStyle(
//                            VerticalValueSliderStyle(track:
//                                LinearGradient(
//                                    gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]),
//                                    startPoint: .bottom, endPoint: .top
//                                )
//                                .frame(width: 8)
//                                .cornerRadius(4)
//                            )
//                        )
//
//                    ValueSlider(value: $model.value4)
//                        .valueSliderStyle(
//                            VerticalValueSliderStyle(
//                                track: LinearGradient(
//                                    gradient: Gradient(colors: [.purple, .blue, .purple]),
//                                    startPoint: .bottom, endPoint: .top
//                                )
//                                .frame(width: 6)
//                                .cornerRadius(3),
//                                thumbSize: CGSize(width: 16, height: 48)
//                            )
//                        )
//                }
//
//                Group {
//                    RangeSlider(range: $model.range1)
//                        .rangeSliderStyle(
//                            VerticalRangeSliderStyle()
//                        )
//
//                    RangeSlider(range: $model.range2)
//                        .rangeSliderStyle(
//                            VerticalRangeSliderStyle(
//                                track:
//                                    VerticalRangeTrack(
//                                        view: Capsule().foregroundColor(.purple),
//                                        mask: Rectangle()
//                                    )
//                                    .background(Capsule().foregroundColor(Color.purple.opacity(0.25)))
//                                    .frame(width: 8),
//                                lowerThumb: Circle().foregroundColor(.purple),
//                                upperThumb: Circle().foregroundColor(.purple),
//                                lowerThumbSize: CGSize(width: 32, height: 32),
//                                upperThumbSize: CGSize(width: 48, height: 48)
//                            )
//                         )
//
//                    RangeSlider(range: $model.range3)
//                        .rangeSliderStyle(
//                            VerticalRangeSliderStyle(
//                                track:
//                                    VerticalRangeTrack(
//                                        view: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top)
//                                    )
//                                    .background(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top).opacity(0.25))
//                                    .frame(width: 8)
//                                    .cornerRadius(4),
//                                lowerThumbSize: CGSize(width: 32, height: 16),
//                                upperThumbSize: CGSize(width: 32, height: 16)
//                            )
//                         )
//
//                    RangeSlider(range: $model.range4)
//                        .frame(width: 64)
//                        .rangeSliderStyle(
//                            VerticalRangeSliderStyle(
//                                track:
//                                    VerticalRangeTrack(
//                                        view: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .bottom, endPoint: .top),
//                                        mask: Rectangle()
//                                    )
//                                    .mask(Ellipse())
//                                    .background(Ellipse().foregroundColor(Color.secondary.opacity(0.25)))
//                                    .overlay(Ellipse().strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
//                                    .padding(.horizontal, 8),
//                                lowerThumbSize: CGSize(width: 64, height: 16),
//                                upperThumbSize: CGSize(width: 64, height: 16)
//                            )
//                         )
//
//                    RangeSlider(range: $model.range5)
//                        .frame(width: 64)
//                        .rangeSliderStyle(
//                            VerticalRangeSliderStyle(
//                                track:
//                                    VerticalRangeTrack(
//                                        view: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .bottom, endPoint: .top),
//                                        mask: Rectangle()
//                                    )
//                                    .background(Color.secondary.opacity(0.25))
//                                    .cornerRadius(16),
//                                lowerThumb: Capsule().foregroundColor(.white).shadow(radius: 3),
//                                upperThumb: Capsule().foregroundColor(.white).shadow(radius: 3),
//                                lowerThumbSize: CGSize(width: 64, height: 32),
//                                upperThumbSize: CGSize(width: 64, height: 32)
//                            )
//                         )
//                }
//            }
//
//        }
//        .padding()
//    }
//}
//
//

